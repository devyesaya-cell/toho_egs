import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:toho_egs/core/models/timesheet_record.dart';

void main() {
  test('Verify TimesheetRecord.toJson()', () {
    final record = TimesheetRecord(
      id: 12345,
      modeSystem: 'EGS',
      activityType: 'MDT',
      activityName: 'Production',
      totalTime: 3600,
      startTime: 1713945600,
      endTime: 1713949200,
      hmStart: 1234.5,
      hmEnd: 1240.75,
      totalSpots: 10,
      workspeed: 5.5,
      personID: 'person_001',
      compUid: '6618f1a2c9d4e3b5a7c81111',
      opUid: '6618f1a2c9d4e3b5a7c89999',
      equUid: '6618f1a2c9d4e3b5a7c87777',
      areaUid: '6618f1a2c9d4e3b5a7c86666',
      fuel: 56.3,
      activityTypeInt: 2,
      productivity: 75.5,
      production: 120.8,
      accuracy: 98.7,
      alarm: 0,
      workhours: 8.5,
    );

    final jsonMap = record.toJson();
    final jsonStr = JsonEncoder.withIndent('  ').convert(jsonMap);
    print(jsonStr);

    expect(jsonMap['id'], 12345);
    expect(jsonMap['comp_uid'], '6618f1a2c9d4e3b5a7c81111');
    expect(jsonMap['times_start'], '2024-04-24T08:00:00.000'); // Note: depends on timezone, might need adjustment if UTC is intended
    // In Dart, toIso8601String() doesn't add 'Z' unless it's UTC.
    // The user example had 'Z'.
  });
}
