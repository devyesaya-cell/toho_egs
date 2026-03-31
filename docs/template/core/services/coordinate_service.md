# Coordinate Service Detail

Mathematical engine for geospatial calculations and guidance positioning.

## 1. Key Functionalities
- **Angular Math**: `getBearing(pointA, pointB)` uses `atan2` for precise navigation headings.
- **Offset Generation**:
  - `leftOffset` / `rightOffset`: Calculates new coordinates perpendicular to the current bearing (used for bucket side referencing).
  - `topOffset` / `bottomOffset`: Calculates coordinates along the bearing line.
- **Guidance Logic**:
  - `crossTrackDeviation`: Returns distance in **cm** from a line segment (Negative = Left, Positive = Right).
  - `distanceToSegment`: Shortest distance in meters to a target line.
- **Geometry Generation**:
  - `generateCirclePolygon`: Produces GeoJSON-compatible circular rings for point visualization.

## 2. Implementation Rules
- Always use `pi / 180` for radian conversion.
- Earth radius is standardized at `6371` km.
- Cross-track results must be multiplied by `100` for consistent centimeter-level display in the UI.

---
> [!NOTE]
> This service is the backbone of the real-time guidance system on the Map page.
