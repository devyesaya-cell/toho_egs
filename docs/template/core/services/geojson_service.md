# GeoJson Service — Blueprint

**File**: `lib/core/services/geojson_service.dart`  
**Class**: `GeoJsonService` (instantiable, no state)

_Handles importing GeoJSON/JSON map files from device storage and parsing them into `WorkingSpot` objects. Supports two parsing modes: `SystemMode.spot` (Point features) and `SystemMode.crumbling` (LineString/MultiLineString features)._

---

## Imports Required

```dart
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/working_spot.dart';
import '../state/auth_state.dart';          // for SystemMode enum
```

---

## Dependencies

| Package / File         | Usage                                               |
|------------------------|-----------------------------------------------------|
| `file_picker`          | Opens native file picker dialog for `.geojson`/`.json` |
| `dart:convert`         | `json.decode()` for parsing file content            |
| `dart:io`              | `File` class for reading file from path             |
| `WorkingSpot`          | The target model for parsed spot data               |
| `SystemMode` (from `auth_state.dart`) | Enum determining parse behavior   |

---

## Class Structure

```dart
class GeoJsonService {
  Future<FilePickerResult?> pickGeoJsonFile() async { ... }
  Future<List<WorkingSpot>> parseGeoJson(String filePath, SystemMode mode) async { ... }
}
```

---

## Method 1: `pickGeoJsonFile`

Opens the native file picker and restricts selection to `.geojson` and `.json` files.

```dart
Future<FilePickerResult?> pickGeoJsonFile() async {
  return await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['geojson', 'json'],
  );
}
```

**Returns**: `FilePickerResult?` — null if user cancelled, otherwise contains file path(s).

**Typical usage:**
```dart
final result = await GeoJsonService().pickGeoJsonFile();
if (result != null) {
  final filePath = result.files.single.path!;
  final spots = await GeoJsonService().parseGeoJson(filePath, SystemMode.spot);
}
```

---

## Method 2: `parseGeoJson`

Reads and parses a GeoJSON file into a list of `WorkingSpot` objects. Behavior differs based on `SystemMode`.

```dart
Future<List<WorkingSpot>> parseGeoJson(String filePath, SystemMode mode) async
```

| Parameter  | Type         | Description                                             |
|------------|--------------|---------------------------------------------------------|
| `filePath` | `String`     | Absolute path to the `.geojson` or `.json` file        |
| `mode`     | `SystemMode` | `spot` or `crumbling` — determines which geometry to parse |
| **Returns**| `List<WorkingSpot>` | Parsed spots, or `[]` on error/empty result    |

### Top-Level File Validation

```dart
final file = File(filePath);
final String content = await file.readAsString();
final Map<String, dynamic> data = json.decode(content);

// Only processes FeatureCollection GeoJSON
if (data['type'] == 'FeatureCollection' && data['features'] != null) {
  final List<dynamic> features = data['features'];
  ...
}
return [];  // Returns empty if not a FeatureCollection
```

> [!IMPORTANT]
> The parser only accepts **GeoJSON `FeatureCollection`** type. Single `Feature` or bare `Geometry` files are not supported and will return `[]`.

---

## Parse Mode A: `SystemMode.spot` — Point Features

Parses `Point` geometry features into individual `WorkingSpot` objects.

```dart
// Triggers when: mode == SystemMode.spot
// Required geometry type: "Point"
// Required: geometry['coordinates'] with at least 2 elements [lng, lat]

if (geometry['type'] == 'Point' && geometry['coordinates'] != null) {
  final List<dynamic> coords = geometry['coordinates'];
  if (coords.length >= 2) {
    final lng = (coords[0] as num).toDouble();  // GeoJSON: [lng, lat]
    final lat = (coords[1] as num).toDouble();

    allSpots.add(WorkingSpot(
      status: 0,
      spotID: properties['OBJECTID'] ?? properties['Id'] ?? 0,  // fallback chain
      lat: lat,
      lng: lng,
      alt: 0,
      akurasi: 0.0,
      deep: 0,
      totalTime: 0,
      lastUpdate: DateTime.now().millisecondsSinceEpoch ~/ 1000,  // seconds not ms
    ));
  }
}
```

