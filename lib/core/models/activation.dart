import 'package:isar_community/isar.dart';

part 'activation.g.dart';

@Collection()
class Activation {
  Id id = 1; // Force singleton behavior with ID = 1

  String? token;
  bool status;
  DateTime? lastUpdate;
  String? macAddress; // Stores the Android Build ID
  String? equipmentId;

  Activation({
    this.token,
    this.status = false,
    this.lastUpdate,
    this.macAddress,
    this.equipmentId,
  });
}
