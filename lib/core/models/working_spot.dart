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
      status: json['status'],
      driverID: json['driverID'],
      fileID: json['fileID'],
      spotID: json['spotID'],
      totalTime: json['totalTime'],
      akurasi: json['akurasi'],
      deep: json['deep'],
      lat: json['lat'],
      lng: json['lng'],
      alt: json['alt'],
      lastUpdate: json['lastUpdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'driverID': driverID,
      'fileID': fileID,
      'spotID': spotID,
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
