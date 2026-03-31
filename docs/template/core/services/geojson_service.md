# GeoJSON Service Detail

Handles the ingestion and parsing of job-site geometries.

## 1. File Handling
- Uses `file_picker` to allow selection of `.geojson` or `.json` files.
- Reads files as strings and decodes using `json.decode`.

## 2. Parsing Logic
- **Spot Mode**:
  - Extracts `Point` geometries.
  - Maps `OBJECTID` or `Id` properties to the `spotID` field.
- **Crumbling Mode**:
  - Handles both `LineString` and `MultiLineString`.
  - Flattens nested coordinate rings into a sequential list of `WorkingSpot` objects.
  - Generates incremental `spotID` for each unique point in the line.

## 3. Data Integrity
- **Timestamps**: All `lastUpdate` fields are enforced to use **seconds** (`millisecondsSinceEpoch ~/ 1000`).
- **Defaults**: Unset altitude and accuracy fields default to `0`.

---
> [!IMPORTANT]
> The parser distinguishes between Feature types; ensure the GeoJSON follows the standard `FeatureCollection` structure.
