import 'package:isar_community/isar.dart';

part 'contractor.g.dart';

@Collection()
class Contractor {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? name;
  String? area;
  String? sector;

  double? numberEquipment;
  // Fixed typo 'numberOeator' -> 'numberOperator'
  double? numberOperator;

  int? lastUpdate;

  Contractor({
    this.uid,
    this.name,
    this.area,
    this.sector,
    this.numberEquipment,
    this.numberOperator,
    this.lastUpdate,
  });
}
