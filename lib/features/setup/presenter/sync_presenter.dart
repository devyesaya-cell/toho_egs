import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/utils/payload_builder.dart';
import '../../../../core/models/area.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/models/equipment.dart';
import '../../../../core/models/person.dart';
import '../../../../core/models/sync_data_result.dart';
import '../../../../core/models/workfile.dart';
import '../../../../core/models/working_spot.dart';
import '../../../../core/database/database_service.dart';
import 'package:isar_community/isar.dart';
import 'package:flutter/foundation.dart';

// --- State Status Enum ---
// ... (rest of imports remains the same as I'm replacing from line 10)
// Note: I'm only showing the replacement for the import section and the _syncRemoteDatabase method below
// ... (rest of imports remains the same as I'm replacing a block)
enum SyncConnectionStatus {
  idle,
  connecting,
  connected,
  sendingPayload,
  payloadSent,
  error,
}

// --- Log Model ---
class SyncLog {
  final DateTime timestamp;
  final bool isSuccess;
  final int spotsCount;
  final String? errorMessage;

  SyncLog({
    required this.timestamp,
    required this.isSuccess,
    required this.spotsCount,
    this.errorMessage,
  });
}

class SyncState {
  final SyncConnectionStatus status;
  final String statusText;
  final double progress;
  final List<SyncLog> logs;
  final int? activeUploadId;
  final double uploadProgress;

  /// Epoch seconds of the last time getWorkfile() was called. Used for 5s cooldown.
  final int? lastGetWorkfileTime;

  const SyncState({
    this.status = SyncConnectionStatus.idle,
    this.statusText = 'Waiting to start...',
    this.progress = 0.0,
    this.logs = const [],
    this.activeUploadId,
    this.uploadProgress = 0.0,
    this.lastGetWorkfileTime,
  });

  /// Returns true if the GET WORK button is still within the 5-second cooldown.
  bool get isGetWorkfileCooldown {
    if (lastGetWorkfileTime == null) return false;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return (now - lastGetWorkfileTime!) < 5;
  }

  SyncState copyWith({
    SyncConnectionStatus? status,
    String? statusText,
    double? progress,
    List<SyncLog>? logs,
    int? activeUploadId,
    double? uploadProgress,
    bool clearUploadId = false,
    int? lastGetWorkfileTime,
    bool clearGetWorkfileTime = false,
  }) {
    return SyncState(
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      progress: progress ?? this.progress,
      logs: logs ?? this.logs,
      activeUploadId: clearUploadId
          ? null
          : (activeUploadId ?? this.activeUploadId),
      uploadProgress: uploadProgress ?? this.uploadProgress,
      lastGetWorkfileTime: clearGetWorkfileTime
          ? null
          : (lastGetWorkfileTime ?? this.lastGetWorkfileTime),
    );
  }
}

class SyncPresenter extends Notifier<SyncState> {
  late final ComService _comService;
  bool _isDisposed = false;

  @override
  SyncState build() {
    _comService = ref.watch(comServiceProvider.notifier);

    // Watch for WebSocket connection drops automatically from ComService state
    ref.listen<UsbState>(comServiceProvider, (previous, next) {
      if (_isDisposed) return;
      if (previous?.isWsConnected == true && next.isWsConnected == false) {
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Disconnected from Host network',
          progress: 0.0,
        );
      }

      // Handle incoming WebSocket data
      if (next.wsData != null && next.wsData != previous?.wsData) {
        _handleIncomingWsData(next.wsData);
      }
    });

    ref.onDispose(() {
      _isDisposed = true;
      // Wrap in microtask to avoid modifying other providers (ComService)
      // synchronously during the dispose phase of this provider.
      Future.microtask(() => _comService.disconnectWebSocket());
    });

