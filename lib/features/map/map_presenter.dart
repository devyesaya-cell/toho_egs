import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre/maplibre.dart' as maplibre;
import '../../core/coms/com_service.dart';
import '../../core/models/base_status.dart';
import 'package:toho_egs/core/models/error_alert.dart';
import 'package:toho_egs/core/models/gps_loc.dart';
import '../../core/services/coordinate_service.dart';
import 'package:toho_egs/core/services/notification_service.dart';
import 'package:toho_egs/core/services/notification_service.dart'
    as custom_notif;
import 'package:flutter/material.dart';
import 'package:toho_egs/core/models/working_spot.dart';
import 'package:toho_egs/core/models/workfile.dart';
import 'package:toho_egs/core/models/timesheet_record.dart';
import '../../core/database/database_service.dart';
import '../../core/state/auth_state.dart';
import 'package:isar_community/isar.dart';

// --- State Class ---
class MapState {
  // GPS Data
  final double? currentLat;
  final double? currentLng;
  final double? heading;

  // Base Status Data
  final int satellites;
  final int baseSatellites;
  final String radioStatus;
  final String rtkStatus; // Computed RTK status
  final double batteryVoltage;

  // USB Status
  final bool usbConnected;
  final DateTime? lastDataTime;

  // Errors
  final ErrorAlert? lastError;
  final List<ErrorAlert> errors;

  // Slopes (From GPSLoc)
  final double boomTilt;
  final double stickTilt;
  final double attachTilt;

  // Arm Length
  final double armLength;
  final double armBearing;

  // Full Objects for Dialogs
  final GPSLoc? fullGps;
  final Basestatus? fullBase;

  // Track Logic
  final double trackHeading;
  final double? lastTrackLat;
  final double? lastTrackLng;
  // Work Mode
  final bool isWorkMode;

  // Spot Data
  final int totalSpot;
  final int spotDone;
  final WorkingSpot? targetSpot;
  final double? devX;
  final double? devY;
  final double? targetBearing;

  // Crumbling Data
  final List<WorkingSpot>? targetSegment;
  final double? crumblingDeviation;
  final double crumblingDevSum;
  final int crumblingDevCount;

  // Query Optimization
  final double? lastQueriedExcaLat;
  final double? lastQueriedExcaLng;
  final bool diggingStatus; // New field
  final double spotCompletionDelay;
  final bool autoCompleteEnabled;
  final bool delayTime;

  // Timesheet
  final TimesheetRecord? activeTimesheet;

  MapState({
    this.currentLat,
    this.currentLng,
    this.heading,
    this.satellites = 0,
    this.baseSatellites = 0,
    this.radioStatus = "Waiting...",
    this.rtkStatus = "NO RTK",
    this.batteryVoltage = 0.0,
    this.usbConnected = false,
    this.lastDataTime,
    this.lastError,
    this.boomTilt = 0,
    this.stickTilt = 0,
    this.attachTilt = 0,
    this.armLength = 0.0,
    this.armBearing = 0.0,
    this.fullGps,
    this.fullBase,
    this.trackHeading = 0.0,
    this.lastTrackLat,
    this.lastTrackLng,
    this.isWorkMode = false,
    this.totalSpot = 0,
    this.spotDone = 0,
    this.targetSpot,
    this.devX,
    this.devY,
    this.targetBearing,
    this.targetSegment,
    this.crumblingDeviation,
    this.activeTimesheet,
    this.lastQueriedExcaLat,
    this.lastQueriedExcaLng,
    this.crumblingDevSum = 0.0,
    this.crumblingDevCount = 0,
    this.diggingStatus = false,
    this.errors = const [],
    this.spotCompletionDelay = 1.0,
    this.autoCompleteEnabled = true,
    this.delayTime = false,
  });

  MapState copyWith({
    double? currentLat,
    double? currentLng,
    double? heading,
    int? satellites,
    int? baseSatellites,
    String? radioStatus,
    String? rtkStatus,
    double? batteryVoltage,
    bool? usbConnected,
    DateTime? lastDataTime,
    ErrorAlert? lastError,
    double? boomTilt,
    double? stickTilt,
    double? attachTilt,
    double? armLength,
    double? armBearing,
    GPSLoc? fullGps,
    Basestatus? fullBase,
    double? trackHeading,
    double? lastTrackLat,
    double? lastTrackLng,
    bool? isWorkMode,
    int? totalSpot,
    int? spotDone,
    WorkingSpot? targetSpot,
    double? devX,
    double? devY,
    double? targetBearing,
    List<WorkingSpot>? targetSegment,
    double? crumblingDeviation,
    TimesheetRecord? activeTimesheet,
    double? lastQueriedExcaLat,
    double? lastQueriedExcaLng,
    double? crumblingDevSum,
    int? crumblingDevCount,
    bool? diggingStatus,
    List<ErrorAlert>? errors,
    double? spotCompletionDelay,
    bool? autoCompleteEnabled,
    bool? delayTime,
  }) {
    return MapState(
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      heading: heading ?? this.heading,
      satellites: satellites ?? this.satellites,
      baseSatellites: baseSatellites ?? this.baseSatellites,
      radioStatus: radioStatus ?? this.radioStatus,
      rtkStatus: rtkStatus ?? this.rtkStatus,
      batteryVoltage: batteryVoltage ?? this.batteryVoltage,
      usbConnected: usbConnected ?? this.usbConnected,
      lastDataTime: lastDataTime ?? this.lastDataTime,
      lastError: lastError ?? this.lastError,
      boomTilt: boomTilt ?? this.boomTilt,
      stickTilt: stickTilt ?? this.stickTilt,
      attachTilt: attachTilt ?? this.attachTilt,
      armLength: armLength ?? this.armLength,
      armBearing: armBearing ?? this.armBearing,
      fullGps: fullGps ?? this.fullGps,
      fullBase: fullBase ?? this.fullBase,
      trackHeading: trackHeading ?? this.trackHeading,
      lastTrackLat: lastTrackLat ?? this.lastTrackLat,
      lastTrackLng: lastTrackLng ?? this.lastTrackLng,
      isWorkMode: isWorkMode ?? this.isWorkMode,
      totalSpot: totalSpot ?? this.totalSpot,
      spotDone: spotDone ?? this.spotDone,
      targetSpot: targetSpot ?? this.targetSpot,
      devX: devX ?? this.devX,
      devY: devY ?? this.devY,
      targetBearing: targetBearing ?? this.targetBearing,
      targetSegment: targetSegment ?? this.targetSegment,
      crumblingDeviation: crumblingDeviation ?? this.crumblingDeviation,
      activeTimesheet: activeTimesheet ?? this.activeTimesheet,
      lastQueriedExcaLat: lastQueriedExcaLat ?? this.lastQueriedExcaLat,
      lastQueriedExcaLng: lastQueriedExcaLng ?? this.lastQueriedExcaLng,
      crumblingDevSum: crumblingDevSum ?? this.crumblingDevSum,
      crumblingDevCount: crumblingDevCount ?? this.crumblingDevCount,
      diggingStatus: diggingStatus ?? this.diggingStatus,
      errors: errors ?? this.errors,
      spotCompletionDelay: spotCompletionDelay ?? this.spotCompletionDelay,
      autoCompleteEnabled: autoCompleteEnabled ?? this.autoCompleteEnabled,
      delayTime: delayTime ?? this.delayTime,
    );
  }
}

