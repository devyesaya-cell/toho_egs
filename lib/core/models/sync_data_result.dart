import 'package:isar_community/isar.dart';

part 'sync_data_result.g.dart';

@Collection()
class SyncDataResult {
  Id id = Isar.autoIncrement;

  @Index()
  String? driverID;

  int? startTime;
  int? endTime;

  @Index()
  String? status; // "pending" or "sent"

  String? shift; // "pagi" or "malam"

  @Index()
  int? shiftTime;

  int? syncTime;
  int? totalSpot;

  SyncDataResult({
    this.driverID,
    this.startTime,
    this.endTime,
    this.status,
    this.shift,
    this.shiftTime,
    this.syncTime,
    this.totalSpot,
  });

  factory SyncDataResult.fromJson(Map<String, dynamic> json) {
    return SyncDataResult(
      driverID: json['driverID'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      shift: json['shift'],
      shiftTime: json['shiftTime'],
      syncTime: json['syncTime'],
      totalSpot: json['totalSpot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverID': driverID,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'shift': shift,
      'shiftTime': shiftTime,
      'syncTime': syncTime,
      'totalSpot': totalSpot,
    };
  }
}
