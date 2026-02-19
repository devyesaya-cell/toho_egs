import 'package:isar_community/isar.dart';

part 'equipment.g.dart';

@Collection()
class Equipment {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? equipName;
  String? partName;
  String? type;

  String? unitNumber;
  String? model;
  String? ipAddress;

  // Fixed typo 'armLenght' -> 'armLength'
  double? armLength;

  int? lastUpdate;
  String? lastDriver;

  Equipment({
    this.uid,
    this.equipName,
    this.partName,
    this.type,
    this.armLength,
    this.lastUpdate,
    this.lastDriver,
    this.unitNumber,
    this.model,
    this.ipAddress,
  });
}
