import 'package:isar_community/isar.dart';

part 'area.g.dart';

@Collection()
class Area {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? areaName;
  double? luasArea;
  String? spacing;

  int? targetDone;

  Area({this.uid, this.areaName, this.luasArea, this.spacing, this.targetDone});
}
