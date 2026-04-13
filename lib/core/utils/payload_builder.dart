import 'dart:typed_data';
import '../models/working_spot.dart';

class PayloadBuilder {
  static Uint8List buildSyncPayload({
    required int packageId,
    required List<WorkingSpot> workingSpots,
    int companyID = 0,
    int operatorID = 0,
    int areaID = 0,
    int equipmentID = 0,
  }) {
    // Determine the number of records
    final int recordCount = workingSpots.length;

    // The header is 29 bytes. Each record is 18 bytes.
    final int totalLength = 29 + (recordCount * 18);
    final ByteData byteData = ByteData(totalLength);
    int offset = 0;

    // Helper functions to manage Endianness effectively
    // The instructions don't strictly specify endianness. Standard network byte order is Big Endian,
    // but many times raw serial protocols use Little Endian. I'll use Little Endian as it's common
    // for embedded C platforms (like uint16_t, uint32_t usually map to little endian structs).
    const endian = Endian.little;

    // --- Header ---

    // 0-1: packageID (uint16_t: 2 bytes)
    byteData.setUint16(offset, packageId, endian);
    offset += 2;

    // 2-3: companyID (uint16_t: 2 bytes)
    byteData.setUint16(offset, companyID, endian);
    offset += 2;

    // 4-5: operatorID (uint16_t: 2 bytes)
    byteData.setUint16(offset, operatorID, endian);
    offset += 2;

    // 6-7: areaID (uint16_t: 2 bytes)
    byteData.setUint16(offset, areaID, endian);
    offset += 2;

    // 8-9: equipmentID (uint16_t: 2 bytes)
    byteData.setUint16(offset, equipmentID, endian);
    offset += 2;

    // 10-13: timestamp (uint32_t: 4 bytes) -> epoch time in second
    final int currentTimestampInSeconds =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    byteData.setUint32(offset, currentTimestampInSeconds, endian);
    offset += 4;

    // 14-15: totalRecord (uint16_t: 2 bytes)
    byteData.setUint16(offset, recordCount, endian);
    offset += 2;

    // 16-17: productivity (uint16_t: 2 bytes) -> (dibagi 1000) ha/hours
    // productivity = (total spots / hours elapsed in shift) * (4 * 1.87) / 10000 * 1000
    // But since the current hours elapsed is difficult to track accurately without knowing user login,
    // a simpler approach is total spots * expected rate. The instructions say calculate workingspots per hour:
    // "cari dulu berapa kira2 workingspot per hours nya lalu di kalikan (4x1.87) di dapatlah luas meter per jam ... dibagi 10000 ... dikalikan 1000"
    // Basically: (spotsPerHour * 4 * 1.87 / 10000) * 1000 => spotsPerHour * 0.748
    // We will estimate spotsPerHour as just `recordCount` since we might not have elapsed hours easily, or we can use the difference between first spot timestamp and current time. Let's use difference if available.

    int productivityVal = 0;
    if (recordCount > 1) {
      final firstTimeMs =
          workingSpots.first.lastUpdate ??
          DateTime.now().millisecondsSinceEpoch;
      final lastTimeMs =
          workingSpots.last.lastUpdate ?? DateTime.now().millisecondsSinceEpoch;
      final diffHours = (lastTimeMs - firstTimeMs) / (1000 * 60 * 60);

      double spotsPerHour = recordCount.toDouble();
      if (diffHours > 0.1) {
        spotsPerHour = recordCount / diffHours;
      }
      productivityVal = (spotsPerHour * 4 * 1.87 / 10000 * 1000).toInt();
    }

    byteData.setUint16(offset, productivityVal, endian);
    offset += 2;

    // 18-19: production (uint16_t: 2 bytes) -> total workingspot
    byteData.setUint16(offset, recordCount, endian);
    offset += 2;

    // 20-23: lastPosLat (int32_t: 4 bytes) -> lat * 10,000,000
    int lastLat = 0;
    if (workingSpots.isNotEmpty && workingSpots[0].lat != null) {
      lastLat = (workingSpots[0].lat! * 10000000).toInt();
    }
    byteData.setInt32(offset, lastLat, endian);
    offset += 4;

    // 24-27: lastPosLng (int32_t: 4 bytes) -> lng * 10,000,000
    int lastLng = 0;
    if (workingSpots.isNotEmpty && workingSpots[0].lng != null) {
      lastLng = (workingSpots[0].lng! * 10000000).toInt();
    }
    byteData.setInt32(offset, lastLng, endian);
    offset += 4;

    // 28: alarm (uint8_t: 1 byte) -> 0
    byteData.setUint8(offset, 0);
    offset += 1;

    // --- Records ---
    for (int i = 0; i < recordCount; i++) {
      final spot = workingSpots[i];

      // 0-1: index (uint16_t: 2 bytes)
      byteData.setUint16(offset, i, endian);
      offset += 2;

      // 2-5: lat (int32_t: 4 bytes)
      int cLat = 0;
      if (spot.lat != null) cLat = (spot.lat! * 10000000).toInt();
      byteData.setInt32(offset, cLat, endian);
      offset += 4;

      // 6-9: lng (int32_t: 4 bytes)
      int cLng = 0;
      if (spot.lng != null) cLng = (spot.lng! * 10000000).toInt();
      byteData.setInt32(offset, cLng, endian);
      offset += 4;

      // 10: accuracy (uint8_t: 1 byte)
      int cAcc = 0;
      if (spot.akurasi != null) cAcc = spot.akurasi!.toInt();
      byteData.setUint8(offset, cAcc);
      offset += 1;

      // 11: depth (uint8_t: 1 byte)
      int cDepth = 0;
      if (spot.deep != null) cDepth = spot.deep!;
      byteData.setUint8(offset, cDepth);
      offset += 1;

      // 12-15: timestamp (uint32_t: 4 bytes) -> change ms to s
      int cTime = 0;
      if (spot.lastUpdate != null) {
        cTime = spot.lastUpdate! ~/ 1000;
      }
      byteData.setUint32(offset, cTime, endian);
      offset += 4;

      // 16-17: groupID (uint16_t: 2 bytes) -> 0
      byteData.setUint16(offset, 0, endian);
      offset += 2;
    }

    return byteData.buffer.asUint8List();
  }
}
