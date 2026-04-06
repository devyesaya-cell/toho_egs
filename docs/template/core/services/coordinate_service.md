# Coordinate Service — Blueprint

**File**: `lib/core/services/coordinate_service.dart`  
**Classes**: `Position` (data class) + `CoordinateService` (pure logic class)

_A pure math utility service for all GPS coordinate calculations: bearing, distance, directional offsets, polygon generation, and cross-track deviation. No Flutter dependencies — only `dart:math`._

---

## Imports Required

```dart
import 'dart:math';
```

---

## Class 1: `Position`

A simple value-object holding a geographic coordinate pair.

```dart
class Position {
  final double lng;
  final double lat;

  Position(this.lng, this.lat);
}
```

> [!IMPORTANT]
> The constructor order is **`Position(lng, lat)`** — longitude first, latitude second. This matches GeoJSON convention. Do not confuse with the standard geographic `(lat, lng)` order.

---

## Class 2: `CoordinateService`

An instantiable (non-static) class. Create a new instance wherever needed:

```dart
final _coord = CoordinateService();
```

---

## Method Reference

### `getBearing`

Calculates the true compass bearing (0°–360°) from point A to point B.

```dart
double getBearing(Position pointA, Position pointB)
```

**Implementation:**
```dart
double getBearing(Position pointA, Position pointB) {
  double radianLatA = pointA.lat * pi / 180;
  double radianLongA = pointA.lng * pi / 180;
  double radianLatB = pointB.lat * pi / 180;
  double radianLongB = pointB.lng * pi / 180;

  double sigmaLong = radianLongB - radianLongA;
  double y = cos(radianLatB) * sin(sigmaLong);
  double x = cos(radianLatA) * sin(radianLatB) -
              sin(radianLatA) * cos(radianLatB) * cos(sigmaLong);
  return ((atan2(y, x) / pi * 180) + 360) % 360;
}
```

| Parameter | Type       | Description               |
|-----------|------------|---------------------------|
| `pointA`  | `Position` | Starting coordinate       |
| `pointB`  | `Position` | Target coordinate         |
| **Returns** | `double` | Bearing in degrees (0–360) |

---

### `getDistance`

Calculates the distance in **meters** between two GPS positions using the Haversine formula.

```dart
double getDistance(Position pointA, Position pointB)
```

**Implementation:**
```dart
double getDistance(Position pointA, Position pointB) {
  var p = 0.017453292519943295;  // pi / 180
  var a = 0.5 -
      cos((pointB.lat - pointA.lat) * p) / 2 +
      cos(pointA.lat * p) *
          cos(pointB.lat * p) *
          (1 - cos((pointB.lng - pointA.lng) * p)) / 2;
  return (12742 * asin(sqrt(a))) * 1000;  // 12742 = 2 * Earth radius in km
}
```

| Parameter | Type       | Description               |
|-----------|------------|---------------------------|
| `pointA`  | `Position` | First coordinate          |
| `pointB`  | `Position` | Second coordinate         |
| **Returns** | `double` | Distance in **meters**    |

---

### Directional Offset Methods

All four offset methods shift a `Position` by a given distance in meters along a relative direction derived from the `bearing`. They share the same internal math, differing only in the **angle adjustment applied to the bearing**.

**Shared calculation pattern:**
```dart
double earthRadius = 6371;  // km
double multiplier = (1 / ((2 * pi / 360) * earthRadius)) / 1000;  // degrees per meter
double newLat = initPos.lat + (radioOffsetY * multiplier);
double newLng = initPos.lng + (radioOffsetX * multiplier) / cos(initPos.lat * (pi / 180));
return Position(newLng, newLat);
```

#### `leftOffset`
Moves `initPos` perpendicular-left of the current heading.

```dart
Position leftOffset(Position initPos, double offset, double bearing)
// Angle: (bearing - 90)
// radioOffsetX = offset * sin((bearing - 90) * pi / 180)
// radioOffsetY = offset * cos((bearing - 90) * pi / 180)
```

#### `rightOffset`
Moves `initPos` perpendicular-right of the current heading.

```dart
Position rightOffset(Position initPos, double offset, double bearing)
// Angle: (bearing + 90)
```

#### `topOffset`
Moves `initPos` forward in the direction of the bearing.

```dart
Position topOffset(Position initPos, double offset, double bearing)
// Angle: (bearing) — no adjustment
```

#### `bottomOffset`
Moves `initPos` backward (opposite of bearing).

```dart
Position bottomOffset(Position initPos, double offset, double bearing)
// Angle: (bearing + 180)
```

**Common Parameters for all offset methods:**

| Parameter  | Type       | Description                                    |
|------------|------------|------------------------------------------------|
| `initPos`  | `Position` | Starting GPS coordinate                        |
| `offset`   | `double`   | Distance to move in **meters**                 |
| `bearing`  | `double`   | Compass heading in degrees (0–360)             |
| **Returns**| `Position` | New GPS coordinate after applying the offset   |

---

### `generateCirclePolygon`

Generates a closed polygon ring (as a GeoJSON-formatted coordinate list) representing a circle.

```dart
List<List<List<double>>> generateCirclePolygon(
  Position center,
  double radiusInMeters, {
  int steps = 36,
})
```

**Implementation:**
```dart
List<List<List<double>>> generateCirclePolygon(
  Position center,
  double radiusInMeters, {
  int steps = 36,
}) {
  List<List<double>> coordinates = [];
  for (int i = 0; i < steps; i++) {
    double angle = (i * 360) / steps;
    Position point = topOffset(center, radiusInMeters, angle);
    coordinates.add([point.lng, point.lat]);
  }
  coordinates.add(coordinates.first);  // Close the ring
  return [coordinates];  // GeoJSON outer ring format
}
```

