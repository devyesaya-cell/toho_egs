// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEquipmentCollection on Isar {
  IsarCollection<Equipment> get equipments => this.collection();
}

const EquipmentSchema = CollectionSchema(
  name: r'Equipment',
  id: -8369049013398099124,
  properties: {
    r'armLength': PropertySchema(
      id: 0,
      name: r'armLength',
      type: IsarType.double,
    ),
    r'equipName': PropertySchema(
      id: 1,
      name: r'equipName',
      type: IsarType.string,
    ),
    r'ipAddress': PropertySchema(
      id: 2,
      name: r'ipAddress',
      type: IsarType.string,
    ),
    r'lastDriver': PropertySchema(
      id: 3,
      name: r'lastDriver',
      type: IsarType.string,
    ),
    r'lastUpdate': PropertySchema(
      id: 4,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'model': PropertySchema(id: 5, name: r'model', type: IsarType.string),
    r'partName': PropertySchema(
      id: 6,
      name: r'partName',
      type: IsarType.string,
    ),
    r'type': PropertySchema(id: 7, name: r'type', type: IsarType.string),
    r'uid': PropertySchema(id: 8, name: r'uid', type: IsarType.string),
    r'unitNumber': PropertySchema(
      id: 9,
      name: r'unitNumber',
      type: IsarType.string,
    ),
  },

  estimateSize: _equipmentEstimateSize,
  serialize: _equipmentSerialize,
  deserialize: _equipmentDeserialize,
  deserializeProp: _equipmentDeserializeProp,
  idName: r'id',
  indexes: {
    r'uid': IndexSchema(
      id: 8193695471701937315,
      name: r'uid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _equipmentGetId,
  getLinks: _equipmentGetLinks,
  attach: _equipmentAttach,
  version: '3.3.0-dev.3',
);

int _equipmentEstimateSize(
  Equipment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.equipName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ipAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastDriver;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.model;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.partName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.unitNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _equipmentSerialize(
  Equipment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.armLength);
  writer.writeString(offsets[1], object.equipName);
  writer.writeString(offsets[2], object.ipAddress);
  writer.writeString(offsets[3], object.lastDriver);
  writer.writeLong(offsets[4], object.lastUpdate);
  writer.writeString(offsets[5], object.model);
  writer.writeString(offsets[6], object.partName);
  writer.writeString(offsets[7], object.type);
  writer.writeString(offsets[8], object.uid);
  writer.writeString(offsets[9], object.unitNumber);
}

Equipment _equipmentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Equipment(
    armLength: reader.readDoubleOrNull(offsets[0]),
    equipName: reader.readStringOrNull(offsets[1]),
    ipAddress: reader.readStringOrNull(offsets[2]),
    lastDriver: reader.readStringOrNull(offsets[3]),
    lastUpdate: reader.readLongOrNull(offsets[4]),
    model: reader.readStringOrNull(offsets[5]),
    partName: reader.readStringOrNull(offsets[6]),
    type: reader.readStringOrNull(offsets[7]),
    uid: reader.readStringOrNull(offsets[8]),
    unitNumber: reader.readStringOrNull(offsets[9]),
  );
  object.id = id;
  return object;
}

P _equipmentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _equipmentGetId(Equipment object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _equipmentGetLinks(Equipment object) {
  return [];
}

void _equipmentAttach(IsarCollection<dynamic> col, Id id, Equipment object) {
  object.id = id;
}

extension EquipmentQueryWhereSort
    on QueryBuilder<Equipment, Equipment, QWhere> {
  QueryBuilder<Equipment, Equipment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EquipmentQueryWhere
    on QueryBuilder<Equipment, Equipment, QWhereClause> {
  QueryBuilder<Equipment, Equipment, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [null]),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> uidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uid',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> uidEqualTo(
    String? uid,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [uid]),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterWhereClause> uidNotEqualTo(
    String? uid,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [],
                upper: [uid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [uid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [uid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uid',
                lower: [],
                upper: [uid],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension EquipmentQueryFilter
    on QueryBuilder<Equipment, Equipment, QFilterCondition> {
  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> armLengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'armLength'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  armLengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'armLength'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> armLengthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'armLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  armLengthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'armLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> armLengthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'armLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> armLengthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'armLength',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'equipName'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  equipNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'equipName'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  equipNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'equipName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'equipName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'equipName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> equipNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'equipName', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  equipNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'equipName', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'ipAddress'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  ipAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'ipAddress'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  ipAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ipAddress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'ipAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'ipAddress',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> ipAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ipAddress', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  ipAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'ipAddress', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastDriver'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastDriverIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastDriver'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastDriverGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastDriver',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastDriverStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'lastDriver',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastDriverMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'lastDriver',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastDriverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastDriver', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastDriverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'lastDriver', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastUpdateEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  lastUpdateGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastUpdate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastUpdateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastUpdate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> lastUpdateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastUpdate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'model'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'model'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'model',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'model',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'model',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'model', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'model', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'partName'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  partNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'partName'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'partName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'partName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'partName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> partNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'partName', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  partNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'partName', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'type'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'type'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'unitNumber'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  unitNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'unitNumber'),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  unitNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'unitNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  unitNumberStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'unitNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition> unitNumberMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'unitNumber',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  unitNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'unitNumber', value: ''),
      );
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterFilterCondition>
  unitNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'unitNumber', value: ''),
      );
    });
  }
}

extension EquipmentQueryObject
    on QueryBuilder<Equipment, Equipment, QFilterCondition> {}

extension EquipmentQueryLinks
    on QueryBuilder<Equipment, Equipment, QFilterCondition> {}

extension EquipmentQuerySortBy on QueryBuilder<Equipment, Equipment, QSortBy> {
  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByArmLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'armLength', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByArmLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'armLength', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByEquipName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipName', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByEquipNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipName', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByLastDriver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDriver', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByLastDriverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDriver', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByPartName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partName', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByPartNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partName', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByUnitNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitNumber', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> sortByUnitNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitNumber', Sort.desc);
    });
  }
}

extension EquipmentQuerySortThenBy
    on QueryBuilder<Equipment, Equipment, QSortThenBy> {
  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByArmLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'armLength', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByArmLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'armLength', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByEquipName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipName', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByEquipNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipName', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByLastDriver() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDriver', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByLastDriverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDriver', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByPartName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partName', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByPartNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partName', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByUnitNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitNumber', Sort.asc);
    });
  }

  QueryBuilder<Equipment, Equipment, QAfterSortBy> thenByUnitNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitNumber', Sort.desc);
    });
  }
}

extension EquipmentQueryWhereDistinct
    on QueryBuilder<Equipment, Equipment, QDistinct> {
  QueryBuilder<Equipment, Equipment, QDistinct> distinctByArmLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'armLength');
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByEquipName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByIpAddress({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ipAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByLastDriver({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastDriver', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByModel({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByPartName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Equipment, Equipment, QDistinct> distinctByUnitNumber({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unitNumber', caseSensitive: caseSensitive);
    });
  }
}

extension EquipmentQueryProperty
    on QueryBuilder<Equipment, Equipment, QQueryProperty> {
  QueryBuilder<Equipment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Equipment, double?, QQueryOperations> armLengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'armLength');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> equipNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipName');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> ipAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ipAddress');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> lastDriverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastDriver');
    });
  }

  QueryBuilder<Equipment, int?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> partNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partName');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<Equipment, String?, QQueryOperations> unitNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unitNumber');
    });
  }
}
