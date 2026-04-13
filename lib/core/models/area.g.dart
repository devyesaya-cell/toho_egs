// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAreaCollection on Isar {
  IsarCollection<Area> get areas => this.collection();
}

const AreaSchema = CollectionSchema(
  name: r'Area',
  id: 8329722119685603417,
  properties: {
    r'areaID': PropertySchema(id: 0, name: r'areaID', type: IsarType.string),
    r'areaName': PropertySchema(
      id: 1,
      name: r'areaName',
      type: IsarType.string,
    ),
    r'companyID': PropertySchema(
      id: 2,
      name: r'companyID',
      type: IsarType.string,
    ),
    r'contractorID': PropertySchema(
      id: 3,
      name: r'contractorID',
      type: IsarType.string,
    ),
    r'contractorName': PropertySchema(
      id: 4,
      name: r'contractorName',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 5,
      name: r'createAt',
      type: IsarType.string,
    ),
    r'endAt': PropertySchema(id: 6, name: r'endAt', type: IsarType.string),
    r'lastUpdate': PropertySchema(
      id: 7,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'luasArea': PropertySchema(
      id: 8,
      name: r'luasArea',
      type: IsarType.double,
    ),
    r'projectID': PropertySchema(
      id: 9,
      name: r'projectID',
      type: IsarType.string,
    ),
    r'spacing': PropertySchema(id: 10, name: r'spacing', type: IsarType.string),
    r'target': PropertySchema(id: 11, name: r'target', type: IsarType.double),
    r'targetDone': PropertySchema(
      id: 12,
      name: r'targetDone',
      type: IsarType.long,
    ),
    r'targetUnit': PropertySchema(
      id: 13,
      name: r'targetUnit',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(id: 14, name: r'uid', type: IsarType.string),
  },

  estimateSize: _areaEstimateSize,
  serialize: _areaSerialize,
  deserialize: _areaDeserialize,
  deserializeProp: _areaDeserializeProp,
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

  getId: _areaGetId,
  getLinks: _areaGetLinks,
  attach: _areaAttach,
  version: '3.3.0-dev.3',
);

int _areaEstimateSize(
  Area object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.areaID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.areaName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.companyID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contractorID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contractorName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.endAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.projectID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spacing;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.targetUnit;
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
  return bytesCount;
}

void _areaSerialize(
  Area object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.areaID);
  writer.writeString(offsets[1], object.areaName);
  writer.writeString(offsets[2], object.companyID);
  writer.writeString(offsets[3], object.contractorID);
  writer.writeString(offsets[4], object.contractorName);
  writer.writeString(offsets[5], object.createAt);
  writer.writeString(offsets[6], object.endAt);
  writer.writeLong(offsets[7], object.lastUpdate);
  writer.writeDouble(offsets[8], object.luasArea);
  writer.writeString(offsets[9], object.projectID);
  writer.writeString(offsets[10], object.spacing);
  writer.writeDouble(offsets[11], object.target);
  writer.writeLong(offsets[12], object.targetDone);
  writer.writeString(offsets[13], object.targetUnit);
  writer.writeString(offsets[14], object.uid);
}

Area _areaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Area(
    areaID: reader.readStringOrNull(offsets[0]),
    areaName: reader.readStringOrNull(offsets[1]),
    companyID: reader.readStringOrNull(offsets[2]),
    contractorID: reader.readStringOrNull(offsets[3]),
    contractorName: reader.readStringOrNull(offsets[4]),
    createAt: reader.readStringOrNull(offsets[5]),
    endAt: reader.readStringOrNull(offsets[6]),
    lastUpdate: reader.readLongOrNull(offsets[7]),
    luasArea: reader.readDoubleOrNull(offsets[8]),
    projectID: reader.readStringOrNull(offsets[9]),
    spacing: reader.readStringOrNull(offsets[10]),
    target: reader.readDoubleOrNull(offsets[11]),
    targetDone: reader.readLongOrNull(offsets[12]),
    targetUnit: reader.readStringOrNull(offsets[13]),
    uid: reader.readStringOrNull(offsets[14]),
  );
  object.id = id;
  return object;
}

