import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/services/geojson_service.dart';
import '../../core/models/area.dart';
import '../../core/models/contractor.dart';
import '../../core/models/equipment.dart';
import '../../core/models/workfile.dart';
import '../../core/models/working_spot.dart';
import '../../core/state/auth_state.dart';

// Service Provider
final geoJsonServiceProvider = Provider<GeoJsonService>((ref) {
  return GeoJsonService();
});

// State
class WorkfileState {
  final List<Area> areas;
  final List<Contractor> contractors;
  final List<Equipment> equipments;
  final Area? selectedArea;
  final Contractor? selectedContractor;
  final Equipment? selectedEquipment;
  final SystemMode selectedMode;
  final String? selectedSpacing;
  final String? filePath;
  final List<WorkingSpot> parsedSpots;
  final bool isLoading;
  final double? computedArea;
  final WorkFile? workfileToEdit;

  WorkfileState({
    this.areas = const [],
    this.contractors = const [],
    this.equipments = const [],
    this.selectedArea,
    this.selectedContractor,
    this.selectedEquipment,
    this.selectedMode = SystemMode.spot,
    this.selectedSpacing,
    this.filePath,
    this.parsedSpots = const [],
    this.isLoading = false,
    this.computedArea,
    this.workfileToEdit,
  });

  WorkfileState copyWith({
    List<Area>? areas,
    List<Contractor>? contractors,
    List<Equipment>? equipments,
    Area? selectedArea,
    Contractor? selectedContractor,
    Equipment? selectedEquipment,
    bool clearEquipment = false,
    SystemMode? selectedMode,
    String? selectedSpacing,
    String? filePath,
    List<WorkingSpot>? parsedSpots,
    bool? isLoading,
    double? computedArea,
    WorkFile? workfileToEdit,
  }) {
    return WorkfileState(
      areas: areas ?? this.areas,
      contractors: contractors ?? this.contractors,
      equipments: equipments ?? this.equipments,
      selectedArea: selectedArea ?? this.selectedArea,
      selectedContractor: selectedContractor ?? this.selectedContractor,
      selectedEquipment: clearEquipment ? null : (selectedEquipment ?? this.selectedEquipment),
      selectedMode: selectedMode ?? this.selectedMode,
      selectedSpacing: selectedSpacing ?? this.selectedSpacing,
      filePath: filePath ?? this.filePath,
      parsedSpots: parsedSpots ?? this.parsedSpots,
      isLoading: isLoading ?? this.isLoading,
      computedArea: computedArea ?? this.computedArea,
      workfileToEdit: workfileToEdit ?? this.workfileToEdit,
    );
  }
}

// Presenter
class WorkfilePresenter extends Notifier<WorkfileState> {
  @override
  WorkfileState build() {
    return WorkfileState();
  }

  Future<void> loadData(WorkFile? editData) async {
    state = state.copyWith(isLoading: true);
    final repo = ref.read(appRepositoryProvider);
    final areas = await repo.getAllAreas();
    final contractors = await repo.getAllContractors();
    final equipments = await repo.getAllEquipment();

    Area? initArea;
    Contractor? initContractor;
    Equipment? initEquipment;
    SystemMode initMode = SystemMode.spot;
    String? initSpacing;
    double? initAreaSize;

    if (editData != null) {
      try {
        initArea = areas.firstWhere((a) => a.uid == editData.areaID || a.areaName == editData.areaName);
      } catch (_) {}
      try {
        initContractor = contractors.firstWhere((c) => c.name == editData.contractor);
      } catch (_) {}
      try {
        initMode = SystemMode.values.firstWhere((m) => m.stableName == editData.equipment);
      } catch (_) {}
      // Pre-select equipment jika ada equipmentID
      if (editData.equipmentID != null) {
        try {
          initEquipment = equipments.firstWhere((e) => e.uid == editData.equipmentID);
        } catch (_) {}
      }

      if (editData.panjang != null && editData.lebar != null && editData.panjang! > 0 && editData.lebar! > 0) {
        String pStr = editData.panjang == editData.panjang!.toInt().toDouble() ? editData.panjang!.toInt().toString() : editData.panjang.toString();
        String lStr = editData.lebar == editData.lebar!.toInt().toDouble() ? editData.lebar!.toInt().toString() : editData.lebar.toString();
        String candidate = '${pStr}x${lStr}';
        const allowed = ['4x1.87','4x1.5','3x2.5','3x2','2.5x2.5','5x2','6x2','Custom'];
        if (allowed.contains(candidate)) {
            initSpacing = candidate;
        } else {
            initSpacing = 'Custom';
        }
      } else {
        initSpacing = 'Custom';
      }
      initAreaSize = editData.luasArea;
    }

    state = state.copyWith(
      areas: areas,
      contractors: contractors,
      equipments: equipments,
      selectedArea: initArea,
      selectedContractor: initContractor,
      selectedEquipment: initEquipment,
      selectedMode: initMode,
      selectedSpacing: initSpacing,
      computedArea: initAreaSize,
      workfileToEdit: editData,
      isLoading: false,
    );
  }

  void selectArea(Area? area) {
    state = state.copyWith(selectedArea: area);
  }

  void selectContractor(Contractor? contractor) {
    state = state.copyWith(selectedContractor: contractor);
  }

  void selectMode(SystemMode mode) {
    state = state.copyWith(selectedMode: mode);
  }

  void selectEquipment(Equipment? equipment) {
    if (equipment == null) {
      state = state.copyWith(clearEquipment: true);
    } else {
      state = state.copyWith(selectedEquipment: equipment);
    }
  }

  void selectSpacing(String? spacing) {
    state = state.copyWith(selectedSpacing: spacing);
    _calculateArea();
  }