**Property ID Resolution Order:**
1. `properties['OBJECTID']` (ArcGIS/ESRI convention)
2. `properties['Id']` (fallback)
3. `0` (final fallback)

---

## Parse Mode B: `SystemMode.crumbling` — Line Features

Parses `MultiLineString` and `LineString` geometry features. Each line (polyline) gets a unique sequential `spotID`.

```dart
int crumblingLineId = 1;  // Increments for each line/subline
```

### MultiLineString handling:

```dart
if (geometry['type'] == 'MultiLineString' && geometry['coordinates'] != null) {
  final List<dynamic> rawLines = geometry['coordinates'];

  for (var line in rawLines) {           // Each sub-line gets its own ID
    int currentSpotId = crumblingLineId++;
    for (var point in line) {
      if (point is List && point.length >= 2) {
        allSpots.add(WorkingSpot(
          status: 0,
          spotID: currentSpotId,         // All points of same line → same ID
          lat: (point[1] as num).toDouble(),
          lng: (point[0] as num).toDouble(),
          alt: 0,
          akurasi: 0.0,
          deep: 0,
          totalTime: 0,
          lastUpdate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        ));
      }
    }
  }
}
```

### LineString handling:

```dart
else if (geometry['type'] == 'LineString' && geometry['coordinates'] != null) {
  final List<dynamic> points = geometry['coordinates'];
  int currentSpotId = crumblingLineId++;  // One ID for the whole line

  for (var point in points) {
    if (point is List && point.length >= 2) {
      allSpots.add(WorkingSpot(
        status: 0,
        spotID: currentSpotId,
        lat: (point[1] as num).toDouble(),
        lng: (point[0] as num).toDouble(),
        alt: 0, akurasi: 0.0, deep: 0, totalTime: 0,
        lastUpdate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ));
    }
  }
}
```

> [!NOTE]
> **`crumblingLineId` starts at 1** and is a local variable that increments per each line/subline. Points within the same line share the same `spotID`. This is how the `MapPresenter` groups line segments for crumbling mode rendering.

---

## Error Handling

```dart
} catch (e) {
  print('Error parsing GeoJSON: $e');
  return [];
}
```

On any exception (file not found, invalid JSON, parsing error), the method silently returns `[]`. No exception is rethrown.

---

## `WorkingSpot` Field Mapping from GeoJSON

| `WorkingSpot` Field | Source                                              | Notes                            |
|---------------------|-----------------------------------------------------|----------------------------------|
| `status`            | Always `0`                                          | Unvisited on import              |
| `spotID`            | `properties['OBJECTID']` → `['Id']` → `0` (spot)  | Or `crumblingLineId` (crumbling) |
| `lat`               | `coords[1]` (GeoJSON is `[lng, lat]`)               |                                  |
| `lng`               | `coords[0]`                                         |                                  |
| `alt`               | Always `0`                                          | No altitude in standard GeoJSON  |
| `akurasi`           | Always `0.0`                                        |                                  |
| `deep`              | Always `0`                                          |                                  |
| `totalTime`         | Always `0`                                          |                                  |
| `lastUpdate`        | `DateTime.now().millisecondsSinceEpoch ~/ 1000`     | **Integer-divided to seconds**   |

> [!CAUTION]
> `lastUpdate` uses `~/` (integer division) to convert milliseconds to **seconds**. This is intentional — the `WorkingSpot` model stores Unix timestamps in seconds, not milliseconds.

---

## Supported GeoJSON Structure

### For `SystemMode.spot`:
```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [107.5, -6.9] },
      "properties": { "OBJECTID": 1 }
    }
  ]
}
```

### For `SystemMode.crumbling`:
```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "MultiLineString",
        "coordinates": [
          [ [107.5, -6.9], [107.51, -6.91] ],
          [ [107.52, -6.92], [107.53, -6.93] ]
        ]
      },
      "properties": {}
    }
  ]
}
```
