import 'package:isar_community/isar.dart';

part 'timesheet_data.g.dart';

@collection
class TimesheetData {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? activityType;

  String? activityName;
  String? icon;

  TimesheetData({
    this.id = Isar.autoIncrement,
    this.activityType,
    this.activityName,
    this.icon,
  });
}