  Future<void> pickFile() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await ref.read(geoJsonServiceProvider).pickGeoJsonFile();
      if (result != null && result.files.isNotEmpty) {
        final path = result.files.single.path!;

        final spots = await ref
            .read(geoJsonServiceProvider)
            .parseGeoJson(path, state.selectedMode);
        state = state.copyWith(filePath: path, parsedSpots: spots);
        _calculateArea();
      }
    } catch (e) {
      print('Error picking file: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _calculateArea() {
    if (state.parsedSpots.isEmpty || state.selectedSpacing == null) {
      state = state.copyWith(computedArea: 0);
      return;
    }

    try {
      final parts = state.selectedSpacing!.split('x');
      if (parts.length == 2) {
        final panjang = double.tryParse(parts[0]) ?? 0;
        final lebar = double.tryParse(parts[1]) ?? 0;

        double area = 0.0;

        if (state.selectedMode == SystemMode.spot) {
          final totalSpot = state.parsedSpots.length;
          // Rumus: totalSpot x (panjang x lebar) / 10000
          area = (totalSpot * (panjang * lebar)) / 10000;
        } else if (state.selectedMode == SystemMode.crumbling) {
          // Calculate distance per spotID
          Map<int, List<WorkingSpot>> groupedSpots = {};
          for (var spot in state.parsedSpots) {
            final id = spot.spotID ?? 0;
            if (!groupedSpots.containsKey(id)) {
              groupedSpots[id] = [];
            }
            groupedSpots[id]!.add(spot);
          }

          double totalArea = 0.0;
          for (var group in groupedSpots.values) {
            double lineDistance = 0.0;
            for (int i = 0; i < group.length - 1; i++) {
              final spot1 = group[i];
              final spot2 = group[i + 1];
              if (spot1.lat != null &&
                  spot1.lng != null &&
                  spot2.lat != null &&
                  spot2.lng != null) {
                lineDistance += _haversineDistance(
                  spot1.lat!,
                  spot1.lng!,
                  spot2.lat!,
                  spot2.lng!,
                );
              }
            }
            // area = (distance x 4) / 10000
            totalArea += (lineDistance * panjang) / 10000;
          }
          area = totalArea;
        }

        state = state.copyWith(computedArea: area);
      }
    } catch (e) {
      print('Error calculating area: $e');
    }
  }

  double _haversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const p = 0.017453292519943295;
    final a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742000 * asin(sqrt(a));
  }

  Future<bool> saveWorkfile() async {
    if (state.selectedArea == null ||
        state.selectedContractor == null ||
        (state.parsedSpots.isEmpty && state.workfileToEdit == null)) {
      return false;
    }

    state = state.copyWith(isLoading: true);
    try {
      final isEdit = state.workfileToEdit != null;
      // Generate or use existing UID for linkage
      final uid = isEdit ? state.workfileToEdit!.uid! : DateTime.now().millisecondsSinceEpoch;
      final fileIdString = uid.toString();

      int finalTotalSpot = isEdit ? (state.workfileToEdit!.totalSpot ?? 0) : 0;

      // 1. Save/Replace Spots FIRST if we have new ones
      if (state.parsedSpots.isNotEmpty) {
        if (isEdit) {
           await ref.read(appRepositoryProvider).deleteWorkingSpotsByFileID(fileIdString);
        }
        final spotsToSave = state.parsedSpots.map((spot) {
          return WorkingSpot(
            status: 0,
            driverID: ref.read(authProvider).currentUser?.uid ?? '',
            fileID: fileIdString,
            spotID: spot.spotID,
            mode: state.selectedMode.stableName,
            totalTime: spot.totalTime,
            akurasi: spot.akurasi,
            deep: spot.deep,
            lat: spot.lat,
            lng: spot.lng,
            alt: spot.alt,
            lastUpdate: spot.lastUpdate,
          );
        }).toList();

        await ref.read(appRepositoryProvider).saveWorkingSpots(spotsToSave);
        finalTotalSpot = spotsToSave.length;
      }

      // 2. Save Workfile
      double panjang = 0;
      double lebar = 0;
      if (state.selectedSpacing != null && state.selectedSpacing != 'Custom') {
        final parts = state.selectedSpacing!.split('x');
        if (parts.length == 2) {
          panjang = double.tryParse(parts[0]) ?? 0;
          lebar = double.tryParse(parts[1]) ?? 0;
        }
      }

      final currentUser = ref.read(authProvider).currentUser;

      final workfile = WorkFile(
        uid: uid,
        areaID: state.selectedArea?.uid,
        areaName: state.selectedArea?.areaName ?? '',
        contractor: state.selectedContractor?.name ?? '',
        equipment: state.selectedMode.stableName,
        status: isEdit ? state.workfileToEdit!.status : 'Open',
        panjang: panjang,
        lebar: lebar,
        luasArea: state.computedArea,
        totalSpot: finalTotalSpot,
        spotDone: isEdit ? state.workfileToEdit!.spotDone : 0,
        createAt: isEdit ? state.workfileToEdit!.createAt : DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        doneAt: state.selectedArea?.targetDone,
        equipmentID: state.selectedEquipment?.uid,
        operatorID: currentUser?.uid,
        companyID: state.selectedContractor?.uid,
      );

      if (isEdit) {
        workfile.id = state.workfileToEdit!.id;
      }

      await ref.read(appRepositoryProvider).saveWorkFile(workfile);

      return true;
    } catch (e) {
      print('Error saving workfile: $e');
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final workfilePresenterProvider =
    NotifierProvider.autoDispose<WorkfilePresenter, WorkfileState>(
      WorkfilePresenter.new,
    );
