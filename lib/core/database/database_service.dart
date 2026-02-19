import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/working_spot.dart';
import '../models/person.dart';
import '../models/workfile.dart';
import '../models/equipment.dart';
import '../models/area.dart';
import '../models/contractor.dart';

class DatabaseService {
  late Isar isar;

  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Future<void> init() async {
    if (Isar.instanceNames.isNotEmpty) {
      isar = Isar.getInstance()!;
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      WorkingSpotSchema,
      PersonSchema,
      WorkFileSchema,
      EquipmentSchema,
      AreaSchema,
      ContractorSchema,
    ], directory: dir.path);
  }

  Future<void> close() async {
    await isar.close();
  }
}
