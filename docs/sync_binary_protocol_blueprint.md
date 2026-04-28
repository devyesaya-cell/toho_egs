# SYNC BINARY PROTOCOL BLUEPRINT
Path: `lib/core/utils/payload_builder.dart`

This blueprint details the **Binary Payload Specification** used for transmitting production data (WorkingSpots) from the **Rover (Excavator)** to the **Host (Basestation)** via WebSocket raw frames.

## 1. Transmission Details
- **Protocol**: Raw Byte Array (`Uint8List`)
- **Endianness**: **Little Endian** (standard for embedded communication)
- **Content Type**: Header (29 bytes) + N Records (18 bytes each)

---

## 2. Header Structure (29 Bytes)

| Offset | Field | Type | Description |
|---|---|---|---|
| 0 - 1 | `workHours` | `uint16` | Total accumulated working seconds in the shift (clamped 0-65535). |
| 2 - 3 | `companyID` | `uint16` | Resolved ID of the Contractor (Last 4 hex digits of UID). |
| 4 - 5 | `operatorID` | `uint16` | Resolved ID of the Operator (Last 4 hex digits of UID). |
| 6 - 7 | `areaID` | `uint16` | Resolved ID of the Area (Last 4 hex digits of UID). |
| 8 - 9 | `equipmentID` | `uint16` | Resolved ID of the Equipment (Last 4 hex digits of UID). |
| 10 - 13 | `timestamp` | `uint32` | Transmission timestamp (Epoch seconds). |
| 14 - 15 | `totalRecord` | `uint16` | Total number of `working_results` included. |
| 16 - 17 | `productivity` | `uint16` | Calculated productivity (ha/hours × 1000). |
| 18 - 19 | `production` | `uint16` | Count of total spots (equivalent to `totalRecord`). |
| 20 - 23 | `lastPosLat` | `int32` | Latitude of the first/last spot × 10,000,000. |
| 24 - 27 | `lastPosLng` | `int32` | Longitude of the first/last spot × 10,000,000. |
| 28 | `avgAccuracy` | `uint8` | Average GPS Horizontal accuracy scaled by 10 (avgAccuracy * 10, capped 0-255). |

---

## 3. Record Structure (18 Bytes per Spot)

| Offset | Field | Type | Description |
|---|---|---|---|
| 0 - 1 | `index` | `uint16` | Relative index of the spot in the current package. |
| 2 - 5 | `lat` | `int32` | Latitude × 10,000,000. |
| 6 - 9 | `lng` | `int32` | Longitude × 10,000,000. |
| 10 | `accuracy` | `uint8` | GPS Horizontal accuracy (capped at 255). |
| 11 | `depth` | `uint8` | Excavation depth (capped at 255). |
| 12 - 15 | `timestamp` | `uint32` | Record completion timestamp (Epoch seconds). |
| 16 - 17 | `groupID` | `uint16` | Group/Team identifier (Default: 0). |

---

## 4. ID Resolution Logic (The "Last 4 Hex" Rule)

Firebase/Firestore UIDs are typically strings (e.g., `OPr87AB`). The binary protocol requires 16-bit integers.

**Logic:**
1. Take the **last 4 characters** of the UID string.
2. Parse as **Hexadecimal** (Radix 16).
3. If parsing fails or UID is null, default to `0`.

**Dart Implementation:**
```dart
int extractId(String? uid) {
  if (uid == null || uid.length < 4) return 0;
  final last4 = uid.substring(uid.length - 4);
  return int.tryParse(last4, radix: 16) ?? 0;
}
```

---

## 5. Calculation Formulas

### Productivity
Formula: `((Total Spots / Hours Elapsed) * (Width * Length / 10,000)) * 1000`
- Constants for EGS: Width=4m, Length=1.87m.
- Simplified: `(SpotsPerHour * 0.748)` converted to Int.

### WorkHours
Formula: Sum of sequential time gaps between spots recorded in the same shift.
- Only gaps between **1.0 and 300.0 seconds** are accumulated to avoid idle time inflation.
- Stored as `uint16` in seconds.

### Coordinate Compression
To maintain precision without floating point overhead:
- `Int32 = (Double Coordinate * 10,000,000).toInt()`

---

> [!NOTE]
> This protocol is used exclusively when calling `PayloadBuilder.buildSyncPayload()` and sending the resulting buffer via `ComService.sendRawDataToHost()`.
