import 'package:isar_community/isar.dart';

part 'working_spot.g.dart';

@Collection()
class WorkingSpot {
  Id id = Isar.autoIncrement;

  @Index()
  int? status;

  @Index()
  String? driverID;

  @Index()
  String? fileID;

  @Index()
  int? spotID;

  @Index()
  String? mode;

  int? totalTime;
  double? akurasi;
  int? deep;
  double? lat;
  double? lng;
  int? alt;
  int? lastUpdate;

  WorkingSpot({
    this.status,
    this.driverID,
    this.fileID,
    this.spotID,
    this.mode,
    this.totalTime,
    this.akurasi,
    this.deep,
    this.lat,
    this.lng,
    this.alt,
    this.lastUpdate,
  });

  factory WorkingSpot.fromJson(Map<String, dynamic> json) {
    return WorkingSpot(
      // int? fields: safe cast via (as num?)?.toInt() to handle both int and double in JSON
      status: (json['status'] as num?)?.toInt(),
      spotID: (json['spotID'] as num?)?.toInt(),
      totalTime: (json['totalTime'] as num?)?.toInt(),
      deep: (json['deep'] as num?)?.toInt(),
      alt: (json['alt'] as num?)?.toInt(),
      lastUpdate: (json['lastUpdate'] as num?)?.toInt(),
      // double? fields: safe cast via (as num?)?.toDouble() to handle both int and double in JSON
      akurasi: (json['akurasi'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      // String fields
      driverID: json['driverID'] as String?,
      fileID: json['fileID'] as String?,
      mode: json['mode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'driverID': driverID,
      'fileID': fileID,
      'spotID': spotID,
      'mode': mode,
      'totalTime': totalTime,
      'akurasi': akurasi,
      'deep': deep,
      'lat': lat,
      'lng': lng,
      'alt': alt,
      'lastUpdate': lastUpdate,
    };
  }
}
