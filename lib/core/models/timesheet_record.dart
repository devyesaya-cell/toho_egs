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
  double hmStart;
  double hmEnd;
  double totalSpots;
  double workspeed;

  @Index()
  String personID;

  // New fields for server sync
  String? compUid;
  String? opUid;
  String? equUid;
  String? areaUid;
  double? fuel;
  int? activity;
  int? activityTypeInt;
  double? productivity;
  double? production;
  double? accuracy;
  int? alarm;
  double? workhours;

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
    this.compUid,
    this.opUid,
    this.equUid,
    this.areaUid,
    this.fuel,
    this.activity,
    this.activityTypeInt,
    this.productivity,
    this.production,
    this.accuracy,
    this.alarm,
    this.workhours,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comp_uid': compUid,
      'times_start': DateTime.fromMillisecondsSinceEpoch(startTime * 1000, isUtc: true).toIso8601String(),
      'times_finish': DateTime.fromMillisecondsSinceEpoch(endTime * 1000, isUtc: true).toIso8601String(),
      'op_uid': opUid,
      'equ_uid': equUid,
      'area_uid': areaUid,
      'hms': hmStart,
      'hmf': hmEnd,
      'fuel': fuel,
      'activity': activity,
      'activity_type': activityTypeInt,
      'productivity': productivity,
      'production': production,
      'accuracy': accuracy,
      'alarm': alarm,
      'workhours': workhours,
    };
  }



}
