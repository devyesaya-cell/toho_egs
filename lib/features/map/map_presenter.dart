import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre/maplibre.dart' as maplibre;
import '../../core/coms/com_service.dart';
import '../../core/models/base_status.dart';
import '../../core/models/error_alert.dart';
import '../../core/models/gps_loc.dart';
import '../../core/services/coordinate_service.dart';
import '../../core/services/notification_service.dart';
import 'package:isar_community/isar.dart';
import '../../core/models/working_spot.dart';
import '../../core/database/database_service.dart';

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

  // Slopes (From GPSLoc)
  final double boomTilt;
  final double stickTilt;
  final double attachTilt;

  // Arm Length
  final double armLength;

  // Full Objects for Dialogs
  final GPSLoc? fullGps;
  final Basestatus? fullBase;

  // Track Logic
  final double trackHeading;
  final double? lastTrackLat;
  final double? lastTrackLng;
  // Work Mode
  final bool isWorkMode;

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
    this.fullGps,
    this.fullBase,
    this.trackHeading = 0.0,
    this.lastTrackLat,
    this.lastTrackLng,
    this.isWorkMode = false,
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
    GPSLoc? fullGps,
    Basestatus? fullBase,
    double? trackHeading,
    double? lastTrackLat,
    double? lastTrackLng,
    bool? isWorkMode,
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
      fullGps: fullGps ?? this.fullGps,
      fullBase: fullBase ?? this.fullBase,
      trackHeading: trackHeading ?? this.trackHeading,
      lastTrackLat: lastTrackLat ?? this.lastTrackLat,
      lastTrackLng: lastTrackLng ?? this.lastTrackLng,
      isWorkMode: isWorkMode ?? this.isWorkMode,
    );
  }
}

// --- Presenter ---
class MapPresenter extends Notifier<MapState> {
  StreamSubscription<GPSLoc>? _gpsSub;
  StreamSubscription<Basestatus>? _bsSub;
  StreamSubscription<ErrorAlert>? _errSub;
  Timer? _paramTimer;

