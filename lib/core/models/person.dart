import 'package:isar_community/isar.dart';

part 'person.g.dart';

@Collection()
class Person {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  @Index()
  String? firstName;

  String? lastName;

  @Index()
  String? kontraktor;

  @Index()
  String? driverID;

  String? picURL;
  String? preset;
  String? user;
  String? password;
  String? loginState;
  int? lastLogin;

  @Index()
  String? role;

  String? username;
  String? email;
  String? fullname;
  String? status;
  List<String>? groupId;
  String? created;

  String? equipment;

  Person({
    this.uid,
    this.firstName,
    this.lastName,
    this.kontraktor,
    this.driverID,
    this.picURL,
    this.preset,
    this.user,
    this.password,
    this.loginState,
    this.lastLogin,
    this.role,
    this.username,
    this.email,
    this.fullname,
    this.status,
    this.groupId,
    this.created,
    this.equipment,
    this.lastUpdate,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    final fullname = json['fullname']?.toString();
    final parts = fullname?.split(' ') ?? [];
    return Person(
      uid: json['uid']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      fullname: fullname,
      role: json['role']?.toString(),
      status: json['status']?.toString(),
      groupId: (json['groupId'] as List?)?.map((e) => e.toString()).toList(),
      created: json['created']?.toString(),
      lastUpdate: _parseTimestamp(json['lastUpdate']),
      // Legacy mapping support
      firstName: parts.isNotEmpty ? parts.first : null,
      lastName: parts.length > 1 ? parts.skip(1).join(' ') : null,
      user: json['username']?.toString(),
      loginState: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'fullname': fullname,
      'role': role,
      'status': status,
      'groupId': groupId,
      'created': created,
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

  @Index()
  int? lastUpdate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