| Parameter        | Type       | Default | Description                          |
|------------------|------------|---------|--------------------------------------|
| `center`         | `Position` | —       | Center of the circle                 |
| `radiusInMeters` | `double`   | —       | Radius in meters                     |
| `steps`          | `int`      | `36`    | Number of polygon vertices (quality) |
| **Returns**      | `List<List<List<double>>>` | — | GeoJSON `Polygon.coordinates` format: `[[[lng, lat], ...]]` |

> [!NOTE]
> The last coordinate is always identical to the first (closed loop). This is required by the GeoJSON Polygon spec.

---

### `distanceToSegment`

Calculates the shortest distance in **meters** from point `pt` to the line segment defined by `lineStart` → `lineEnd`.

```dart
double distanceToSegment(Position pt, Position lineStart, Position lineEnd)
```

**Algorithm**: Projects `pt` onto the line segment. If projection falls outside the segment endpoints, returns distance to the nearest endpoint.

```dart
double distanceToSegment(Position pt, Position lineStart, Position lineEnd) {
  double latMid = (lineStart.lat + lineEnd.lat) / 2.0 * pi / 180.0;

  // Convert to approximate Cartesian meters
  double dxLine = (lineEnd.lng - lineStart.lng) * 111320.0 * cos(latMid);
  double dyLine = (lineEnd.lat - lineStart.lat) * 111320.0;
  double dxPt   = (pt.lng - lineStart.lng) * 111320.0 * cos(latMid);
  double dyPt   = (pt.lat - lineStart.lat) * 111320.0;

  double lineLenSq = dxLine * dxLine + dyLine * dyLine;
  if (lineLenSq == 0) return sqrt(dxPt * dxPt + dyPt * dyPt);  // Point segment

  double t = (dxPt * dxLine + dyPt * dyLine) / lineLenSq;

  if (t < 0) {
    return sqrt(dxPt * dxPt + dyPt * dyPt);          // Before segment start
  } else if (t > 1) {
    double dxEnd = (pt.lng - lineEnd.lng) * 111320.0 * cos(latMid);
    double dyEnd = (pt.lat - lineEnd.lat) * 111320.0;
    return sqrt(dxEnd * dxEnd + dyEnd * dyEnd);       // Past segment end
  } else {
    double projX = dxLine * t;
    double projY = dyLine * t;
    return sqrt((dxPt - projX) * (dxPt - projX) + (dyPt - projY) * (dyPt - projY));
  }
}
```

| Parameter   | Type       | Description                              |
|-------------|------------|------------------------------------------|
| `pt`        | `Position` | The point to measure from                |
| `lineStart` | `Position` | Start of the line segment                |
| `lineEnd`   | `Position` | End of the line segment                  |
| **Returns** | `double`   | Shortest distance in **meters**          |

> [!NOTE]
> Uses `111320.0` meters/degree conversion factor (approximate, valid for moderate latitudes). Longitude is scaled by `cos(latMid)` to account for Earth's curvature.

---

### `crossTrackDeviation`

Calculates the signed lateral deviation in **centimeters** of point `pt` from the line `lineStart` → `lineEnd`.

```dart
double crossTrackDeviation(Position pt, Position lineStart, Position lineEnd)
```

**Sign convention:**
- **Positive** → `pt` is to the **Right** of the line direction
- **Negative** → `pt` is to the **Left** of the line direction

```dart
double crossTrackDeviation(Position pt, Position lineStart, Position lineEnd) {
  double latMid = (lineStart.lat + lineEnd.lat) / 2.0 * pi / 180.0;
  double dxLine = (lineEnd.lng - lineStart.lng) * 111320.0 * cos(latMid);
  double dyLine = (lineEnd.lat - lineStart.lat) * 111320.0;
  double dxPt   = (pt.lng - lineStart.lng) * 111320.0 * cos(latMid);
  double dyPt   = (pt.lat - lineStart.lat) * 111320.0;

  double lineLen = sqrt(dxLine * dxLine + dyLine * dyLine);
  if (lineLen == 0) return 0;

  double cross = (dxLine * dyPt - dyLine * dxPt) / lineLen;
  return cross * 100;  // Convert meters to centimeters
}
```

| Parameter   | Type       | Description                                        |
|-------------|------------|----------------------------------------------------|
| `pt`        | `Position` | The GPS point to measure                           |
| `lineStart` | `Position` | Start of the reference line                        |
| `lineEnd`   | `Position` | End of the reference line                          |
| **Returns** | `double`   | Cross-track deviation in **centimeters** (+R / -L) |

---

## Complete Method Summary

| Method                 | Returns     | Unit       | Purpose                                    |
|------------------------|-------------|------------|--------------------------------------------|
| `getBearing`           | `double`    | degrees    | Compass heading A→B (0–360°)              |
| `getDistance`          | `double`    | meters     | Haversine distance between two points      |
| `leftOffset`           | `Position`  | —          | Move left (perpendicular, bearing - 90°)   |
| `rightOffset`          | `Position`  | —          | Move right (perpendicular, bearing + 90°)  |
| `topOffset`            | `Position`  | —          | Move forward (along bearing)               |
| `bottomOffset`         | `Position`  | —          | Move backward (bearing + 180°)             |
| `generateCirclePolygon`| `List<List<List<double>>>` | — | GeoJSON circle polygon ring           |
| `distanceToSegment`    | `double`    | meters     | Closest distance to a line segment         |
| `crossTrackDeviation`  | `double`    | centimeters| Signed lateral deviation from a line (+R/-L) |