  @override
  MapState build() {
    _subscribe();

    // Check connection status periodically
    _paramTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkConnection();
    });

    ref.onDispose(() {
      _gpsSub?.cancel();
      _bsSub?.cancel();
      _errSub?.cancel();
      _paramTimer?.cancel();
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

  void toggleWorkMode() {
    state = state.copyWith(isWorkMode: !state.isWorkMode);
  }

  void _subscribe() {
    final comService = ref.read(comServiceProvider.notifier);

    // GPS Stream
    _gpsSub = comService.gpsStream.listen((gps) {
      // Calculate Arm Length
      final dist = _calculate3DDistance(
        gps.boomLat,
        gps.boomLng,
        gps.boomAlt,
        gps.attachLat,
        gps.attachLng,
        gps.attachAlt,
      );

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
        if (newRtkStatus == 'NO RTK') {
          NotificationService.showError('RTK Signal Lost!');
        } else if (newRtkStatus == 'RTK') {
          NotificationService.showSuccess('RTK Fixed');
        } else if (newRtkStatus == 'FLOAT') {
          NotificationService.showWarning('RTK Float Mode');
        }
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
        fullGps: gps,
        lastDataTime: DateTime.now(), // Update timestamp
        trackHeading: newTrackHeading,
        lastTrackLat: newLastTrackLat,
        lastTrackLng: newLastTrackLng,
      );
    });

    // Base Status Stream
    _bsSub = comService.bsStream.listen((bs) {
      state = state.copyWith(
        batteryVoltage: bs.batteryVoltage,
        fullBase: bs,
        lastDataTime:
            DateTime.now(), // Also count base messages as data? Probably yes.
      );
    });

    // Error Stream
    _errSub = comService.errorStream.listen((err) {
      if (state.lastError != err) {
        NotificationService.showError('Error: ${err.message}');
      }
      state = state.copyWith(lastError: err);
    });
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
      if (controller.style == null) return;

      // Initialize empty sources or dummy data to prevent errors before first GPS update
      // Just waiting for the first update is often better, but we need definitions.
      // Let's create empty feature collections.
      final emptyGeoJson = jsonEncode({
        "type": "FeatureCollection",
        "features": [],
      });

      // 0. Spots Source & Layer (Bottom Layer)
      await controller.style!.addSource(
        maplibre.GeoJsonSource(id: 'spots_source', data: emptyGeoJson),
      );

      await controller.style!.addLayer(
        const maplibre.CircleStyleLayer(
          id: 'spots_layer',
          sourceId: 'spots_source',
          paint: {
            'circle-color': [
              'match',
              ['get', 'status'],
              0, '#FF0000', // Status 0 = Red
              '#00FF00', // Default = Green
            ],
            'circle-radius': 5.0,
            'circle-opacity': 0.8,
          },
        ),
      );

      // Load initial spots
      // We can't await this blocking if it takes time, but for now it's fine.
      // Better to call it unawaited or let it update async.
      loadSpots(controller);

      // 1. Excavator Body/Tracks Source
      await controller.style!.addSource(
        maplibre.GeoJsonSource(id: 'exca_body_source', data: emptyGeoJson),
      );

      // 2. Body Layer
      await controller.style!.addLayer(
        const maplibre.FillStyleLayer(
          id: 'exca_body_layer',
          sourceId: 'exca_body_source',
          paint: {'fill-color': '#FBAF00'},
          filter: ['==', 'type', 'body'],
        ),
      );

      // 3. Tracks Layer
      await controller.style!.addLayer(
        const maplibre.FillStyleLayer(
          id: 'exca_tracks_layer',
          sourceId: 'exca_body_source',
          paint: {'fill-color': '#000000'},
          filter: ['==', 'type', 'track'],
        ),
      );

      // 4. Cockpit/Arm Source (If separate, but we can combine if needed. The reference kept them separate?)
      // The reference used 'excavator_source' for base, cockpit, arm.
      // Let's use 'exca_upper_source' for rotating parts (cockpit, arm) vs 'exca_body_source' for tracks/chassis?
      // Actually, in an excavator, the tracks/chassis stay aligned with the heading, but the cabin/arm rotates with the "Swing"?
      // Wait, GPS heading usually gives the "Machine Heading" (tracks).
      // Does the GPS data give "Swing" or "Azimuth"?
      // `GPSLoc` has `heading`. Is this tracks or cabin?
      // The reference `addBodyML` uses `gps.heading`. `addCockpitML` ALSO uses `gps.heading`.
      // If both use the same heading, they move together.
      // For now, I will follow the reference and separate sources 'exca_body_source' and 'excavator_source' (cockpit/arm).

      await controller.style!.addSource(
        maplibre.GeoJsonSource(id: 'excavator_source', data: emptyGeoJson),
      );

      // Base (Cockpit Base)
      await controller.style!.addLayer(
        const maplibre.FillStyleLayer(
          id: 'base_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#E78A00'},
          filter: ['==', 'part', 'base'],
        ),
      );

      // Cockpit
      await controller.style!.addLayer(
        const maplibre.FillStyleLayer(
          id: 'cockpit_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#808080'},
          filter: ['==', 'part', 'cockpit'],
        ),
      );

      // Arm
      await controller.style!.addLayer(
        maplibre.FillStyleLayer(
          id: 'arm_layer',
          sourceId: 'excavator_source',
          paint: {'fill-color': '#808080'},
          filter: ['==', 'part', 'arm'],
        ),
      );

      // Attachment Source & Layer
      await controller.style!.addSource(
        maplibre.GeoJsonSource(id: 'attach_source', data: emptyGeoJson),
      );

      await controller.style!.addLayer(
        maplibre.FillStyleLayer(
          id: 'attach_layer',
          sourceId: 'attach_source',
          paint: {'fill-color': '#E78A00'}, // Example color
        ),
      );
    } catch (e) {
      print('Error adding excavator layers: $e');
    }
  }

  Future<void> updateExcavatorPosition(
    maplibre.MapController controller,
    GPSLoc gps,
  ) async {
    if (controller.style == null) return;
    // Update Body (Tracks)
    await _updateBody(controller, gps);
    // Update Upper Structure (Cockpit, Arm)
    await _updateCockpit(controller, gps);
    // Update Attachment
    await _updateAttachment(controller, gps);
  }

  Future<void> _updateBody(
    maplibre.MapController controller,
    GPSLoc gps,
  ) async {
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

      await controller.style!.updateGeoJsonSource(
        id: "exca_body_source",
        data: jsonEncode(geoJson),
      );
    } catch (e) {
      print('Error update Body: $e');
    }
  }

  Future<void> _updateAttachment(
    maplibre.MapController controller,
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

      await controller.style!.updateGeoJsonSource(
        id: "attach_source",
        data: jsonEncode(geoJson),
      );
    } catch (e) {
      print('Error update Attachment: $e');
    }
  }

  Future<void> _updateCockpit(
    maplibre.MapController controller,
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

      await controller.style!.updateGeoJsonSource(
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
      final isar = DatabaseService().isar;
      final spots = await isar.workingSpots.where().findAll();

      if (spots.isEmpty) return;

      final List<Map<String, dynamic>> features = [];

      for (var spot in spots) {
        if (spot.lat != null && spot.lng != null) {
          // Use Point Geometry for CircleLayer
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

      final geoJson = {"type": "FeatureCollection", "features": features};

      if (controller.style != null) {
        await controller.style!.updateGeoJsonSource(
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
