import 'dart:convert';
import 'dart:typed_data';
import '../models/working_spot.dart';

class PayloadBuilder {
  static Uint8List buildSyncPayload({
    required int workHours,
    required List<WorkingSpot> workingSpots,
    double avgAccuracy = 0,
    int companyID = 0,
    int operatorID = 0,
    int areaID = 0,
    int equipmentID = 0,
    int shift = 0,
    String event = '',
  }) {
    // Determine the number of records
    final int recordCount = workingSpots.length;

    // --- Dynamic Header Calculation ---
    // Header specification:
    // 0-28: existing fields (29 bytes)
    // 29: shift (uint8: 1 byte)
    // 30: itemLength (uint8: 1 byte)
    // 31: event (variable: itemLength bytes)
    
    final List<int> eventBytes = utf8.encode(event);
    final int itemLength = eventBytes.length;
    final int headerLength = 31 + itemLength;

    // Each record is 18 bytes.
    final int totalLength = headerLength + (recordCount * 18);
    final ByteData byteData = ByteData(totalLength);
    int offset = 0;

    // Helper functions to manage Endianness effectively
    const endian = Endian.little;

    // --- Header ---

    // 0-1: workHours (uint16_t: 2 bytes) -> total seconds
    // Clamp to 0 and ensure it fits in uint16
    byteData.setUint16(offset, workHours.clamp(0, 65535), endian);
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
    int productivityVal = 0;
    if (workHours > 0) {
      double spotsPerHour = (recordCount / workHours) * 3600;
      productivityVal = (spotsPerHour * 0.748).toInt();
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

    // 28: alarm (uint8_t: 1 byte) -> now accuracy (avg)
    int scaledAccuracy = (avgAccuracy * 10).toInt().clamp(0, 255);
    byteData.setUint8(offset, scaledAccuracy);
    offset += 1;

    // 29: shift (uint8_t: 1 byte) -> enum 0-1
    byteData.setUint8(offset, shift.clamp(0, 1));
    offset += 1;

    // 30: itemLength (uint8_t: 1 byte) -> length of event string
    byteData.setUint8(offset, itemLength.clamp(0, 255));
    offset += 1;

    // 31: event (variable: itemLength bytes)
    for (int i = 0; i < itemLength; i++) {
      byteData.setUint8(offset, eventBytes[i]);
      offset += 1;
    }


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

      // 12-15: timestamp (uint32_t: 4 bytes) -> epoch time in second
      int cTime = 0;
      if (spot.lastUpdate != null) {
        cTime = spot.lastUpdate!;
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
