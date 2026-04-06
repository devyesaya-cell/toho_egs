# PayloadBuilder Binary Protocol Blueprint

**Path**: `lib/core/utils/payload_builder.dart`  
**Type**: Binary Protocol Utility  
**Class Name**: `PayloadBuilder`

## 1. Overview
The `PayloadBuilder` provides the binary serialization logic for transmitting locally captured work records (Spots) to the Host network. It follows a fixed-structure binary format where data is packed exactly at specified byte offsets to allow for efficient parsing by Host-side services.

---

## 2. Protocol Foundations
- **Endianness**: **Little Endian** (`Endian.little`) across all multi-byte fields.
- **Fixed Header Size**: 29 Bytes.
- **Fixed Record Size**: 18 Bytes.
- **Total Packet Length**: $29 + (\text{recordCount} \times 18)$ bytes.

---

## 3. Header Bit-Map (Offsets 0–28)

| Offset | Size | Type | Name | Description |
| :--- | :--- | :--- | :--- | :--- |
| **0** | 2 | `uint16` | `packageId` | Unique identifier for this transmission packet. |
| **2** | 2 | `uint16` | `companyId` | Default: `0` (User-agnostic placeholder). |
| **4** | 2 | `uint16` | `operatorId` | Default: `0` (User-agnostic placeholder). |
| **6** | 2 | `uint16` | `areaId` | Default: `0` (Location/Area placeholder). |
| **8** | 2 | `uint16` | `equipmentId` | Default: `0` (Machine identity placeholder). |
| **10** | 4 | `uint32` | `timestamp` | Current transmission time in **Epoch Seconds**. |
| **14** | 2 | `uint16` | `totalRecord` | Total number of `WorkingSpot` records in this packet. |
| **16** | 2 | `uint16` | `productivity` | Calculated ha/hour scaled by **1000**. |
| **18** | 2 | `uint16` | `production` | Duplicate of `totalRecord` (Work performance count). |
| **20** | 4 | `int32` | `lastPosLat` | Latitude of the first spot, scaled by **10^7**. |
| **24** | 4 | `int32` | `lastPosLng` | Longitude of the first spot, scaled by **10^7**. |
| **28** | 1 | `uint8` | `alarm` | Default: `0` (System alarm flag). |

---

## 4. Record Bit-Map (Offsets 0–17 per Record)

Each record begins immediately after the 29-byte header and repeats every 18 bytes.

| Offset | Size | Type | Name | Description |
| :--- | :--- | :--- | :--- | :--- |
| **0** | 2 | `uint16` | `index` | The current record index (0, 1, 2...). |
| **2** | 4 | `int32` | `lat` | Record latitude, scaled by **10^7**. |
| **6** | 4 | `int32` | `lng` | Record longitude, scaled by **10^7**. |
| **10** | 1 | `uint8` | `accuracy` | Horizontal accuracy as an integer. |
| **11** | 1 | `uint8` | `depth` | Excavation depth (deep) as an integer. |
| **12** | 4 | `uint32` | `timestamp` | Record creation time in **Epoch Seconds**. |
| **16** | 2 | `uint16` | `groupId` | Default: `0` (Logical record grouping). |

---

## 5. Calculation Logic

### A. Coordinate Scaling
- **Rule**: All Latitude and Longitude doubles must be converted to `int32`.
- **Formula**: `int32Val = (doubleVal * 10,000,000).toInt()`

### B. Productivity (ha/hour)
- **Rule**: Calculated as hectares per hour, then multiplied by **1000** for storage as a `uint16`.
- **Formula (Simplified)**: `productivityVal = (areaM2PerHour / 10,000) * 1000`
- **Formula (Implementation)**: `productivityVal = (spotsPerHour * 4 * 1.87 / 10,000 * 1000).toInt()`

### C. Timestamp
- **Rule**: All timestamps are converted from milliseconds (Standard Dart/Isar epoch) to **Seconds**.
- **Formula**: `epochSecs = millisecondsSinceEpoch ~/ 1000`

---

## 6. Implementation Reference 

```dart
// To rebuild in a new project:
final int recordCount = spots.length;
final ByteData byteData = ByteData(29 + (recordCount * 18));
const endian = Endian.little;
int offset = 0;

// Example bit-packing
byteData.setUint16(offset, packageId, endian); offset += 2;
// ... (pack header)
// ... (pack records in for-loop)
return byteData.buffer.asUint8List();
```

---

## 7. Verification Checklist
- [ ] Endianness is consistently specified as `Little Endian`.
- [ ] Record count is written twice (Header offsets 14 and 18).
- [ ] Coordinate scaling is exactly $10^7$ (7 digits of precision for int32).
- [ ] All timestamps are converted to seconds (32-bit).
- [ ] Header offset 28 is the single 1-byte field.
