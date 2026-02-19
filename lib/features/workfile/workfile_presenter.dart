import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/services/geojson_service.dart';
import '../../core/models/area.dart';
import '../../core/models/contractor.dart';
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
  final Area? selectedArea;
  final Contractor? selectedContractor;
  final SystemMode selectedMode;
  final String? selectedSpacing;
  final String? filePath;
  final List<WorkingSpot> parsedSpots;
  final bool isLoading;
  final double? computedArea;

  WorkfileState({
    this.areas = const [],
    this.contractors = const [],
    this.selectedArea,
    this.selectedContractor,
    this.selectedMode = SystemMode.spot,
    this.selectedSpacing,
    this.filePath,
    this.parsedSpots = const [],
    this.isLoading = false,
    this.computedArea,
  });

  WorkfileState copyWith({
    List<Area>? areas,
    List<Contractor>? contractors,
    Area? selectedArea,
    Contractor? selectedContractor,
    SystemMode? selectedMode,
    String? selectedSpacing,
    String? filePath,
    List<WorkingSpot>? parsedSpots,
    bool? isLoading,
    double? computedArea,
  }) {
    return WorkfileState(
      areas: areas ?? this.areas,
      contractors: contractors ?? this.contractors,
      selectedArea: selectedArea ?? this.selectedArea,
      selectedContractor: selectedContractor ?? this.selectedContractor,
      selectedMode: selectedMode ?? this.selectedMode,
      selectedSpacing: selectedSpacing ?? this.selectedSpacing,
      filePath: filePath ?? this.filePath,
      parsedSpots: parsedSpots ?? this.parsedSpots,
      isLoading: isLoading ?? this.isLoading,
      computedArea: computedArea ?? this.computedArea,
    );
  }
}

// Presenter
class WorkfilePresenter extends Notifier<WorkfileState> {
  @override
  WorkfileState build() {
    return WorkfileState();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    final areas = await ref.read(appRepositoryProvider).getAllAreas();
    final contractors = await ref
        .read(appRepositoryProvider)
        .getAllContractors();
    state = state.copyWith(
      areas: areas,
      contractors: contractors,
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
        final spots = await ref.read(geoJsonServiceProvider).parseGeoJson(path);
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

        final totalSpot = state.parsedSpots.length;
        // Rumus: totalSpot x (panjang x lebar) / 10000
        final area = (totalSpot * (panjang * lebar)) / 10000;
        state = state.copyWith(computedArea: area);
      }
    } catch (e) {
      print('Error calculating area: $e');
    }
  }

  Future<bool> saveWorkfile() async {
    if (state.selectedArea == null ||
        state.selectedContractor == null ||
        state.parsedSpots.isEmpty) {
      return false;
    }

    state = state.copyWith(isLoading: true);
    try {
      // Generate UID for linkage
      final uid = DateTime.now().millisecondsSinceEpoch;
      final fileIdString = uid.toString();

      // Prepare spots
      final spotsToSave = state.parsedSpots.map((spot) {
        spot.fileID = fileIdString;
        spot.status = 0; // Default status 0
        return spot;
      }).toList();

      // 1. Save Spots FIRST
      await ref.read(appRepositoryProvider).saveWorkingSpots(spotsToSave);

      // 2. Save Workfile
      double panjang = 0;
      double lebar = 0;
      if (state.selectedSpacing != null) {
        final parts = state.selectedSpacing!.split('x');
        if (parts.length == 2) {
          panjang = double.tryParse(parts[0]) ?? 0;
          lebar = double.tryParse(parts[1]) ?? 0;
        }
      }

      final workfile = WorkFile(
        uid: uid,
        areaID: state.selectedArea?.id,
        areaName: state.selectedArea?.areaName ?? '',
        contractor: state.selectedContractor?.name ?? '',
        status: 'Open',
        panjang: panjang,
        lebar: lebar,
        luasArea: state.computedArea,
        totalSpot: state.parsedSpots.length,
        spotDone: 0,
        createAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
      );

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
