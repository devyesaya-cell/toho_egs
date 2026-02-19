import 'package:isar_community/isar.dart';

class Basestatus {
  Id id = 1010;
  double batteryVoltage;
  double batteryCurrent;
  int bcc;
  int bmc;
  double lat;
  double long;
  int altitude;
  int akurasi;
  int satelit;
  String status;
  double pitch;
  double roll;
  int bsDistance;
  String chargetype;

  Basestatus({
    required this.lat,
    required this.long,
    required this.akurasi,
    required this.satelit,
    required this.status,
    required this.batteryVoltage,
    required this.batteryCurrent,
    required this.bcc,
    required this.bmc,
    required this.altitude,
    required this.pitch,
    required this.roll,
    this.bsDistance = 0,
    this.chargetype = "N/A",
  });
}