    return const SyncState();
  }

  Future<void> startSync() async {
    state = state.copyWith(
      status: SyncConnectionStatus.connecting,
      statusText: 'Connecting to Host Network...',
      progress: 0.2,
    );

    final success = await _comService.connectToHostWebSocket();

    if (!success) {
      if (!_isDisposed) {
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Failed to connect. Are you on the Host Hotspot?',
          progress: 0.0,
        );
      }
      return;
    }

    if (!_isDisposed) {
      state = state.copyWith(
        status: SyncConnectionStatus.connected,
        statusText: 'Connected to Host!',
        progress: 0.5,
      );
    }

    // Prepare data by generating pending sync results
    final auth = ref.read(authProvider);
    final driverID = auth.currentUser?.uid;
    if (driverID != null) {
      await ref.read(appRepositoryProvider).generatePendingSyncData(driverID);
    }
  }

  Future<void> sendPayloadForShift(SyncDataResult syncData) async {
    if (_isDisposed) return;

    if (!ref.read(comServiceProvider).isWsConnected) {
      state = state.copyWith(
        status: SyncConnectionStatus.error,
        statusText: 'Please connect to Host first.',
      );
      return;
    }

    state = state.copyWith(
      activeUploadId: syncData.id,
      uploadProgress: 0.1,
      status: SyncConnectionStatus.sendingPayload,
      statusText: 'Querying Data...',
      progress: 0.6,
    );

    try {
      final appRepo = ref.read(appRepositoryProvider);
      final driverID = syncData.driverID;

      if (driverID == null || driverID.isEmpty) {
        throw Exception('No active user found in SyncDataResult');
      }

      // 2. Fetch Workingspots specific to this shift
      final spots = await appRepo.getWorkingSpotsByShiftTime(
        driverID,
        syncData.shiftTime!,
      );

      if (spots.isEmpty) {
        if (!_isDisposed) {
          state = state.copyWith(
            status: SyncConnectionStatus.payloadSent,
            statusText: 'No records to send for this shift',
            progress: 1.0,
            clearUploadId: true,
          );
        }
        return;
      }

      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Resolving IDs for ${spots.length} Records...',
          progress: 0.7,
          uploadProgress: 0.3,
        );
      }

      // --- NEW ID RESOLUTION LOGIC ---
      int companyID = 0;
      int operatorID = 0;
      int areaID = 0;
      int equipmentID = 0;

      // Helper to extract the last 4 characters (2 bytes) from a 24-character hex UID
      // and convert it to an integer ID.
      int extract(String? uid, String label) {
        if (uid == null || uid.length < 4) {
          debugPrint(
            "ID Extraction [$label]: Input null or too short ('$uid') -> 0",
          );
          return 0;
        }
        // Ambil 4 karakter terakhir (2 byte hexa)
        final last4Hex = uid.substring(uid.length - 4);
        // Konversi string hexa ke integer
        final value = int.tryParse(last4Hex, radix: 16);
        debugPrint(
          "ID Extraction [$label]: UID='$uid' -> Last4Hex='$last4Hex' -> IntValue=$value",
        );
        return value ?? 0;
      }

      // Default fallback if workfile doesn't have it
      operatorID = extract(driverID, 'Operator');

      // b. Resolve WorkFile to get related entities
      final fileIDStr = spots.first.fileID;
      debugPrint("Sync Progress: resolving fileIDStr='$fileIDStr'");
      if (fileIDStr != null) {
        final fileIDInt = int.tryParse(fileIDStr);
        if (fileIDInt != null) {
          final workfile = await appRepo.getWorkFileByUid(fileIDInt);
          if (workfile != null) {
            debugPrint(
              "Sync Progress: Found WorkFile (areaID: ${workfile.areaID}, companyID: ${workfile.companyID}, equipID: ${workfile.equipmentID}, operatorID: ${workfile.operatorID})",
            );

            // Extract IDs directly from WorkFile
            if (workfile.operatorID != null) {
              operatorID = extract(workfile.operatorID, 'Operator');
            }
            if (workfile.areaID != null) {
              areaID = extract(workfile.areaID, 'Area');
            }
            if (workfile.equipmentID != null) {
              equipmentID = extract(workfile.equipmentID, 'Equipment');
            }
            if (workfile.companyID != null) {
              companyID = extract(workfile.companyID, 'Company');
            }
          } else {
            debugPrint(
              "Sync Progress ERROR: WorkFile with uid=$fileIDInt not found in DB",
            );
          }
        } else {
          debugPrint(
            "Sync Progress ERROR: Cannot parse fileIDStr '$fileIDStr' to int",
          );
        }
      }

      debugPrint(
        "FINAL RESOLVED IDs -> Op: $operatorID, Area: $areaID, Eq: $equipmentID, Co: $companyID",
      );

      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Sending ${spots.length} Records...',
          progress: 0.8,
          uploadProgress: 0.6,
        );
      }

      // Sort spots by lastUpdate before calculation (Isar findAll may return unsorted)
      spots.sort((a, b) => (a.lastUpdate ?? 0).compareTo(b.lastUpdate ?? 0));

      // --- CALCULATE WORKHOURS & ACCURACY (as requested from dashboard logic) ---
      double workHoursSeconds = 0;
      double totalAccuracy = 0;
      if (spots.length > 1) {
        for (int i = 0; i < spots.length - 1; i++) {
          final current = spots[i];
          final next = spots[i + 1];
          if (current.lastUpdate != null && next.lastUpdate != null) {
            // lastUpdate is in seconds, so diff is in seconds
            final diff = next.lastUpdate! - current.lastUpdate!;
            // Only count sequential time gaps between 1s and 300s
            if (diff > 0 && diff <= 300) {
              workHoursSeconds += diff;
            }
          }
        }
      }
      for (var spot in spots) {
        totalAccuracy += (spot.akurasi ?? 0);
      }
      final double averageAccuracy = spots.isNotEmpty
          ? totalAccuracy / spots.length
          : 0;

      // 3. Build ByteArray Payload
      final payloadBytes = PayloadBuilder.buildSyncPayload(
        workHours: workHoursSeconds.toInt(),
        workingSpots: spots,
        avgAccuracy: averageAccuracy,
        operatorID: operatorID,
        areaID: areaID,
        equipmentID: equipmentID,
        companyID: companyID,
      );

      state = state.copyWith(uploadProgress: 0.8);

      // 4. Send via WebSocket (raw)
      _comService.sendRawDataToHost(payloadBytes);

      // Simulate a UI progress loop to give user feedback about sending (for 1-2 sec)
      for (int i = 80; i <= 100; i += 2) {
        if (_isDisposed) return;
        await Future.delayed(const Duration(milliseconds: 30));
        state = state.copyWith(uploadProgress: i / 100.0);
      }

      // Update SyncDataResult status but leave WorkingSpots as it is
      syncData.status = 'sent';
      syncData.syncTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await appRepo.updateSyncDataResult(syncData);

      if (!_isDisposed) {
        final newLog = SyncLog(
          timestamp: DateTime.now(),
          isSuccess: true,
          spotsCount: spots.length,
        );
        state = state.copyWith(
          status: SyncConnectionStatus.payloadSent,
          statusText: 'Payload sent successfully!',
          progress: 1.0,
          logs: [newLog, ...state.logs],
          clearUploadId: true,
          uploadProgress: 0.0,
        );
      }
    } catch (e) {
      if (!_isDisposed) {
        final newLog = SyncLog(
          timestamp: DateTime.now(),
          isSuccess: false,
          spotsCount: 0,
          errorMessage: e.toString(),
        );
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Failed to sync: $e',
          progress: 0.75,
          logs: [newLog, ...state.logs],
          clearUploadId: true,
          uploadProgress: 0.0,
        );
      }
    }
  }

  Future<void> syncDatabase() async {
    final isConnected = ref.read(comServiceProvider).isWsConnected;
    if (!isConnected) {
      state = state.copyWith(statusText: 'Please connect first');
      return;
    }
    state = state.copyWith(statusText: 'Requesting Database Sync...');
    _comService.sendString('sync_database');
  }

  Future<void> getWorkfile() async {
    final isConnected = ref.read(comServiceProvider).isWsConnected;
    if (!isConnected) {
      state = state.copyWith(statusText: 'Please connect first');
      return;
    }
    // Cooldown guard: only allow once every 5 seconds
    if (state.isGetWorkfileCooldown) {
      final remaining =
          5 -
          (DateTime.now().millisecondsSinceEpoch ~/ 1000 -
              state.lastGetWorkfileTime!);
      state = state.copyWith(
        statusText: 'Please wait ${remaining}s before requesting again...',
      );
      return;
    }
    final nowEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    state = state.copyWith(
      statusText: 'Requesting Workfile...',
      lastGetWorkfileTime: nowEpoch,
    );
    _comService.sendString('get_workfile');
  }

  Future<void> _handleIncomingWsData(dynamic data) async {
    if (_isDisposed) return;

    if (data is Map<String, dynamic>) {
      debugPrint("WebSocket Map Received. Keys: ${data.keys.toList()}");
      // Log key fields for debugging
      debugPrint(
        "  -> command: ${data['command']}, status: ${data['status']}, type: ${data['type']}",
      );

      // --- [1] Deteksi response get_workfile (sync_workfile) ---
      // Support both 'command' == 'sync_workfile' AND 'type' == 'sync_workfile' for flexibility
      final isWorkfileSync =
          (data['command'] == 'sync_workfile' ||
              data['type'] == 'sync_workfile') &&
          (data['status'] == 'success' || data['status'] == null);
      if (isWorkfileSync) {
        debugPrint("sync_workfile payload detected. Processing...");
        await _handleWorkfileSync(data);
        return;
      }

      // --- [2] Deteksi database sync (Area/Contractor/Person/Equipment) ---
      // Safe null/cast check: data['data'] must be a Map before casting
      final dataPayload = data['data'];
      final hasSyncData =
          dataPayload is Map &&
          dataPayload.keys.any((k) {
            return k == 'Area' ||
                k == 'Contractor' ||
                k == 'Person' ||
                k == 'Equipment';
          });

      if (hasSyncData) {
        debugPrint("Sync data payload detected. Starting sync...");
        await _syncRemoteDatabase(data);
        return;
      }

      // Unknown map — log full content for debugging
      debugPrint("Unhandled Map payload. Full content: $data");
    }

    final message = data.toString();
    // Display a concise summary instead of raw data to prevent UI overflow
    final displayMessage = (data is Map || data is List)
        ? 'JSON Data Received (${message.length} chars)'
        : (message.length > 50 ? '${message.substring(0, 47)}...' : message);

    state = state.copyWith(
      statusText: 'Server: $displayMessage',
      logs: [
        SyncLog(
          timestamp: DateTime.now(),
          isSuccess: true,
          spotsCount: 0,
          errorMessage: 'Response: $displayMessage',
        ),
        ...state.logs,
      ],
    );
  }

  /// Handles the `sync_workfile` response from the Host.
  /// Generates a local epoch-based UID (NOT from payload) and saves WorkFile + WorkingSpots.
  Future<void> _handleWorkfileSync(Map<String, dynamic> rootData) async {
    if (_isDisposed) return;
    try {
      // === DEBUG: Log raw structure ===
      debugPrint(
        '=== _handleWorkfileSync RAW ROOT KEYS: ${rootData.keys.toList()} ===',
      );
      final rawDataValue = rootData['data'];
      debugPrint(
        '=== rootData[data] runtimeType: ${rawDataValue.runtimeType} ===',
      );
      debugPrint('=== rootData[data] value: $rawDataValue ===');

      final dataMap = rootData['data'] as Map<String, dynamic>? ?? {};
      debugPrint('=== dataMap keys: ${dataMap.keys.toList()} ===');

      final workfileRaw = dataMap['workfile'];
      debugPrint(
        '=== dataMap[workfile] runtimeType: ${workfileRaw?.runtimeType} ===',
      );
      debugPrint('=== dataMap[workfile] value: $workfileRaw ===');

      final workingResultsRaw = dataMap['working_results'];
      debugPrint(
        '=== dataMap[working_results] runtimeType: ${workingResultsRaw?.runtimeType} ===',
      );
      debugPrint('=== dataMap[working_results] value: $workingResultsRaw ===');

      final workfileJson = workfileRaw as Map<String, dynamic>?;
      final workingResultsJson = workingResultsRaw as List? ?? [];

      if (workfileJson == null) {
        debugPrint(
          '=== ERROR: workfile key missing or null. Available dataMap keys: ${dataMap.keys.toList()} ===',
        );
        throw Exception(
          'Payload missing \'workfile\' data. dataMap keys=${dataMap.keys.toList()}',
        );
      }

      // Generate UID from local epoch time — NOT from payload uid field
      final int generatedUid = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final String fileIDStr = generatedUid.toString();
      debugPrint('_handleWorkfileSync: generated uid=$generatedUid');

      // Get current driverID to stamp on each WorkingSpot
      final auth = ref.read(authProvider);
      final currentDriverID = auth.currentUser?.uid;
      debugPrint('_handleWorkfileSync: currentDriverID=$currentDriverID');

      // Parse WorkFile — use generated uid, ignore payload uid
      // Use (as num?)?.toInt() for int fields to safely handle both int & double from JSON
      final workFile = WorkFile(
        uid: generatedUid,
        areaName: workfileJson['areaName'] as String?,
        panjang: (workfileJson['panjang'] as num?)?.toDouble(),
        lebar: (workfileJson['lebar'] as num?)?.toDouble(),
        luasArea: (workfileJson['luasArea'] as num?)?.toDouble(),
        contractor: workfileJson['contractor'] as String?,
        equipment: workfileJson['equipment'] as String?,
        totalSpot: (workfileJson['totalSpot'] as num?)?.toInt(),
        spotDone: (workfileJson['spotDone'] as num?)?.toInt(),
        status: workfileJson['status'] as String?,
        createAt: (workfileJson['createAt'] as num?)?.toInt(),
        lastUpdate: (workfileJson['lastUpdate'] as num?)?.toInt(),
        doneAt: (workfileJson['doneAt'] as num?)?.toInt(),
        equipmentID: workfileJson['equipmentID']?.toString(),
        operatorID: workfileJson['operatorID']?.toString(),
        areaID: workfileJson['areaID']?.toString(),
        companyID: workfileJson['companyID']?.toString(),
      );
      debugPrint(
        '_handleWorkfileSync: WorkFile parsed => areaName=${workFile.areaName}, totalSpot=${workFile.totalSpot}',
      );

      // Parse WorkingSpots BEFORE saving anything (atomic: parse all, then save)
      final List<WorkingSpot> spots = [];
      for (int i = 0; i < workingResultsJson.length; i++) {
        final json = workingResultsJson[i];
        debugPrint(
          '_handleWorkfileSync: working_results[$i] runtimeType=${json.runtimeType}, value=$json',
        );
        if (json is Map<String, dynamic>) {
          final spot = WorkingSpot.fromJson(json);
          spot.fileID = fileIDStr; // Enforce local uid linkage
          // Stamp driverID from logged-in user if not already set in payload
          if (spot.driverID == null && currentDriverID != null) {
            spot.driverID = currentDriverID;
          }
          debugPrint(
            '_handleWorkfileSync: spot[$i] => spotID=${spot.spotID}, driverID=${spot.driverID}, fileID=${spot.fileID}, status=${spot.status}',
          );
          spots.add(spot);
        } else {
          debugPrint(
            '_handleWorkfileSync: skipping non-Map entry[$i] in working_results: ${json.runtimeType}',
          );
        }
      }

      debugPrint(
        '_handleWorkfileSync: parsed ${spots.length} spots from ${workingResultsJson.length} entries.',
      );

      // Save to Isar — all parsing is done, now commit to DB
      final appRepo = ref.read(appRepositoryProvider);
      await appRepo.saveWorkFile(workFile);
      if (spots.isNotEmpty) {
        await appRepo.saveWorkingSpots(spots);
      }

      debugPrint(
        '_handleWorkfileSync: saved WorkFile uid=$generatedUid, ${spots.length} spots.',
      );

      // Activity log on success
      if (!_isDisposed) {
        final areaName = workFile.areaName ?? 'Unknown Area';
        final logMsg =
            'Workfile "$areaName" diterima — uid: $generatedUid, ${spots.length} spot disimpan.';
        state = state.copyWith(
          statusText: 'Workfile Received!',
          clearGetWorkfileTime: true, // Reset cooldown setelah berhasil
          logs: [
            SyncLog(
              timestamp: DateTime.now(),
              isSuccess: true,
              spotsCount: spots.length,
              errorMessage: logMsg,
            ),
            ...state.logs,
          ],
        );
      }
    } catch (e) {
      debugPrint('_handleWorkfileSync ERROR: $e');
      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Gagal menyimpan Workfile: $e',
          logs: [
            SyncLog(
              timestamp: DateTime.now(),
              isSuccess: false,
              spotsCount: 0,
              errorMessage: 'Workfile Sync Error: $e',
            ),
            ...state.logs,
          ],
        );
      }
    }
  }

  List? _getPayload(Map<String, dynamic> data, List<String> variations) {
    for (var v in variations) {
      if (data.containsKey(v) && data[v] is List) {
        debugPrint("Found payload key: '$v' with ${data[v].length} items");
        return data[v] as List;
      }
    }
    return null;
  }

  Future<void> _syncRemoteDatabase(Map<String, dynamic> rootData) async {
    try {
      final isar = DatabaseService().isar;
      if (!isar.isOpen) throw Exception("Isar database is not open");

      // Decode the blueprint structure: data object contains the collections
      final data = rootData['data'] as Map<String, dynamic>? ?? {};

      // Buffers for parsed data
      final List<Area> parsedAreas = [];
      final List<Contractor> parsedContractors = [];
      final List<Equipment> parsedEquipments = [];
      final List<Person> parsedPersons = [];

      // 1. Parse Areas
      final areaList = _getPayload(data, ['Area', 'areas', 'Areas']);
      if (areaList != null) {
        if (areaList.isNotEmpty && areaList.first is Map) {
          debugPrint(
            "Area Sync Sample: ${Area.fromJson(areaList.first as Map<String, dynamic>).toMap()}",
          );
        }
        for (var json in areaList) {
          if (json is Map<String, dynamic>) {
            try {
              final area = Area.fromJson(json);
              if (area.uid != null) parsedAreas.add(area);
            } catch (e) {
              debugPrint("Error parsing Area item: $e");
            }
          }
        }
      }

      // 2. Parse Contractors
      final contractorList = _getPayload(data, [
        'Contractor',
        'contractors',
        'Contractors',
      ]);
      if (contractorList != null) {
        if (contractorList.isNotEmpty && contractorList.first is Map) {
          debugPrint(
            "Contractor Sync Sample: ${Contractor.fromJson(contractorList.first as Map<String, dynamic>).toMap()}",
          );
        }
        for (var json in contractorList) {
          if (json is Map<String, dynamic>) {
            try {
              final contractor = Contractor.fromJson(json);
              if (contractor.uid != null) parsedContractors.add(contractor);
            } catch (e) {
              debugPrint("Error parsing Contractor item: $e");
            }
          }
        }
      }

      // 3. Parse Equipments
      final equipmentList = _getPayload(data, [
        'Equipment',
        'equipments',
        'Equipments',
      ]);
      if (equipmentList != null) {
        if (equipmentList.isNotEmpty && equipmentList.first is Map) {
          debugPrint(
            "Equipment Sync Sample: ${Equipment.fromJson(equipmentList.first as Map<String, dynamic>).toMap()}",
          );
        }
        for (var json in equipmentList) {
          if (json is Map<String, dynamic>) {
            try {
              final equipment = Equipment.fromJson(json);
              if (equipment.uid != null) parsedEquipments.add(equipment);
            } catch (e) {
              debugPrint("Error parsing Equipment item: $e");
            }
          }
        }
      }

      // 4. Parse Persons
      final personList = _getPayload(data, [
        'Person',
        'persons',
        'Persons',
        'people',
      ]);
      if (personList != null) {
        if (personList.isNotEmpty && personList.first is Map) {
          debugPrint(
            "Person Sync Sample: ${Person.fromJson(personList.first as Map<String, dynamic>).toMap()}",
          );
        }
        for (var json in personList) {
          if (json is Map<String, dynamic>) {
            try {
              final person = Person.fromJson(json);
              if (person.uid != null) parsedPersons.add(person);
            } catch (e) {
              debugPrint("Error parsing Person item: $e");
            }
          }
        }
      }

      // ACTIVE SAVE MODE: Commit the buffers to Isar
      int newCount = 0;
      int skippedCount = 0;

      await isar.writeTxn(() async {
        // Save Areas
        for (var area in parsedAreas) {
          final existing = await isar.areas
              .filter()
              .uidEqualTo(area.uid)
              .findFirst();
          if (existing == null) {
            await isar.areas.put(area);
            newCount++;
          } else {
            skippedCount++;
          }
        }

        // Save Contractors
        for (var contractor in parsedContractors) {
          final existing = await isar.contractors
              .filter()
              .uidEqualTo(contractor.uid)
              .findFirst();
          if (existing == null) {
            await isar.contractors.put(contractor);
            newCount++;
          } else {
            skippedCount++;
          }
        }

        // Save Equipments
        for (var equipment in parsedEquipments) {
          final existing = await isar.equipments
              .filter()
              .uidEqualTo(equipment.uid)
              .findFirst();
          if (existing == null) {
            await isar.equipments.put(equipment);
            newCount++;
          } else {
            skippedCount++;
          }
        }

        // Save Persons
        for (var person in parsedPersons) {
          final existing = await isar.persons
              .filter()
              .uidEqualTo(person.uid)
              .findFirst();
          if (existing == null) {
            await isar.persons.put(person);
            newCount++;
          } else {
            skippedCount++;
          }
        }
      });

      final summary =
          'Sync Success: $newCount records added ($skippedCount existing skipped).';
      debugPrint("FINAL SYNC SUMMARY: $summary");

      state = state.copyWith(
        statusText: 'Database Synchronized!',
        logs: [
          SyncLog(
            timestamp: DateTime.now(),
            isSuccess: true,
            spotsCount: 0,
            errorMessage: summary,
          ),
          ...state.logs,
        ],
      );
    } catch (e) {
      debugPrint("CRITICAL SYNC ERROR: $e");
      state = state.copyWith(
        statusText: 'Sync Failed: Database Error',
        logs: [
          SyncLog(
            timestamp: DateTime.now(),
            isSuccess: false,
            spotsCount: 0,
            errorMessage: 'Sync Error: $e',
          ),
          ...state.logs,
        ],
      );
    }
  }
}

final syncPresenterProvider =
    NotifierProvider.autoDispose<SyncPresenter, SyncState>(SyncPresenter.new);
