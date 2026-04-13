import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/utils/payload_builder.dart';
import '../../../../core/models/area.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/models/equipment.dart';
import '../../../../core/models/person.dart';
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

// --- Specific State Class ---
class SyncState {
  final SyncConnectionStatus status;
  final String statusText;
  final double progress;
  final List<SyncLog> logs;

  const SyncState({
    this.status = SyncConnectionStatus.idle,
    this.statusText = 'Waiting to start...',
    this.progress = 0.0,
    this.logs = const [],
  });

  SyncState copyWith({
    SyncConnectionStatus? status,
    String? statusText,
    double? progress,
    List<SyncLog>? logs,
  }) {
    return SyncState(
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      progress: progress ?? this.progress,
      logs: logs ?? this.logs,
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

    // Automatically trigger test payload on successful connection
    _sendWorkingspotPayload();
  }

  Future<void> _sendWorkingspotPayload() async {
    if (_isDisposed) return;

    state = state.copyWith(
      status: SyncConnectionStatus.sendingPayload,
      statusText: 'Querying Data...',
      progress: 0.6,
    );

    try {
      final appRepo = ref.read(appRepositoryProvider);

      // 1. Get logged in person directly from authProvider
      final auth = ref.read(authProvider);
      final driverID = auth.currentUser?.uid;

      if (driverID == null || driverID.isEmpty) {
        throw Exception('No active user found in session');
      }

      // 2. Fetch Workingspots for sync based on shift
      final currentTime = DateTime.now();
      final spots = await appRepo.getWorkingSpotsForSync(driverID, currentTime);

      if (spots.isEmpty) {
        if (!_isDisposed) {
          state = state.copyWith(
            status: SyncConnectionStatus.payloadSent,
            statusText: 'No records to send for current shift',
            progress: 1.0,
          );
        }
        return;
      }

      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Resolving IDs for ${spots.length} Records...',
          progress: 0.7,
        );
      }

      // --- NEW ID RESOLUTION LOGIC ---
      int companyID = 0;
      int operatorID = 0;
      int areaID = 0;
      int equipmentID = 0;

      // Helper to extract last 4 digits from UID string (supports hex)
      int extract(String? uid, String label) {
        if (uid == null || uid.length < 4) {
          debugPrint("ID Extraction [$label]: Input null or too short ('$uid') -> 0");
          return 0;
        }
        final last4 = uid.substring(uid.length - 4);
        // Try parsing as hex first (radix 16) since sample was hex
        final value = int.tryParse(last4, radix: 16);
        debugPrint("ID Extraction [$label]: UID='$uid' -> Last4='$last4' -> IntValue=$value");
        return value ?? 0;
      }

      // a. Operator ID from current user
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
                "Sync Progress: Found WorkFile (area: ${workfile.areaName}, contractor: ${workfile.contractor}, equip: ${workfile.equipment})");

            // c. Resolve Contractor
            if (workfile.contractor != null) {
              final contractor =
                  await appRepo.getContractorByName(workfile.contractor!);
              if (contractor != null) {
                companyID = extract(contractor.uid, 'Contractor');
              } else {
                debugPrint(
                    "Sync Progress WARNING: Contractor '${workfile.contractor}' not found in DB");
              }
            }

            // d. Resolve Area
            if (workfile.areaName != null) {
              final area = await appRepo.getAreaByName(workfile.areaName!);
              if (area != null) {
                areaID = extract(area.uid, 'Area');
              } else {
                debugPrint(
                    "Sync Progress WARNING: Area '${workfile.areaName}' not found in DB");
              }
            }

            // e. Resolve Equipment
            if (workfile.equipment != null) {
              final equipment =
                  await appRepo.getEquipmentByName(workfile.equipment!);
              if (equipment != null) {
                equipmentID = extract(equipment.uid, 'Equipment');
              } else {
                debugPrint(
                    "Sync Progress WARNING: Equipment '${workfile.equipment}' not found in DB");
              }
            }
          } else {
            debugPrint(
                "Sync Progress ERROR: WorkFile with uid=$fileIDInt not found in DB");
          }
        } else {
          debugPrint("Sync Progress ERROR: Cannot parse fileIDStr '$fileIDStr' to int");
        }
      }

      debugPrint(
          "FINAL RESOLVED IDs -> Op: $operatorID, Area: $areaID, Eq: $equipmentID, Co: $companyID");

      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Sending ${spots.length} Records...',
          progress: 0.8,
        );
      }

      // 3. Build ByteArray Payload
      final payloadBytes = PayloadBuilder.buildSyncPayload(
        packageId: 0,
        workingSpots: spots,
        operatorID: operatorID,
        areaID: areaID,
        equipmentID: equipmentID,
        companyID: companyID,
      );

      // 4. Send via WebSocket (raw)
      _comService.sendRawDataToHost(payloadBytes);

      // Simulate a slight delay for UI impact
      await Future.delayed(const Duration(milliseconds: 500));

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
    state = state.copyWith(statusText: 'Requesting Workfile...');
    _comService.sendString('get_workfile');
  }

  Future<void> _handleIncomingWsData(dynamic data) async {
    if (_isDisposed) return;

    if (data is Map<String, dynamic>) {
      debugPrint("WebSocket Map Received. Keys: ${data.keys.toList()}");
      // Check for any of the 4 databases with flexible naming using the blueprint keys
      final hasSyncData = data.containsKey('data') && (data['data'] as Map).keys.any((k) {
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
    }

    final message = data.toString();
    // debugPrint("WebSocket Message Received: $message");

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
              "Area Sync Sample: ${Area.fromJson(areaList.first as Map<String, dynamic>).toMap()}");
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
      final contractorList =
          _getPayload(data, ['Contractor', 'contractors', 'Contractors']);
      if (contractorList != null) {
        if (contractorList.isNotEmpty && contractorList.first is Map) {
          debugPrint(
              "Contractor Sync Sample: ${Contractor.fromJson(contractorList.first as Map<String, dynamic>).toMap()}");
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
      final equipmentList =
          _getPayload(data, ['Equipment', 'equipments', 'Equipments']);
      if (equipmentList != null) {
        if (equipmentList.isNotEmpty && equipmentList.first is Map) {
          debugPrint(
              "Equipment Sync Sample: ${Equipment.fromJson(equipmentList.first as Map<String, dynamic>).toMap()}");
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
      final personList =
          _getPayload(data, ['Person', 'persons', 'Persons', 'people']);
      if (personList != null) {
        if (personList.isNotEmpty && personList.first is Map) {
          debugPrint(
              "Person Sync Sample: ${Person.fromJson(personList.first as Map<String, dynamic>).toMap()}");
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
          final existing =
              await isar.areas.filter().uidEqualTo(area.uid).findFirst();
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
          final existing =
              await isar.persons.filter().uidEqualTo(person.uid).findFirst();
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
