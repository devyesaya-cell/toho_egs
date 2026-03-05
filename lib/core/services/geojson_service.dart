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
                    spotID: properties['ORIG_FID'] ?? properties['Id'] ?? 0,
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
              final List<dynamic> lines = geometry['coordinates'];
              final spotIdGroup =
                  properties['id'] ??
                  properties['ORIG_FID'] ??
                  properties['Id'] ??
                  0;

              for (var line in lines) {
                final List<dynamic> points = line;
                for (var point in points) {
                  if (point is List && point.length >= 2) {
                    final lng = (point[0] as num).toDouble();
                    final lat = (point[1] as num).toDouble();

                    allSpots.add(
                      WorkingSpot(
                        status: 0,
                        spotID:
                            spotIdGroup, // Group ID mapped to spotID per requirements
                        lat: lat,
                        lng: lng,
                        alt: 0,
                        akurasi: 0.0,
                        deep: 0,
                        totalTime: 0,
                        lastUpdate:
                            DateTime.now().millisecondsSinceEpoch ~/ 1000,
                      ),
                    );
                  }
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
