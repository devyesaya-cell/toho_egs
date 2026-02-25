import 'package:isar_community/isar.dart';

part 'timesheet_record.g.dart';

@collection
class TimesheetRecord {
  Id id; //

  @Index()
  String modeSystem;

  @Index()
  String activityType;

  @Index()
  String activityName;

  @Index()
  int totalTime;

  int startTime;
  int endTime;
  int hmStart;
  int hmEnd;
  double totalSpots;
  double workspeed;

  @Index()
  String personID;

  TimesheetRecord({
    required this.id,
    required this.modeSystem,
    required this.activityType,
    required this.activityName,
    required this.totalTime,
    required this.startTime,
    required this.endTime,
    required this.hmStart,
    required this.hmEnd,
    required this.totalSpots,
    required this.workspeed,
    required this.personID,
  });
}
