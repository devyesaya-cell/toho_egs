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
    r'areaName': PropertySchema(
      id: 0,
      name: r'areaName',
      type: IsarType.string,
    ),
    r'luasArea': PropertySchema(
      id: 1,
      name: r'luasArea',
      type: IsarType.double,
    ),
    r'spacing': PropertySchema(id: 2, name: r'spacing', type: IsarType.string),
    r'targetDone': PropertySchema(
      id: 3,
      name: r'targetDone',
      type: IsarType.long,
    ),
    r'uid': PropertySchema(id: 4, name: r'uid', type: IsarType.string),
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
    final value = object.areaName;
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
  writer.writeString(offsets[0], object.areaName);
  writer.writeDouble(offsets[1], object.luasArea);
  writer.writeString(offsets[2], object.spacing);
  writer.writeLong(offsets[3], object.targetDone);
  writer.writeString(offsets[4], object.uid);
}

Area _areaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Area(
    areaName: reader.readStringOrNull(offsets[0]),
    luasArea: reader.readDoubleOrNull(offsets[1]),
    spacing: reader.readStringOrNull(offsets[2]),
    targetDone: reader.readLongOrNull(offsets[3]),
    uid: reader.readStringOrNull(offsets[4]),
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
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
  QueryBuilder<Area, Area, QDistinct> distinctByAreaName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'luasArea');
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctBySpacing({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Area, Area, QDistinct> distinctByTargetDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetDone');
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

  QueryBuilder<Area, String?, QQueryOperations> areaNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaName');
    });
  }

  QueryBuilder<Area, double?, QQueryOperations> luasAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'luasArea');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> spacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spacing');
    });
  }

  QueryBuilder<Area, int?, QQueryOperations> targetDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetDone');
    });
  }

  QueryBuilder<Area, String?, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