// --- Presenter ---
class MapPresenter extends Notifier<MapState> {
  StreamSubscription<GPSLoc>? _gpsSub;
  Timer? _paramTimer;
  Timer? _mockSpotTimer;
  Timer? _timesheetTimer;
  List<WorkingSpot> _loadedSpots = [];
  List<WorkingSpot> _cachedNearbySpots = [];
  DateTime? _spotInRangeSince;

  @override
  MapState build() {
    ref.watch(authProvider); // Ensure session isolation & reset on user change
    _subscribe();

    // Check connection status periodically
    _paramTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkConnection();
    });

    ref.onDispose(() {
      _gpsSub?.cancel();
      _paramTimer?.cancel();
      _mockSpotTimer?.cancel();
      _timesheetTimer?.cancel();
    });

    return MapState();
  }

  void _checkConnection() {
    final comState = ref.read(comServiceProvider);
    // Logic: USB Connected AND Recent Data (< 2 seconds)
    bool isReceivingData = false;
    if (state.lastDataTime != null) {
      final diff = DateTime.now().difference(state.lastDataTime!);
      if (diff.inSeconds < 3) {
        isReceivingData = true;
      }
    }

    final isConnected = comState.isConnected && isReceivingData;

    if (state.usbConnected != isConnected) {
      state = state.copyWith(usbConnected: isConnected);
    }
  }

  void toggleWorkMode(maplibre.MapController? controller) {
    final newMode = !state.isWorkMode;
    state = state.copyWith(isWorkMode: newMode);

    if (newMode) {
      // NOTE: Mock data logic is disabled for production.
      // Re-enable below for debugging if needed.
      // _startMocking(controller);
    } else {
      _stopMocking();
    }
  }

  void setSpotCompletionDelay(double seconds) {
    state = state.copyWith(spotCompletionDelay: seconds);
  }

  void setAutoComplete(bool enabled) {
    state = state.copyWith(autoCompleteEnabled: enabled);
  }

  // TODO: PROD_RELEASE: Remove this mock method for production release.
  // void _startMocking(maplibre.MapController? controller) {
  //   if (_mockSpotTimer != null && _mockSpotTimer!.isActive) return;

  //   _mockSpotTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
  //     try {
  //       final auth = ref.read(authProvider);
  //       final activeWorkfile = auth.activeWorkfile;
  //       if (activeWorkfile == null) return;

  //       final fileID = activeWorkfile.uid.toString();

  //       final isar = DatabaseService().isar;

  //       // Ambil spot dengan status 0 (pending) berdasarkan fileID
  //       // Urutkan berdasarkan ID (index terkecil dahulu)
  //       final spots = await isar.workingSpots
  //           .filter()
  //           .fileIDEqualTo(fileID)
  //           .statusEqualTo(0)
  //           .findAll();

  //       if (spots.isEmpty) return;

  //       // Sort explicitly by ID ascending to ensure "index terkecil lebih dahulu"
  //       spots.sort((a, b) => a.id.compareTo(b.id));

  //       // Ambil spot pertama dari hasil filter status 0
  //       final targetSpot = spots.first;

  //       // Jika spot sudah dikerjakan, lewati saja dan lanjut index berikutnya.
  //       // Tapi perintahnya: "ubah status workingspot menjadi 1 mulai dari index pertama".
  //       if (targetSpot.status != 1) {
  //         targetSpot.lastUpdate = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //         targetSpot.status = 1;
  //         targetSpot.akurasi = 4.0 + (math.Random().nextDouble() * 6.0);

  //         await isar.writeTxn(() async {
  //           await isar.workingSpots.put(targetSpot);
  //         });

  //         state = state.copyWith(spotDone: state.spotDone + 1);

  //         // Refresh UI points on map supaya spot jadi hijau (status 1)
  //         if (controller != null) {
  //           loadSpots(controller);
  //         }
  //       }
  //     } catch (e) {
  //       print("Mock Spot Timer Error: \$e");
  //     }
  //   });
  // }

  void _stopMocking() {
    _mockSpotTimer?.cancel();
    _mockSpotTimer = null;
  }

  // --- Timesheet Logic ---
  Future<void> startTimesheet(TimesheetRecord newRecord) async {
    final isar = DatabaseService().isar;
    final auth = ref.read(authProvider);
    newRecord.personID = auth.currentUser?.uid?.toString() ?? '0';
    await isar.writeTxn(() async {
      await isar.timesheetRecords.put(newRecord);
    });

    state = state.copyWith(activeTimesheet: newRecord);

    _timesheetTimer?.cancel();
    _timesheetTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      final currentTs = state.activeTimesheet;
      final auth = ref.read(authProvider);
      final currentWorkfile = auth.activeWorkfile;

      if (currentTs != null && currentWorkfile != null) {
        final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        currentTs.endTime = now;
        currentTs.totalTime = now - currentTs.startTime;
        currentTs.totalSpots = state.spotDone.toDouble();

        // Update personID to current logged in user
        currentTs.personID = auth.currentUser?.uid?.toString() ?? '0';

        // Calculate workspeed: (spot/hours * (panjang * lebar)) / 10000 -> in Ha
        if (currentTs.totalTime > 0) {
          final hours = currentTs.totalTime / 3600.0;
          final spotsPerHour = currentTs.totalSpots / hours;

          final panjang = currentWorkfile.panjang ?? 0.0;
          final lebar = currentWorkfile.lebar ?? 0.0;

          currentTs.workspeed = (spotsPerHour * (panjang * lebar)) / 10000.0;
        }

        await isar.writeTxn(() async {
          await isar.timesheetRecords.put(currentTs);
        });

        // Update state to trigger UI changes if any
        state = state.copyWith(activeTimesheet: currentTs);
      }
    });
  }

  Future<void> stopTimesheet({required double hmEnd}) async {
    _timesheetTimer?.cancel();
    _timesheetTimer = null;

    final currentTs = state.activeTimesheet;
    final auth = ref.read(authProvider);
    final currentWorkfile = auth.activeWorkfile;

    if (currentTs != null && currentWorkfile != null) {
      final isar = DatabaseService().isar;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      currentTs.endTime = now;
      currentTs.hmEnd = hmEnd;
      currentTs.totalTime = now - currentTs.startTime;
      currentTs.totalSpots = state.spotDone.toDouble();
      currentTs.personID = auth.currentUser?.uid?.toString() ?? '0';

      if (currentTs.totalTime > 0) {
        final hours = currentTs.totalTime / 3600.0;
        final spotsPerHour = currentTs.totalSpots / hours;
        final panjang = currentWorkfile.panjang ?? 0.0;
        final lebar = currentWorkfile.lebar ?? 0.0;
        currentTs.workspeed = (spotsPerHour * (panjang * lebar)) / 10000.0;
      }

      currentWorkfile.spotDone = state.spotDone;
      currentWorkfile.lastUpdate = now;
      currentWorkfile.status = 'on progress';

      await isar.writeTxn(() async {
        await isar.timesheetRecords.put(currentTs);
        await isar.workFiles.put(currentWorkfile);
      });

      state = state.copyWith(activeTimesheet: null);
    }
  }

  void _subscribe() {
    final comService = ref.read(comServiceProvider.notifier);

    // GPS Stream
    _gpsSub = comService.gpsStream.listen((gps) async {
      // Calculate Arm Length & Bearing
      final excaObj = Position(gps.bucketLong, gps.bucketLat);
      final attachObj = Position(gps.attachLng, gps.attachLat);

      final dist = _calculate3DDistance(
        gps.boomLat,
        gps.boomLng,
        gps.boomAlt,
        gps.attachLat,
        gps.attachLng,
        gps.attachAlt,
      );

      final bearing = _calc.getBearing(excaObj, attachObj);

      // RTK Logic
      String newRtkStatus = 'FLOAT';
      if (gps.status == 'NO RTK' || gps.status2 == 'NO RTK') {
        newRtkStatus = 'NO RTK';
      } else if (gps.hAcc1 < 25 && gps.hAcc2 < 25) {
        newRtkStatus = 'RTK';
      } else {
        newRtkStatus = 'FLOAT';
      }

      if (state.rtkStatus != newRtkStatus) {
        debugPrint('RTK Status: $newRtkStatus');
        // if (newRtkStatus == 'NO RTK') {
        //   NotificationService.showError('RTK Signal Lost!');
        // } else if (newRtkStatus == 'RTK') {
        //   NotificationService.showSuccess('RTK Fixed');
        // } else if (newRtkStatus == 'FLOAT') {
        //   NotificationService.showWarning('RTK Float Mode');
        // }
      }

      // Track Heading Logic
      double newTrackHeading = state.trackHeading;
      double? newLastTrackLat = state.lastTrackLat;
      double? newLastTrackLng = state.lastTrackLng;

      if (state.lastTrackLat == null || state.lastTrackLng == null) {
        // Initialize
        newTrackHeading = gps.heading;
        newLastTrackLat = gps.bucketLat;
        newLastTrackLng = gps.bucketLong;
      } else {
        final lastPos = Position(state.lastTrackLng!, state.lastTrackLat!);
        final currentPos = Position(gps.bucketLong, gps.bucketLat);
        final dist = _calc.getDistance(lastPos, currentPos);

        if (dist > 2.0) {
          // Moved more than 2 meters, update heading
          newTrackHeading = _calc.getBearing(lastPos, currentPos);
          newLastTrackLat = gps.bucketLat;
          newLastTrackLng = gps.bucketLong;
        }
      }

      WorkingSpot? newTargetSpot;
      double? newDevX;
      double? newDevY;
      double? newTargetBearing;

      if (state.isWorkMode) {
        final excaPos = Position(
          gps.bucketLong,
          gps.bucketLat,
        ); // NOTE: usually bucketLong/Lat refer to machine body in these variable namings.
        final bucketPos = Position(gps.attachLng, gps.attachLat);

        // Mode check for logic branches
        final auth = ref.read(authProvider);
        final systemMode = auth.mode.stableName;

        if (systemMode == 'CRUMBLING') {
          // ==================
          // CRUMBLING LOGIC
          // ==================
          bool shouldQueryNearby = false;
          if (state.lastQueriedExcaLat == null ||
              state.lastQueriedExcaLng == null) {
            shouldQueryNearby = true;
          } else {
            final lastQueryPos = Position(
              state.lastQueriedExcaLng!,
              state.lastQueriedExcaLat!,
            );
            final distFromLastQuery = _calc.getDistance(lastQueryPos, excaPos);
            if (distFromLastQuery > 10.0) {
              // Expand update radius for crumbling
              shouldQueryNearby = true;
            }
          }

          if (shouldQueryNearby) {
            // Find spots within 20m from Exca
            _cachedNearbySpots = _loadedSpots.where((spot) {
              if (spot.status != 0 || spot.lat == null || spot.lng == null)
                return false;
              final spotPos = Position(spot.lng!, spot.lat!);
              return _calc.getDistance(excaPos, spotPos) <= 20.0;
            }).toList();

            state = state.copyWith(
              lastQueriedExcaLat: gps.bucketLat,
              lastQueriedExcaLng: gps.bucketLong,
            );
          }

          // 1. Group by line (spotID) and find the closest Line to Exca (Target Line)
          final Map<int, List<WorkingSpot>> groupedLines = {};
          for (var spot in _cachedNearbySpots) {
            if (spot.spotID != null) {
              groupedLines.putIfAbsent(spot.spotID!, () => []).add(spot);
            }
          }

          List<WorkingSpot>? targetLine;
          double closestLineDist = double.infinity;

          for (var entry in groupedLines.entries) {
            final lineSpots = entry.value;
            lineSpots.sort((a, b) => a.id.compareTo(b.id)); // Ensure order

            // Approximate line distance as min distance to any segment on this line
            double minDistToLine = double.infinity;
            for (int i = 0; i < lineSpots.length - 1; i++) {
              final startPos = Position(lineSpots[i].lng!, lineSpots[i].lat!);
              final endPos = Position(
                lineSpots[i + 1].lng!,
                lineSpots[i + 1].lat!,
              );
              final dist = _calc.distanceToSegment(excaPos, startPos, endPos);
              if (dist < minDistToLine) minDistToLine = dist;
            }

            // If the line only has 1 spot, use direct distance
            if (lineSpots.length == 1) {
              minDistToLine = _calc.getDistance(
                excaPos,
                Position(lineSpots[0].lng!, lineSpots[0].lat!),
              );
            }

            if (minDistToLine < closestLineDist) {
              closestLineDist = minDistToLine;
              targetLine = lineSpots;
            }
          }

          // 2. Find closest segment to Exca from the Target Line (Target Segment)
          List<WorkingSpot>? newTargetSegment;
          double closestSegmentDist = double.infinity;

          if (targetLine != null && targetLine.length >= 2) {
            for (int i = 0; i < targetLine.length - 1; i++) {
              final startPos = Position(targetLine[i].lng!, targetLine[i].lat!);
              final endPos = Position(
                targetLine[i + 1].lng!,
                targetLine[i + 1].lat!,
              );
              final dist = _calc.distanceToSegment(excaPos, startPos, endPos);

              if (dist < closestSegmentDist) {
                closestSegmentDist = dist;
                newTargetSegment = [targetLine[i], targetLine[i + 1]];
              }
            }

            // Per pengguna: batasi agar terdekat ini distance nya tidak lebih dari 3 meter saja dari exca
            if (closestSegmentDist > 3.0) {
              newTargetSegment = null;
            }
          }

          // Variables for holding metrics inside segment
          double? newCrumblingDev;

          if (newTargetSegment != null) {
            // Target segment found. Calculate Deviation from Bucket to Target Segment.
            final segmentStart = Position(
              newTargetSegment[0].lng!,
              newTargetSegment[0].lat!,
            );
            final segmentEnd = Position(
              newTargetSegment[1].lng!,
              newTargetSegment[1].lat!,
            );

            // Raw distance from bucket to the segment
            final distToSegment = _calc.distanceToSegment(
              bucketPos,
              segmentStart,
              segmentEnd,
            );

            // Find closest point on the segment to use for bearing
            final pointOnSegmentX =
                segmentStart.lng + (segmentEnd.lng - segmentStart.lng) / 2;
            final pointOnSegmentY =
                segmentStart.lat + (segmentEnd.lat - segmentStart.lat) / 2;
            // Using a simple midpoint as approximation for bearing direction. Real projection is complex but distance is small.
            final bearingToSegment = _calc.getBearing(
              bucketPos,
              Position(pointOnSegmentX, pointOnSegmentY),
            );

            // Theta: angle difference between Bucket-Target bearing vs Exca Machine Heading
            // This aligns the X,Y coordinates to the direction the machine is facing.
            final thetaRad =
                (bearingToSegment - gps.heading) * (math.pi / 180.0);

            // Left/Right deviation (X): positive is right, negative is left.
            // distToSegment is in meters. We want cm.
            newCrumblingDev = (distToSegment * math.sin(thetaRad)) * 100;

            // TODO: Auto complete logic on segment transition
          }

          // Check if segment transitions inside this update
          List<WorkingSpot>? prevSegment = state.targetSegment;
          double nextSum = state.crumblingDevSum;
          int nextCount = state.crumblingDevCount;

          if (newCrumblingDev != null) {
            nextSum += newCrumblingDev.abs();
            nextCount += 1;
          }

          if (prevSegment != null && newTargetSegment != null) {
            if (prevSegment[0].id != newTargetSegment[0].id ||
                prevSegment[1].id != newTargetSegment[1].id) {
              // EXCA EXITED THE PREVIOUS SEGMENT
              // Update BOTH spots of the segment to status=1 so that Dashboard presenter can match them up and calculate distance

              double avgDev = state.crumblingDevCount > 0
                  ? (state.crumblingDevSum / state.crumblingDevCount)
                  : (newCrumblingDev?.abs() ?? 0.0);

              final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;

              int exactlyNewlyDoneCount = 0;

              final isar = DatabaseService().isar;
              await isar.writeTxn(() async {
                for (var i = 0; i < 2; i++) {
                  var node = prevSegment[i];
                  if (node.status != 1) {
                    // Only update if not already done
                    node.status = 1;
                    node.lastUpdate = nowSec;
                    node.akurasi = avgDev;
                    node.driverID = auth.currentUser?.uid?.toString() ?? '0';
                    await isar.workingSpots.put(node);

                    // Remove from memory
                    _loadedSpots.removeWhere((s) => s.id == node.id);
                    exactlyNewlyDoneCount++;
                  }
                }
              });

              state = state.copyWith(
                spotDone: state.spotDone + exactlyNewlyDoneCount,
              );

              // Reset dev tracking for new segment
              nextSum = newCrumblingDev?.abs() ?? 0.0;
              nextCount = newCrumblingDev != null ? 1 : 0;
            }
          }

          state = state.copyWith(
            targetSegment: newTargetSegment,
            crumblingDeviation: newCrumblingDev,
            crumblingDevSum: nextSum,
            crumblingDevCount: nextCount,
          );
        } else {
          // ==================
          // SPOT LOGIC
          // ==================
          bool shouldQueryNearby = false;
          if (state.lastQueriedExcaLat == null ||
              state.lastQueriedExcaLng == null) {
            shouldQueryNearby = true;
          } else {
            final lastQueryPos = Position(
              state.lastQueriedExcaLng!,
              state.lastQueriedExcaLat!,
            );
            final distFromLastQuery = _calc.getDistance(lastQueryPos, excaPos);
            if (distFromLastQuery > 3.0) {
              shouldQueryNearby = true;
            }
          }

          if (shouldQueryNearby) {
            // Find spots within 15.0m from Exca (using loaded spots)
            _cachedNearbySpots = _loadedSpots.where((spot) {
              if (spot.status != 0 || spot.lat == null || spot.lng == null) {
                return false;
              }
              final spotPos = Position(spot.lng!, spot.lat!);
              final dist = _calc.getDistance(excaPos, spotPos);
              return dist <= 15.0;
            }).toList();

            state = state.copyWith(
              lastQueriedExcaLat: gps.bucketLat,
              lastQueriedExcaLng: gps.bucketLong,
            );
          }

          // 2. Find closest spot to Bucket within 0.5m
          double closestDist = double.infinity;
          for (var spot in _cachedNearbySpots) {
            final spotPos = Position(spot.lng!, spot.lat!);
            final distToBucket = _calc.getDistance(bucketPos, spotPos);
            if (distToBucket <= 0.5 && distToBucket < closestDist) {
              closestDist = distToBucket;
              newTargetSpot = spot;
            }
          }

          if (newTargetSpot != null &&
              newTargetSpot.lat != null &&
              newTargetSpot.lng != null) {
            final targetPos = Position(newTargetSpot.lng!, newTargetSpot.lat!);

            // Calculate Target Bearing relative to EXCAVATOR (As requested)
            newTargetBearing = _calc.getBearing(excaPos, targetPos);

            // Calculate Target Distance & Bearing relative to bucket for DevX/DevY
            final bearing = _calc.getBearing(bucketPos, targetPos);
            final dist = _calc.getDistance(bucketPos, targetPos);

            // Stage 1: Waiting Logic (within 50cm)
            // Note: newTargetSpot is found within 0.5m (50cm) at line 754.
            if (_spotInRangeSince == null) {
              _spotInRangeSince = DateTime.now();
            } else if (!state.delayTime) {
              final elapsed =
                  DateTime.now().difference(_spotInRangeSince!).inMilliseconds /
                  1000.0;
              if (elapsed >= state.spotCompletionDelay) {
                state = state.copyWith(delayTime: true);
              }
            }

            // Stage 2: Accuracy Trigger (within 10cm)
            bool shouldComplete = false;
            if (dist <= 0.1 && state.autoCompleteEnabled && state.delayTime) {
              shouldComplete = true;
            }

            if (shouldComplete) {
              // Update entity
              final spotToSave = newTargetSpot;
              spotToSave.lastUpdate =
                  DateTime.now().millisecondsSinceEpoch ~/ 1000;
              spotToSave.lat = gps.attachLat;
              spotToSave.lng = gps.attachLng;
              spotToSave.status = 1;
              spotToSave.akurasi = dist * 100; // in cm
              spotToSave.driverID = auth.currentUser?.uid?.toString() ?? '0';

              final rand = math.Random();
              spotToSave.deep = 60 + rand.nextInt(21); // 60-80
              spotToSave.alt = 60 + rand.nextInt(21); // 60-80

              // Save to Isar DB
              final isar = DatabaseService().isar;
              await isar.writeTxn(() async {
                await isar.workingSpots.put(spotToSave);
              });

              // Update Memory Map & state counter
              _loadedSpots.removeWhere((s) => s.id == spotToSave.id);
              // Also remove from the nearby cache so the same spot is not
              // picked up again on the next GPS tick (which would re-trigger the notification).
              _cachedNearbySpots.removeWhere((s) => s.id == spotToSave.id);
              // We increment spotDone without full reload for immediate UI feedback.
              // When map moves or refreshes, it will call loadSpots anyway.
              state = state.copyWith(spotDone: state.spotDone + 1);

              // Trigger Map Update immediately so spot turns green
              // (Assuming there is a way to access controller, otherwise it updates next refresh)
              // Ideally we'd trigger a reload event here, but without easy access to the MapController inside Notifier's `_gpsSub`,
              // the user might just see the status increment.
              // The map spots are loaded in `loadSpots` taking the controller.
              // In Flutter Riverpod, best way is to expose a mechanism, or reload next time `loadSpots` is called.

              // Nullify targetSpot so GuidanceWidget flashes back to searching
              newTargetSpot = null;
              newDevX = null;
              newDevY = null;
              newTargetBearing = null;

              // Reset digging status
              state = state.copyWith(diggingStatus: false);
              ref.read(comServiceProvider.notifier).resetDiggingStatus();

              _spotInRangeSince = null;
              state = state.copyWith(delayTime: false);

              // NotificationService.showSuccess('Spot Completed!');
            } else {
              // Theta: angle difference between Bucket-Target bearing vs Exca Machine Heading
              // This aligns the X,Y coordinates to the direction the machine is facing.
              final thetaRad = (bearing - gps.heading) * (math.pi / 180.0);

              // Forward/Backward deviation (Y): positive is forward
              // Left/Right deviation (X): positive is right
              newDevY = dist * math.cos(thetaRad);
              newDevX = dist * math.sin(thetaRad);
            }
          } else {
            // Reset delay state if bucket moves out of 50cm radius
            if (_spotInRangeSince != null || state.delayTime) {
              _spotInRangeSince = null;
              state = state.copyWith(delayTime: false);
            }
          }
        } // End Spot Logic Mode Check
      } // End isWorkMode

      state = state.copyWith(
        currentLat: gps.bucketLat,
        currentLng: gps.bucketLong,
        heading: gps.heading,
        satellites: gps.satelit,
        radioStatus: gps.status,
        rtkStatus: newRtkStatus,
        boomTilt: gps.boomTilt,
        stickTilt: gps.stickTilt,
        attachTilt: gps.attachTilt,
        baseSatellites: gps.satelit2,
        armLength: dist,
        armBearing: bearing,
        fullGps: gps,
        lastDataTime: DateTime.now(), // Update timestamp
        trackHeading: newTrackHeading,
        lastTrackLat: newLastTrackLat,
        lastTrackLng: newLastTrackLng,
        targetSpot: newTargetSpot,
        devX: newDevX,
        devY: newDevY,
        targetBearing: newTargetBearing,
      );
    });

    // Listen for USB digging status
    ref.listen<UsbState>(comServiceProvider, (previous, next) {
      if (next.diggingStatus != state.diggingStatus) {
        state = state.copyWith(diggingStatus: next.diggingStatus);
      }
    });

    // Base Status
    ref.listen<Basestatus?>(bsProvider, (previous, next) {
      if (next != null) {
        state = state.copyWith(
          batteryVoltage: next.batteryVoltage,
          fullBase: next,
          lastDataTime: DateTime.now(),
        );
      }
    });

    // Error Alert
    ref.listen<List<ErrorAlert>>(errorProvider, (previous, next) {
      if (next.isNotEmpty) {
        final latest = next.first;
        if (state.lastError != latest) {
          // Add to local map buffer instead of showing snackbar
          state = state.copyWith(
            lastError: latest,
            errors: [latest, ...state.errors].take(50).toList(),
          );
        }
      }
    });
  }

  void showDiggingNotification(BuildContext context) {
    custom_notif.NotificationService.showCommandNotification(
      context,
      title: 'Digging Status',
      message: 'Spot siap di gali',
      modeStr: 'READY',
      icon: Icons.agriculture,
      iconColor: Colors.greenAccent,
      headerColor: Colors.green.shade900,
    );
  }

  // Calculate 3D Distance between two Lat/Lng/Alt points
  double _calculate3DDistance(
    double lat1,
    double lon1,
    double alt1,
    double lat2,
    double lon2,
    double alt2,
  ) {
    const p = 0.017453292519943295; // pi / 180
    final a =
        0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) /
            2;
    final dist2d = 12742000 * math.asin(math.sqrt(a)); // 2 * R * asin(sqrt(a))

    final heightDiff = (alt1 - alt2).abs();
    // 3D Distance
    return math.sqrt(dist2d * dist2d + heightDiff * heightDiff);
  }

  // --- Excavator Visualization Logic ---

  final _calc = CoordinateService();

  Future<void> addExcavatorLayers(maplibre.MapController controller) async {
    try {
      final style = controller.style;
      if (style == null) return;

      // Initialize empty sources or dummy data to prevent errors before first GPS update
      // Just waiting for the first update is often better, but we need definitions.
      // Let's create empty feature collections.
      final emptyGeoJson = jsonEncode({
        "type": "FeatureCollection",
        "features": [],
      });

      // 0. Spots Source & Layer (Bottom Layer)
      await style.addSource(
        maplibre.GeoJsonSource(id: 'spots_source', data: emptyGeoJson),
      );

      await style.addLayer(
        maplibre.CircleStyleLayer(
          id: 'spots_layer',
          sourceId: 'spots_source',
          paint: {
            'circle-color': [
              'match',
              ['get', 'status'],
              1, '#00FF00', // Status 1 = Green (Done)
              0, '#FF0000', // Status 0 = Red (Todo)
              '#808080', // Default = Grey
            ],
            'circle-radius': [
              'step',
              ['zoom'],
              0.5 /
                  (156543.03392 /
                      math.pow(2, 19.0)), // Set radius for Zoom Out (19.0)
              20.1, // Threshold crossing
              0.5 /
                  (156543.03392 /
                      math.pow(2, 21.2)), // Set radius for Zoom In (21.2)
            ],
            'circle-opacity': 0.8,
          },
          filter: const ['==', r'$type', 'Point'],
        ),
      );

      await style.addLayer(
        const maplibre.LineStyleLayer(
          id: 'crumbling_line_layer',
          sourceId: 'spots_source',
          paint: {
            'line-color': [
              'match',
              ['get', 'status'],
              1, '#00FF00', // Status 1 = Green (Done)
              0, '#FF0000', // Status 0 = Red (Todo)
              '#808080', // Default = Grey
            ],
            'line-width': 5.0,
            'line-opacity': 0.8,
          },
          filter: ['==', r'$type', 'LineString'],
        ),
      );

      // Load initial spots
      loadSpots(controller);

      // 1. Excavator Body/Tracks Source
      await style.addSource(
        maplibre.GeoJsonSource(id: 'exca_body_source', data: emptyGeoJson),
      );

      // 2. Body Layer
      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'exca_body_layer',
          sourceId: 'exca_body_source',
          paint: {'fill-color': '#FBAF00'},
          filter: ['==', 'type', 'body'],
        ),
      );

      // 3. Tracks Layer
      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'exca_tracks_layer',
          sourceId: 'exca_body_source',
          paint: {'fill-color': '#000000'},
          filter: ['==', 'type', 'track'],
        ),
      );

      await style.addSource(
        maplibre.GeoJsonSource(id: 'excavator_source', data: emptyGeoJson),
      );

      // Base (Cockpit Base)
      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'base_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#E78A00'},
          filter: ['==', 'part', 'base'],
        ),
      );

      // Cockpit
      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'cockpit_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#808080'},
          filter: ['==', 'part', 'cockpit'],
        ),
      );

      // Arm
      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'arm_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#808080'},
          filter: ['==', 'part', 'arm'],
        ),
      );

      // Attachment Source & Layer
      await style.addSource(
        maplibre.GeoJsonSource(id: 'attach_source', data: emptyGeoJson),
      );

      await style.addLayer(
        const maplibre.FillStyleLayer(
          id: 'attach_layer',
          sourceId: 'attach_source',
          paint: {'fill-color': '#E78A00'}, // Example color
        ),
      );

      // Guidance Line Source & Layer (Bucket to Target)
      await style.addSource(
        maplibre.GeoJsonSource(id: 'guidance_line_source', data: emptyGeoJson),
      );

      await style.addLayer(
        const maplibre.LineStyleLayer(
          id: 'guidance_line_layer',
          sourceId: 'guidance_line_source',
          paint: {
            'line-color': '#0000FF', // Blue line
            'line-width': 4.0,
            'line-dasharray': [2, 2], // Optional: dashed line
          },
        ),
      );
    } catch (e) {
      print('Error adding excavator layers: $e');
      NotificationService.showError('Failed to initialize map layers');
    }
  }

  Future<void> updateExcavatorPosition(
    maplibre.MapController controller,
    GPSLoc gps,
  ) async {
    final style = controller.style;
    if (style == null) return;
    // Update Body (Tracks)
    await _updateBody(style, gps);
    // Update Upper Structure (Cockpit, Arm)
    await _updateCockpit(style, gps);
    // Update Attachment
    await _updateAttachment(style, gps);
    // Update Guidance Line
    await _updateGuidanceLine(style, gps);
  }

  Future<void> _updateGuidanceLine(
    maplibre.StyleController style,
    GPSLoc gps,
  ) async {
    try {
      final auth = ref.read(authProvider);
      final systemMode = auth.mode.stableName;

      List<List<double>> lineCoords = [];

      if (systemMode == 'CRUMBLING') {
        final targetSegment = state.targetSegment;
        if (targetSegment != null && targetSegment.length == 2) {
          final pt1 = targetSegment[0];
          final pt2 = targetSegment[1];

          if (pt1.lat != null &&
              pt1.lng != null &&
              pt2.lat != null &&
              pt2.lng != null) {
            final excaPos = Position(gps.bucketLong, gps.bucketLat);
            final p1 = Position(pt1.lng!, pt1.lat!);
            final p2 = Position(pt2.lng!, pt2.lat!);

            final d1 = _calc.getDistance(excaPos, p1);
            final d2 = _calc.getDistance(excaPos, p2);

            // Find the closest point in the segment to the excavator body
            final closestPoint = d1 < d2 ? p1 : p2;

            lineCoords = [
              [gps.bucketLong, gps.bucketLat], // Exca body center
              [closestPoint.lng, closestPoint.lat], // Closest spot on segment
            ];
          }
        }
      } else {
        final target = state.targetSpot;
        if (target != null && target.lat != null && target.lng != null) {
          lineCoords = [
            [gps.attachLng, gps.attachLat], // Bucket
            [target.lng!, target.lat!], // Target Spot
          ];
        }
      }

      if (lineCoords.isNotEmpty) {
        final geoJson = {
          "type": "FeatureCollection",
          "features": [
            {
              "type": "Feature",
              "geometry": {"type": "LineString", "coordinates": lineCoords},
              "properties": {},
            },
          ],
        };

        await style.updateGeoJsonSource(
          id: "guidance_line_source",
          data: jsonEncode(geoJson),
        );
      } else {
        // Clear the line
        final emptyGeoJson = {"type": "FeatureCollection", "features": []};
        await style.updateGeoJsonSource(
          id: "guidance_line_source",
          data: jsonEncode(emptyGeoJson),
        );
      }
    } catch (e) {
      print('Error update Guidance Line: $e');
    }
  }

  Future<void> _updateBody(maplibre.StyleController style, GPSLoc gps) async {
    try {
      const double BODY_WIDTH = 1.7;
      const double BODY_LENGTH = 3.0;
      const double TRACK_WIDTH = 0.8;
      const double TRACK_LENGTH = 4.0;

      // Get map bearing to adjust rotation if map rotates (though usually we rotate the polygon coords)
      // Reference logic: `adjustedBearing = gps.heading - mapBearing`.
      // MapLibre polygons are geo-coordinates, so "Rotation" is intrinsic to the coordinates.
      // However, if we want to "rotate" a shape on screen, we change its coords.
      // `mapBearing` is relevant if we are drawing relative to screen, but here we are drawing on earth.
      // The reference implementation subtracts mapBearing probably because it might be using a Symbol layer?
      // NO, it uses FillStyleLayer with Polygon geometry.
      // Polygons defined by LatLngs are absolute. Why subtract mapBearing?
      // Ah, maybe the user rotates the map and the calculation `Offset` methods utilize screen-relative logic?
      // Checking `CoordinateService`: It uses `sin` / `cos` with earth radius. This is GEOGRAPHIC offset.
      // So `heading` should be TRUE NORTH heading.
      // `mapBearing` subtraction is suspicious if we are placing real world coordinates.
      // If the map rotates, the specific LatLngs still point to the same spot.
      // **I will trust the reference logic for now, OR valid geographic logic.**
      // The reference code calculates: `adjustedBearing = gps.heading - mapBearing`.
      // But `_calc.topOffset` uses `gps.heading` directly in lines 236 etc.
      // Only the `properties` get `adjustedBearing`. The polygons use the raw `gps.heading` for offset calculation.
      // -> properties 'bearing' is set to adjusted. Maybe for styling? But FillLayer doesn't use bearing property for rotation.
      // So the Polygon SHAPE is determined by `gps.heading` passed to `_calc`. This is correct for absolute positioning.

      final center = Position(
        gps.bucketLong,
        gps.bucketLat,
      ); // Using bucket as center? Usually center of machine.
      // Reference uses `gps.bucketLong`, `gps.bucketLat` as center.
      // Use calculated Track Heading
      final heading = state.trackHeading;

      // --- Calculate Coordinates ---
      // Body Base
      final frontLeft = _calc.topOffset(
        _calc.leftOffset(center, BODY_WIDTH / 2, heading),
        BODY_LENGTH / 2,
        heading,
      );
      final frontRight = _calc.topOffset(
        _calc.rightOffset(center, BODY_WIDTH / 2, heading),
        BODY_LENGTH / 2,
        heading,
      );
      final backLeft = _calc.bottomOffset(
        _calc.leftOffset(center, BODY_WIDTH / 2, heading),
        BODY_LENGTH / 2,
        heading,
      );
      final backRight = _calc.bottomOffset(
        _calc.rightOffset(center, BODY_WIDTH / 2, heading),
        BODY_LENGTH / 2,
        heading,
      );

      // Tracks
      // Left Track
      // Actually ref logic: `(BODY_WIDTH / 2 + TRACK_WIDTH)` for outer edge?
      // Ref: leftTrackFront = topOffset(leftOffset(..., (BODY_WIDTH/2 + TRACK_WIDTH), ...), TRACK_LENGTH/2, ...)
      // That puts the inner edge at body + track?
      // Let's stick to reference logic exactly to be safe.

      // ... Implementing Reference Logic for Coordinates ...
      final leftTrackFront = _calc.topOffset(
        _calc.leftOffset(center, (BODY_WIDTH / 2 + TRACK_WIDTH), heading),
        TRACK_LENGTH / 2,
        heading,
      );
      final leftTrackBack = _calc.bottomOffset(
        _calc.leftOffset(center, (BODY_WIDTH / 2 + TRACK_WIDTH), heading),
        TRACK_LENGTH / 2,
        heading,
      );

      final rightTrackFront = _calc.topOffset(
        _calc.rightOffset(center, (BODY_WIDTH / 2), heading),
        TRACK_LENGTH / 2,
        heading,
      );
      final rightTrackBack = _calc.bottomOffset(
        _calc.rightOffset(center, (BODY_WIDTH / 2), heading),
        TRACK_LENGTH / 2,
        heading,
      );

      // Construct GeoJSON
      final geoJson = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [frontLeft.lng, frontLeft.lat],
                  [frontRight.lng, frontRight.lat],
                  [backRight.lng, backRight.lat],
                  [backLeft.lng, backLeft.lat],
                  [frontLeft.lng, frontLeft.lat],
                ],
              ],
            },
            "properties": {"type": "body"},
          },
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [leftTrackFront.lng, leftTrackFront.lat],
                  [
                    _calc.rightOffset(leftTrackFront, TRACK_WIDTH, heading).lng,
                    _calc.rightOffset(leftTrackFront, TRACK_WIDTH, heading).lat,
                  ],
                  [
                    _calc.rightOffset(leftTrackBack, TRACK_WIDTH, heading).lng,
                    _calc.rightOffset(leftTrackBack, TRACK_WIDTH, heading).lat,
                  ],
                  [leftTrackBack.lng, leftTrackBack.lat],
                  [leftTrackFront.lng, leftTrackFront.lat],
                ],
              ],
            },
            "properties": {"type": "track"},
          },
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [rightTrackFront.lng, rightTrackFront.lat],
                  [
                    _calc
                        .rightOffset(rightTrackFront, TRACK_WIDTH, heading)
                        .lng,
                    _calc
                        .rightOffset(rightTrackFront, TRACK_WIDTH, heading)
                        .lat,
                  ],
                  [
                    _calc.rightOffset(rightTrackBack, TRACK_WIDTH, heading).lng,
                    _calc.rightOffset(rightTrackBack, TRACK_WIDTH, heading).lat,
                  ],
                  [rightTrackBack.lng, rightTrackBack.lat],
                  [rightTrackFront.lng, rightTrackFront.lat],
                ],
              ],
            },
            "properties": {"type": "track"},
          },
        ],
      };

      await style.updateGeoJsonSource(
        id: "exca_body_source",
        data: jsonEncode(geoJson),
      );
    } catch (e) {
      print('Error update Body: $e');
    }
  }

  Future<void> _updateAttachment(
    maplibre.StyleController style,
    GPSLoc gps,
  ) async {
    try {
      final attachPos = Position(gps.attachLng, gps.attachLat);
      // Radius in meters. 0.25m radius = 50cm diameter.
      const double ATTACH_RADIUS = 0.25;

      final polygonCoords = _calc.generateCirclePolygon(
        attachPos,
        ATTACH_RADIUS,
      );

      final geoJson = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "geometry": {"type": "Polygon", "coordinates": polygonCoords},
            "properties": {"type": "attachment"},
          },
        ],
      };

      await style.updateGeoJsonSource(
        id: "attach_source",
        data: jsonEncode(geoJson),
      );
    } catch (e) {
      print('Error update Attachment: $e');
    }
  }

  Future<void> _updateCockpit(
    maplibre.StyleController style,
    GPSLoc gps,
  ) async {
    try {
      const double BASE_SIZE = 2.6;
      const double COCKPIT_LENGTH = 2.0;
      const double ARM_WIDTH = 0.3;

      final center = Position(gps.bucketLong, gps.bucketLat);
      final armPos = Position(gps.attachLng, gps.attachLat); // Attachment point
      final heading = gps.heading;

      // Base
      final baseTopLeft = _calc.topOffset(
        _calc.leftOffset(center, BASE_SIZE / 2, heading),
        BASE_SIZE / 2,
        heading,
      );
      final baseTopRight = _calc.topOffset(
        _calc.rightOffset(center, BASE_SIZE / 2, heading),
        BASE_SIZE / 2,
        heading,
      );
      final baseBottomLeft = _calc.bottomOffset(
        _calc.leftOffset(center, BASE_SIZE / 2, heading),
        BASE_SIZE / 2,
        heading,
      );
      final baseBottomRight = _calc.bottomOffset(
        _calc.rightOffset(center, BASE_SIZE / 2, heading),
        BASE_SIZE / 2,
        heading,
      );

      // Cockpit
      final cockpitTopLeft = _calc.topOffset(
        _calc.leftOffset(center, BASE_SIZE / 2, heading),
        COCKPIT_LENGTH / 2,
        heading,
      );
      final cockpitTopRight = _calc.topOffset(
        center,
        COCKPIT_LENGTH / 2,
        heading,
      );
      final cockpitBottomLeft = _calc.bottomOffset(
        _calc.leftOffset(center, BASE_SIZE / 2, heading),
        COCKPIT_LENGTH / 2,
        heading,
      );
      final cockpitBottomRight = _calc.bottomOffset(
        center,
        COCKPIT_LENGTH / 2,
        heading,
      );

      // Arm (From center to attach point)
      // Ref logic: calculates distance and angle to draw a rectangle connector.
      // Note: Ref uses `_calc.getDistance(center, armPos)` for length and `getBearing` for direction.
      // This allows the arm to "swing" if the attachment point is physically sensed differently from heading.
      final armLength = _calc.getDistance(center, armPos) - (BASE_SIZE / 2);
      final armBearing = _calc.getBearing(center, armPos);

      final armStart = _calc.topOffset(center, BASE_SIZE / 2, armBearing);
      final armEnd = _calc.topOffset(armStart, armLength, armBearing);

      final armTopLeft = _calc.leftOffset(armStart, ARM_WIDTH / 2, armBearing);
      final armTopRight = _calc.rightOffset(
        armStart,
        ARM_WIDTH / 2,
        armBearing,
      );
      final armBottomLeft = _calc.leftOffset(armEnd, ARM_WIDTH / 2, armBearing);
      final armBottomRight = _calc.rightOffset(
        armEnd,
        ARM_WIDTH / 2,
        armBearing,
      );

      final geoJson = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [baseTopLeft.lng, baseTopLeft.lat],
                  [baseTopRight.lng, baseTopRight.lat],
                  [baseBottomRight.lng, baseBottomRight.lat],
                  [baseBottomLeft.lng, baseBottomLeft.lat],
                  [baseTopLeft.lng, baseTopLeft.lat],
                ],
              ],
            },
            "properties": {"part": "base"},
          },
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [cockpitTopLeft.lng, cockpitTopLeft.lat],
                  [cockpitTopRight.lng, cockpitTopRight.lat],
                  [cockpitBottomRight.lng, cockpitBottomRight.lat],
                  [cockpitBottomLeft.lng, cockpitBottomLeft.lat],
                  [cockpitTopLeft.lng, cockpitTopLeft.lat],
                ],
              ],
            },
            "properties": {"part": "cockpit"},
          },
          {
            "type": "Feature",
            "geometry": {
              "type": "Polygon",
              "coordinates": [
                [
                  [armTopLeft.lng, armTopLeft.lat],
                  [armTopRight.lng, armTopRight.lat],
                  [armBottomRight.lng, armBottomRight.lat],
                  [armBottomLeft.lng, armBottomLeft.lat],
                  [armTopLeft.lng, armTopLeft.lat],
                ],
              ],
            },
            "properties": {"part": "arm"},
          },
        ],
      };

      await style.updateGeoJsonSource(
        id: "excavator_source",
        data: jsonEncode(geoJson),
      );
    } catch (e) {
      print('Error update Cockpit: $e');
    }
  }

  // --- Spot Logic ---
  Future<void> loadSpots(maplibre.MapController controller) async {
    try {
      final auth = ref.read(authProvider);
      final activeFile = auth.activeWorkfile;
      final driver = auth.currentUser;
      final systemMode = auth.mode.stableName;

      if (activeFile == null || driver == null) {
        return; // Wait until session is ready
      }

      final fileID = activeFile.uid.toString();
      // final driverID = driver.uid.toString();

      final isar = DatabaseService().isar;

      // Query specific spots for this person and workfile, filtered by mode
      final spots = await isar.workingSpots
          .filter()
          .fileIDEqualTo(fileID)
          .modeEqualTo(systemMode)
          .findAll();

      // Ensure spots are sorted by ID for consistent logic across the app
      spots.sort((a, b) => a.id.compareTo(b.id));

      // Store in memory for proximity targeting
      _loadedSpots = spots;

      // Calculate totals
      final total = spots.length;
      final done = spots.where((s) => s.status == 1).length;

      // Update State for Info Panel
      state = state.copyWith(totalSpot: total, spotDone: done);

      if (spots.isEmpty) {
        // Clear map if spots are empty
        final emptyGeoJson = {"type": "FeatureCollection", "features": []};
        final style = controller.style;
        if (style != null) {
          await style.updateGeoJsonSource(
            id: "spots_source",
            data: jsonEncode(emptyGeoJson),
          );
        }
        return;
      }

      final List<Map<String, dynamic>> features = [];

      if (systemMode == 'CRUMBLING') {
        // Group by spotID
        final Map<int, List<WorkingSpot>> groupedSpots = {};
        for (var spot in spots) {
          if (spot.spotID != null) {
            groupedSpots.putIfAbsent(spot.spotID!, () => []).add(spot);
          }
        }

        // Each group creates segments
        for (var entry in groupedSpots.entries) {
          final groupSpots = entry.value;
          // Ensure they are sorted (e.g., by internal id or insertion order)
          groupSpots.sort((a, b) => a.id.compareTo(b.id));

          if (groupSpots.length >= 2) {
            for (int i = 0; i < groupSpots.length - 1; i++) {
              final s1 = groupSpots[i];
              final s2 = groupSpots[i + 1];

              if (s1.lat != null &&
                  s1.lng != null &&
                  s2.lat != null &&
                  s2.lng != null) {
                features.add({
                  "type": "Feature",
                  "geometry": {
                    "type": "LineString",
                    "coordinates": [
                      [s1.lng!, s1.lat!],
                      [s2.lng!, s2.lat!],
                    ],
                  },
                  "properties": {"status": s1.status ?? 0, "id": s1.id},
                });
              }
            }
          } else if (groupSpots.length == 1) {
            // Fallback to point if only 1 spot in a group
            final s1 = groupSpots[0];
            if (s1.lat != null && s1.lng != null) {
              features.add({
                "type": "Feature",
                "geometry": {
                  "type": "Point",
                  "coordinates": [s1.lng!, s1.lat!],
                },
                "properties": {"status": s1.status ?? 0, "id": s1.id},
              });
            }
          }
        }
      } else {
        for (var spot in spots) {
          if (spot.lat != null && spot.lng != null) {
            features.add({
              "type": "Feature",
              "geometry": {
                "type": "Point",
                "coordinates": [spot.lng!, spot.lat!],
              },
              "properties": {"status": spot.status ?? 0, "id": spot.id},
            });
          }
        }
      }

      final geoJson = {"type": "FeatureCollection", "features": features};

      final style = controller.style;
      if (style != null) {
        await style.updateGeoJsonSource(
          id: "spots_source",
          data: jsonEncode(geoJson),
        );
      }
    } catch (e) {
      print('Error loading spots: $e');
      NotificationService.showError('Failed to load spots');
    }
  }
}

final mapPresenterProvider = NotifierProvider<MapPresenter, MapState>(
  MapPresenter.new,
);