P _areaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _areaGetId(Area object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _areaGetLinks(Area object) {
  return [];
}

void _areaAttach(IsarCollection<dynamic> col, Id id, Area object) {
  object.id = id;
}

extension AreaQueryWhereSort on QueryBuilder<Area, Area, QWhere> {
  QueryBuilder<Area, Area, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AreaQueryWhere on QueryBuilder<Area, Area, QWhereClause> {
  QueryBuilder<Area, Area, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Area, Area, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Area, Area, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterWhereClause> idBetween(
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

  QueryBuilder<Area, Area, QAfterWhereClause> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [null]),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterWhereClause> uidIsNotNull() {
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

  QueryBuilder<Area, Area, QAfterWhereClause> uidEqualTo(String? uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [uid]),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterWhereClause> uidNotEqualTo(String? uid) {
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

extension AreaQueryFilter on QueryBuilder<Area, Area, QFilterCondition> {
  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'areaID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'areaID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'areaID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'areaID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'areaID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'areaID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'areaID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'areaName'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'areaName'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'areaName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'areaName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'areaName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'areaName', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> areaNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'areaName', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'companyID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'companyID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'companyID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'companyID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'companyID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'companyID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> companyIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'companyID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'contractorID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'contractorID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'contractorID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'contractorID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'contractorID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'contractorID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'contractorID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'contractorName'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'contractorName'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'contractorName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'contractorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'contractorName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'contractorName', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> contractorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'contractorName', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createAt'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createAt'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'createAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'createAt',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createAt', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> createAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'createAt', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endAt'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endAt'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'endAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'endAt',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endAt', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> endAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'endAt', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateGreaterThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateLessThan(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> lastUpdateBetween(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'luasArea'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'luasArea'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'luasArea',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'luasArea',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'luasArea',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> luasAreaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'luasArea',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'projectID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'projectID'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'projectID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'projectID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'projectID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'projectID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> projectIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'projectID', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spacing'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spacing'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spacing',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'spacing',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'spacing',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spacing', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> spacingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'spacing', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'target'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'target'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'target',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'target',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'target',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'target',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'targetDone'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'targetDone'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'targetDone', value: value),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'targetDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'targetDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetDoneBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'targetDone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'targetUnit'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'targetUnit'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'targetUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'targetUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'targetUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'targetUnit', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> targetUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'targetUnit', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> uidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> uidEqualTo(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidGreaterThan(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidLessThan(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidBetween(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidStartsWith(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidEndsWith(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidContains(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidMatches(
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

  QueryBuilder<Area, Area, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<Area, Area, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uid', value: ''),
      );
    });
  }
}

extension AreaQueryObject on QueryBuilder<Area, Area, QFilterCondition> {}

extension AreaQueryLinks on QueryBuilder<Area, Area, QFilterCondition> {}

extension AreaQuerySortBy on QueryBuilder<Area, Area, QSortBy> {
  QueryBuilder<Area, Area, QAfterSortBy> sortByAreaID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByAreaIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByAreaName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByAreaNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByCompanyID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByCompanyIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByContractorID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByContractorIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByContractorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorName', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByContractorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorName', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByEndAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByEndAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByLuasAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByProjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByProjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTargetDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDone', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTargetDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDone', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTargetUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUnit', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByTargetUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUnit', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension AreaQuerySortThenBy on QueryBuilder<Area, Area, QSortThenBy> {
  QueryBuilder<Area, Area, QAfterSortBy> thenByAreaID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByAreaIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByAreaName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByAreaNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByCompanyID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByCompanyIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByContractorID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByContractorIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByContractorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorName', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByContractorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractorName', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByEndAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByEndAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endAt', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByLuasAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByProjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectID', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByProjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectID', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTargetDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDone', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTargetDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDone', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTargetUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUnit', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByTargetUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUnit', Sort.desc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Area, Area, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension AreaQueryWhereDistinct on QueryBuilder<Area, Area, QDistinct> {
  QueryBuilder<Area, Area, QDistinct> distinctByAreaID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByAreaName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByCompanyID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByContractorID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contractorID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByContractorName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'contractorName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByCreateAt({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByEndAt({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'luasArea');
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByProjectID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'projectID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctBySpacing({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'target');
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByTargetDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetDone');
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByTargetUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension AreaQueryProperty on QueryBuilder<Area, Area, QQueryProperty> {
  QueryBuilder<Area, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> areaIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaID');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> areaNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaName');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> companyIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyID');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> contractorIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractorID');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> contractorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractorName');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> endAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endAt');
    });
  }

  QueryBuilder<Area, int?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<Area, double?, QQueryOperations> luasAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'luasArea');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> projectIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'projectID');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> spacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spacing');
    });
  }

  QueryBuilder<Area, double?, QQueryOperations> targetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'target');
    });
  }

  QueryBuilder<Area, int?, QQueryOperations> targetDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetDone');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> targetUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetUnit');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
