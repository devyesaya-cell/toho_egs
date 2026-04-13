import 'package:isar_community/isar.dart';

part 'contractor.g.dart';

@Collection()
class Contractor {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? name;
  String? title;
  String? address;
  String? phone;
  String? email;
  String? location;
  String? status;
  List<String>? category;
  String? createdAt;
  int? lastUpdate;

  // Existing fields retained
  String? area;
  String? sector;
  double? numberEquipment;
  double? numberOperator;

  Contractor({
    this.uid,
    this.name,
    this.title,
    this.address,
    this.phone,
    this.email,
    this.location,
    this.status,
    this.category,
    this.createdAt,
    this.lastUpdate,
    this.area,
    this.sector,
    this.numberEquipment,
    this.numberOperator,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      uid: json['uid']?.toString(),
      name: json['name']?.toString(),
      title: json['title']?.toString(),
      address: json['address']?.toString(),
      phone: json['phone']?.toString(),
      email: json['email']?.toString(),
      location: json['location']?.toString(),
      status: json['status']?.toString(),
      category: (json['category'] as List?)?.map((e) => e.toString()).toList(),
      createdAt: json['createdAt']?.toString(),
      lastUpdate: _parseTimestamp(json['lastUpdate']),
      area: json['area']?.toString(),
      sector: json['sector']?.toString(),
      numberEquipment: (json['numberEquipment'] as num?)?.toDouble(),
      numberOperator: (json['numberOperator'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'title': title,
      'address': address,
      'phone': phone,
      'email': email,
      'location': location,
      'status': status,
      'category': category,
      'createdAt': createdAt,
      'lastUpdate': lastUpdate?.toString(),
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
