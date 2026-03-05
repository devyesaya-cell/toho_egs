import 'dart:math';
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
            totalArea += (lineDistance * 4) / 10000;
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
        return WorkingSpot(
          status: 0,
          driverID: ref.read(authProvider).currentUser?.uid ?? '',
          fileID: fileIdString,
          spotID: spot.spotID,
          mode: state.selectedMode.name.toUpperCase(),
          totalTime: spot.totalTime,
          akurasi: spot.akurasi,
          deep: spot.deep,
          lat: spot.lat,
          lng: spot.lng,
          alt: spot.alt,
          lastUpdate: spot.lastUpdate,
        );
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
