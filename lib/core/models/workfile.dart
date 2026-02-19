import 'package:isar_community/isar.dart';

part 'workfile.g.dart';

@Collection()
class WorkFile {
  Id id = Isar.autoIncrement;

  int? uid;
  String? areaName;
  double? panjang;
  double? lebar;
  double? luasArea;

  String? contractor;
  String? equipment;

  int? totalSpot;
  int? spotDone;

  @Index()
  String? status;

  int? createAt;
  int? lastUpdate;
  int? doneAt;

  int? equipmentID;
  int? operatorID;
  int? areaID;

  WorkFile({
    this.uid,
    this.areaName,
    this.panjang,
    this.lebar,
    this.luasArea,
    this.contractor,
    this.equipment,
    this.totalSpot,
    this.spotDone,
    this.status,
    this.createAt,
    this.lastUpdate,
    this.doneAt,
    this.equipmentID,
    this.operatorID,
    this.areaID,
  });
}
