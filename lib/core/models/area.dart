import 'package:isar_community/isar.dart';

part 'area.g.dart';

@Collection()
class Area {
  Id id = Isar.autoIncrement;

  @Index()
  String? uid;

  String? projectID;
  String? areaID;
  String? areaName;
  String? contractorName;
  String? companyID;
  String? contractorID;
  double? target;
  String? targetUnit;
  String? createAt;
  String? endAt;
  int? lastUpdate;

  // Existing fields retained for compatibility
  double? luasArea;
  String? spacing;
  int? targetDone;

  Area({
    this.uid,
    this.projectID,
    this.areaID,
    this.areaName,
    this.contractorName,
    this.companyID,
    this.contractorID,
    this.target,
    this.targetUnit,
    this.createAt,
    this.endAt,
    this.lastUpdate,
    this.luasArea,
    this.spacing,
    this.targetDone,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      uid: json['uid']?.toString(),
      projectID: json['projectID']?.toString(),
      areaID: json['areaID']?.toString(),
      areaName: json['areaName']?.toString(),
      contractorName: json['contractorName']?.toString(),
      companyID: json['companyID']?.toString(),
      contractorID: json['contractorID']?.toString(),
      target: (json['target'] as num?)?.toDouble(),
      targetUnit: json['targetUnit']?.toString(),
      createAt: json['createAt']?.toString(),
      endAt: json['endAt']?.toString(),
      lastUpdate: _parseTimestamp(json['lastUpdate']),
      luasArea: (json['luasArea'] as num?)?.toDouble(),
      spacing: json['spacing']?.toString(),
      targetDone: json['targetDone'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'projectID': projectID,
      'areaID': areaID,
      'areaName': areaName,
      'contractorName': contractorName,
      'companyID': companyID,
      'contractorID': contractorID,
      'target': target,
      'targetUnit': targetUnit,
      'createAt': createAt,
      'endAt': endAt,
      'lastUpdate': lastUpdate?.toString(), // Simple string export for verification
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
