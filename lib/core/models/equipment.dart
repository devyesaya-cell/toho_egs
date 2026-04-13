import 'package:isar_community/isar.dart';

part 'equipment.g.dart';

@Collection()
class Equipment {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? username;
  String? email;
  String? part_numb;
  String? type;
  String? brand;
  String? model;
  String? year;
  String? state;
  String? phone;
  List<String>? category;
  String? created_at;
  int? last_update;

  // Existing fields retained
  String? equipName;
  String? partName;
  String? unitNumber;
  String? ipAddress;
  double? armLength;
  int? lastUpdate;
  String? lastDriver;

  Equipment({
    this.uid,
    this.username,
    this.email,
    this.part_numb,
    this.type,
    this.brand,
    this.model,
    this.year,
    this.state,
    this.phone,
    this.category,
    this.created_at,
    this.last_update,
    this.equipName,
    this.partName,
    this.unitNumber,
    this.ipAddress,
    this.armLength,
    this.lastUpdate,
    this.lastDriver,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      uid: json['uid']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      part_numb: json['part_numb']?.toString(),
      type: json['type']?.toString(),
      brand: json['brand']?.toString(),
      model: json['model']?.toString(),
      year: json['year']?.toString(),
      state: json['state']?.toString(),
      phone: json['phone']?.toString(),
      category: (json['category'] as List?)?.map((e) => e.toString()).toList(),
      created_at: json['created_at']?.toString(),
      last_update: _parseTimestamp(json['last_update']),
      equipName: json['model']?.toString(),
      partName: json['part_numb']?.toString(),
      unitNumber: json['part_numb']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'part_numb': part_numb,
      'type': type,
      'brand': brand,
      'model': model,
      'year': year,
      'state': state,
      'phone': phone,
      'category': category,
      'created_at': created_at,
      'last_update': last_update?.toString(),
    };
  }

  static int? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        return DateTime.parse(value).millisecondsSinceEpoch ~/ 1000;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
