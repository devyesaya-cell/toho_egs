import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../core/database/database_service.dart';
import '../models/person.dart';
import '../models/workfile.dart';
import '../models/equipment.dart';
import '../models/area.dart';
import '../models/contractor.dart';
import '../models/working_spot.dart';

// Provides the generic AppRepository
final appRepositoryProvider = Provider<AppRepository>((ref) {
  final dbService = DatabaseService();
  return AppRepository(dbService.isar);
});

class AppRepository {
  final Isar _isar;

  AppRepository(this._isar);

  // --- WorkingSpot ---
  Future<void> saveWorkingSpots(List<WorkingSpot> spots) async {
    await _isar.writeTxn(() async {
      await _isar.workingSpots.putAll(spots);
    });
  }

  // --- Seed Logic ---
  Future<void> checkAndSeedDefaultUser() async {
    final count = await _isar.persons.count();
    if (count == 0) {
      final defaultUser = Person(
        uid: '00001',
        firstName: 'admin',
        lastName: 'Toho',
        kontraktor: 'Toho',
        role: 'admin',
        preset: 'spot',
        user: 'admin',
        password: 'asd123', // Hardcoded as requested
        loginState: 'OFF',
        lastLogin: DateTime.now().millisecondsSinceEpoch,
      );

      await _isar.writeTxn(() async {
        await _isar.persons.put(defaultUser);
      });
      print('Default user seeded: admin / asd123');
    }
  }

  // --- Person ---
  Future<List<Person>> getAllPersons() async {
    return await _isar.persons.where().findAll();
  }

  Future<void> savePerson(Person person) async {
    await _isar.writeTxn(() async {
      await _isar.persons.put(person);
    });
  }

  Future<void> deletePerson(int id) async {
    await _isar.writeTxn(() async {
      await _isar.persons.delete(id);
    });
  }

  // --- WorkFile ---
  Future<List<WorkFile>> getAllWorkFiles() async {
    return await _isar.workFiles.where().findAll();
  }

  Future<void> saveWorkFile(WorkFile workFile) async {
    await _isar.writeTxn(() async {
      await _isar.workFiles.put(workFile);
    });
  }

  Future<void> deleteWorkFile(int id, String fileID) async {
    await _isar.writeTxn(() async {
      // 1. Delete WorkFile
      await _isar.workFiles.delete(id);

      // 2. Cascade Delete WorkingSpots with same fileID
      // Note: workingSpots usually stored as Strings in `fileID` field.
      // Need to find all spots with this fileID.
      await _isar.workingSpots.filter().fileIDEqualTo(fileID).deleteAll();
    });
  }

  // --- Equipment ---
  Future<List<Equipment>> getAllEquipment() async {
    return await _isar.equipments.where().findAll();
  }

  Future<void> saveEquipment(Equipment equipment) async {
    await _isar.writeTxn(() async {
      await _isar.equipments.put(equipment);
    });
  }

  Future<void> deleteEquipment(int id) async {
    await _isar.writeTxn(() async {
      await _isar.equipments.delete(id);
    });
  }

  // --- Area ---
  Future<List<Area>> getAllAreas() async {
    return await _isar.areas.where().findAll();
  }

  Future<void> saveArea(Area area) async {
    await _isar.writeTxn(() async {
      await _isar.areas.put(area);
    });
  }

  Future<void> deleteArea(int id) async {
    await _isar.writeTxn(() async {
      await _isar.areas.delete(id);
    });
  }

  // --- Contractor ---
  Future<List<Contractor>> getAllContractors() async {
    return await _isar.contractors.where().findAll();
  }

  Future<void> saveContractor(Contractor contractor) async {
    await _isar.writeTxn(() async {
      await _isar.contractors.put(contractor);
    });
  }

  Future<void> deleteContractor(int id) async {
    await _isar.writeTxn(() async {
      await _isar.contractors.delete(id);
    });
  }

  // --- Watchers ---
  Stream<List<WorkFile>> watchWorkFiles() {
    return _isar.workFiles.where().watch(fireImmediately: true);
  }

  Stream<List<Area>> watchAreas() {
    return _isar.areas.where().watch(fireImmediately: true);
  }

  Stream<List<Contractor>> watchContractors() {
    return _isar.contractors.where().watch(fireImmediately: true);
  }

  Stream<List<Person>> watchPersons() {
    return _isar.persons.where().watch(fireImmediately: true);
  }

  Stream<List<Equipment>> watchEquipments() {
    return _isar.equipments.where().watch(fireImmediately: true);
  }
}
