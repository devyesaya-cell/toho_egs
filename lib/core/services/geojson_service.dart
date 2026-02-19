import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/working_spot.dart';

class GeoJsonService {
  Future<FilePickerResult?> pickGeoJsonFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['geojson', 'json'],
    );
  }

  Future<List<WorkingSpot>> parseGeoJson(String filePath) async {
    try {
      final file = File(filePath);
      final String content = await file.readAsString();
      final Map<String, dynamic> data = json.decode(content);

      if (data['type'] == 'FeatureCollection' && data['features'] != null) {
        final List<dynamic> features = data['features'];
        return features.map((feature) {
          final geometry = feature['geometry'];
          final properties = feature['properties'];

          double? lat;
          double? lng;

          if (geometry['type'] == 'Point' && geometry['coordinates'] != null) {
            final List<dynamic> coords = geometry['coordinates'];
            if (coords.length >= 2) {
              lng = (coords[0] as num).toDouble();
              lat = (coords[1] as num).toDouble();
            }
          }

          return WorkingSpot(
            status: 0, // Default status
            spotID:
                properties['ORIG_FID'] ??
                properties['Id'] ??
                0, // Try ORIG_FID, fallback to Id
            lat: lat,
            lng: lng,
            alt: 0,
            akurasi: 0.0,
            deep: 0,
            totalTime: 0,
            lastUpdate: DateTime.now().millisecondsSinceEpoch,
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error parsing GeoJSON: $e');
      return [];
    }
  }
}
