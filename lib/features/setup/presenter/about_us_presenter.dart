import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/database/database_service.dart';
import '../../../core/models/workfile.dart';
import '../../../core/models/working_spot.dart';
import '../../../core/state/auth_state.dart';

class AboutUsState {
  final bool isLoading;
  final List<WorkFile> workfiles;
  final WorkFile? selectedWorkfile;
  final String? statusMessage;
  final bool isSuccess;

  AboutUsState({
    this.isLoading = false,
    this.workfiles = const [],
    this.selectedWorkfile,
    this.statusMessage,
    this.isSuccess = false,
  });

  AboutUsState copyWith({
    bool? isLoading,
    List<WorkFile>? workfiles,
    WorkFile? selectedWorkfile,
    String? statusMessage,
    bool? isSuccess,
  }) {
    return AboutUsState(
      isLoading: isLoading ?? this.isLoading,
      workfiles: workfiles ?? this.workfiles,
      selectedWorkfile: selectedWorkfile ?? this.selectedWorkfile,
      statusMessage: statusMessage ?? this.statusMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class AboutUsNotifier extends Notifier<AboutUsState> {
  @override
  AboutUsState build() {
    _loadWorkfiles();
    return AboutUsState(isLoading: true);
  }

  Future<void> _loadWorkfiles() async {
    try {
      final isar = DatabaseService().isar;
      final workfiles = await isar.workFiles.where().findAll();
      state = state.copyWith(isLoading: false, workfiles: workfiles);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        statusMessage: "Gagal memuat workfile: $e",
      );
    }
  }

  void selectWorkfile(WorkFile? workfile) {
    state = state.copyWith(
      selectedWorkfile: workfile,
      statusMessage: null,
      isSuccess: false,
    );
  }

  Future<void> exportGeoJson() async {
    final selectedWorkfile = state.selectedWorkfile;
    if (selectedWorkfile == null) {
      state = state.copyWith(
        statusMessage: "Pilih Workfile terlebih dahulu.",
        isSuccess: false,
      );
      return;
    }

    final currentUser = ref.read(authProvider).currentUser;
    if (currentUser == null || currentUser.uid == null) {
      state = state.copyWith(
        statusMessage: "Operator belum login atau UID tidak ditemukan.",
        isSuccess: false,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      statusMessage: "Memproses export GeoJSON...",
      isSuccess: false,
    );

    try {
      // Request Permissions
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        state = state.copyWith(
          isLoading: false,
          statusMessage: "Izin penyimpanan ditolak.",
          isSuccess: false,
        );
        return;
      }

      // Query WorkingSpots
      final isar = DatabaseService().isar;
      final fileIDStr = selectedWorkfile.uid.toString();
      final driverIDStr = currentUser.uid!;

      final spots = await isar.workingSpots
          .filter()
          .fileIDEqualTo(fileIDStr)
          .and()
          .driverIDEqualTo(driverIDStr)
          .and()
          .statusEqualTo(1)
          .findAll();

      if (spots.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          statusMessage:
              "Tidak ada data Workingspot yang selesai (status=1) untuk Workfile ini.",
          isSuccess: false,
        );
        return;
      }

      // Build GeoJSON FeatureCollection
      final features = <Map<String, dynamic>>[];
      for (int i = 0; i < spots.length; i++) {
        final spot = spots[i];
        if (spot.lng == null || spot.lat == null) continue;

        final feature = {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [spot.lng, spot.lat],
          },
          "properties": {
            "fileID": spot.fileID,
            "operatorID": selectedWorkfile.operatorID,
            "companyID": selectedWorkfile.companyID,
            "areaID": selectedWorkfile.areaID,
            "equipmentID": selectedWorkfile.equipmentID,
            "status": 1,
            "accuracy": spot.akurasi,
            "spotID": spot.spotID ?? i,
            "color": "green",
            "lastUpdate": spot.lastUpdate ?? "",
          },
        };
        features.add(feature);
      }

      final geoJson = {"type": "FeatureCollection", "features": features};

      final geoJsonString = jsonEncode(geoJson);

      // Setup Save Directory
      final downloadDir = Directory('/storage/emulated/0/Download/TohoEGS');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final areaNameSafe = (selectedWorkfile.areaName ?? 'UnknownArea')
          .replaceAll(RegExp(r'[^\w\s]+'), '_')
          .replaceAll(' ', '_');
      final operatorNameSafe = (currentUser.fullname ?? currentUser.firstName ?? 'UnknownOperator')
          .replaceAll(RegExp(r'[^\w\s]+'), '_')
          .replaceAll(' ', '_');
      final operatorIDSafe = (currentUser.uid ?? '0');
      final equipmentIDSafe = (selectedWorkfile.equipmentID ?? 'UnknownEquip')
          .replaceAll(RegExp(r'[^\w\s]+'), '_');

      final fileName =
          '${areaNameSafe}_${operatorNameSafe}(${operatorIDSafe})_${equipmentIDSafe}.geojson';
      final file = File('${downloadDir.path}/$fileName');

      await file.writeAsString(geoJsonString);

      state = state.copyWith(
        isLoading: false,
        statusMessage: "Berhasil disimpan di: ${file.path}",
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        statusMessage: "Gagal export: $e",
        isSuccess: false,
      );
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 30) {
        // Android 11+
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        return status.isGranted;
      } else {
        // Android 10 and below
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
    }
    return false; // Not supporting other platforms in this specific context
  }
}

final aboutUsProvider = NotifierProvider<AboutUsNotifier, AboutUsState>(
  AboutUsNotifier.new,
);
