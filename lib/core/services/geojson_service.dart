import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/working_spot.dart';
import '../state/auth_state.dart';

class GeoJsonService {
  Future<FilePickerResult?> pickGeoJsonFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['geojson', 'json'],
    );
  }

  Future<List<WorkingSpot>> parseGeoJson(
    String filePath,
    SystemMode mode,
  ) async {
    try {
      final file = File(filePath);
      final String content = await file.readAsString();
      final Map<String, dynamic> data = json.decode(content);

      if (data['type'] == 'FeatureCollection' && data['features'] != null) {
        final List<dynamic> features = data['features'];
        List<WorkingSpot> allSpots = [];
        int crumblingLineId = 1;

        for (var feature in features) {
          final geometry = feature['geometry'];
          final properties = feature['properties'];

          if (mode == SystemMode.spot) {
            if (geometry['type'] == 'Point' &&
                geometry['coordinates'] != null) {
              final List<dynamic> coords = geometry['coordinates'];
              if (coords.length >= 2) {
                final lng = (coords[0] as num).toDouble();
                final lat = (coords[1] as num).toDouble();

                allSpots.add(
                  WorkingSpot(
                    status: 0,
                    spotID: properties['OBJECTID'] ?? properties['Id'] ?? 0,
                    lat: lat,
                    lng: lng,
                    alt: 0,
                    akurasi: 0.0,
                    deep: 0,
                    totalTime: 0,
                    lastUpdate:
                        DateTime.now().millisecondsSinceEpoch ~/
                        1000, // Enforce seconds per rule
                  ),
                );
              }
            }
          } else if (mode == SystemMode.crumbling) {
            // Crumbling parsing: Handle MultiLineString
            if (geometry['type'] == 'MultiLineString' &&
                geometry['coordinates'] != null) {
              final List<dynamic> rawLines = geometry['coordinates'];

              for (var line in rawLines) {
                int currentSpotId = crumblingLineId++;
                for (var point in line) {
                  if (point is List && point.length >= 2) {
                    allSpots.add(
                      WorkingSpot(
                        status: 0,
                        spotID: currentSpotId,
                        lat: (point[1] as num).toDouble(),
                        lng: (point[0] as num).toDouble(),
                        alt: 0,
                        akurasi: 0.0,
                        deep: 0,
                        totalTime: 0,
                        lastUpdate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                      ),
                    );
                  }
                }
              }
            } else if (geometry['type'] == 'LineString' &&
                geometry['coordinates'] != null) {
              final List<dynamic> points = geometry['coordinates'];
              int currentSpotId = crumblingLineId++;

              for (var point in points) {
                if (point is List && point.length >= 2) {
                  allSpots.add(
                    WorkingSpot(
                      status: 0,
                      spotID: currentSpotId,
                      lat: (point[1] as num).toDouble(),
                      lng: (point[0] as num).toDouble(),
                      alt: 0,
                      akurasi: 0.0,
                      deep: 0,
                      totalTime: 0,
                      lastUpdate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    ),
                  );
                }
              }
            }
          }
        }
        return allSpots;
      }
      return [];
    } catch (e) {
      print('Error parsing GeoJSON: $e');
      return [];
    }
  }
}
