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
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
