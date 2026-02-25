// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimesheetDataCollection on Isar {
  IsarCollection<TimesheetData> get timesheetDatas => this.collection();
}

const TimesheetDataSchema = CollectionSchema(
  name: r'TimesheetData',
  id: 6660257966596941278,
  properties: {
    r'activityName': PropertySchema(
      id: 0,
      name: r'activityName',
      type: IsarType.string,
    ),
    r'activityType': PropertySchema(
      id: 1,
      name: r'activityType',
      type: IsarType.string,
    ),
    r'icon': PropertySchema(id: 2, name: r'icon', type: IsarType.string),
  },

  estimateSize: _timesheetDataEstimateSize,
  serialize: _timesheetDataSerialize,
  deserialize: _timesheetDataDeserialize,
  deserializeProp: _timesheetDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'activityType': IndexSchema(
      id: 1012544980970652462,
      name: r'activityType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'activityType',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _timesheetDataGetId,
  getLinks: _timesheetDataGetLinks,
  attach: _timesheetDataAttach,
  version: '3.3.0-dev.3',
);

int _timesheetDataEstimateSize(
  TimesheetData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activityName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.activityType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.icon;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _timesheetDataSerialize(
  TimesheetData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityName);
  writer.writeString(offsets[1], object.activityType);
  writer.writeString(offsets[2], object.icon);
}

TimesheetData _timesheetDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimesheetData(
    activityName: reader.readStringOrNull(offsets[0]),
    activityType: reader.readStringOrNull(offsets[1]),
    icon: reader.readStringOrNull(offsets[2]),
    id: id,
  );
  return object;
}

P _timesheetDataDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timesheetDataGetId(TimesheetData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timesheetDataGetLinks(TimesheetData object) {
  return [];
}

void _timesheetDataAttach(
  IsarCollection<dynamic> col,
  Id id,
  TimesheetData object,
) {
  object.id = id;
}

extension TimesheetDataQueryWhereSort
    on QueryBuilder<TimesheetData, TimesheetData, QWhere> {
  QueryBuilder<TimesheetData, TimesheetData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhere> anyActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'activityType'),
      );
    });
  }
}

extension TimesheetDataQueryWhere
    on QueryBuilder<TimesheetData, TimesheetData, QWhereClause> {
  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause> idBetween(
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

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'activityType', value: [null]),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'activityType',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeEqualTo(String? activityType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'activityType',
          value: [activityType],
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeNotEqualTo(String? activityType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityType',
                lower: [],
                upper: [activityType],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityType',
                lower: [activityType],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityType',
                lower: [activityType],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityType',
                lower: [],
                upper: [activityType],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeGreaterThan(String? activityType, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'activityType',
          lower: [activityType],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeLessThan(String? activityType, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'activityType',
          lower: [],
          upper: [activityType],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeBetween(
    String? lowerActivityType,
    String? upperActivityType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'activityType',
          lower: [lowerActivityType],
          includeLower: includeLower,
          upper: [upperActivityType],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeStartsWith(String ActivityTypePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'activityType',
          lower: [ActivityTypePrefix],
          upper: ['$ActivityTypePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'activityType', value: ['']),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterWhereClause>
  activityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(
                indexName: r'activityType',
                upper: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'activityType',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'activityType',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(
                indexName: r'activityType',
                upper: [''],
              ),
            );
      }
    });
  }
}

extension TimesheetDataQueryFilter
    on QueryBuilder<TimesheetData, TimesheetData, QFilterCondition> {
  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'activityName'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'activityName'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activityName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'activityName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'activityName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityName', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'activityName', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'activityType'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'activityType'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activityType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'activityType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'activityType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityType', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  activityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'activityType', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'icon'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'icon'),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> iconEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> iconBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'icon',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'icon',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> iconMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'icon',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'icon', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'icon', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TimesheetData, TimesheetData, QAfterFilterCondition> idBetween(
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
}

extension TimesheetDataQueryObject
    on QueryBuilder<TimesheetData, TimesheetData, QFilterCondition> {}

extension TimesheetDataQueryLinks
    on QueryBuilder<TimesheetData, TimesheetData, QFilterCondition> {}

extension TimesheetDataQuerySortBy
    on QueryBuilder<TimesheetData, TimesheetData, QSortBy> {
  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  sortByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  sortByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  sortByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  sortByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> sortByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> sortByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }
}

extension TimesheetDataQuerySortThenBy
    on QueryBuilder<TimesheetData, TimesheetData, QSortThenBy> {
  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  thenByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  thenByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  thenByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy>
  thenByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> thenByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> thenByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension TimesheetDataQueryWhereDistinct
    on QueryBuilder<TimesheetData, TimesheetData, QDistinct> {
  QueryBuilder<TimesheetData, TimesheetData, QDistinct> distinctByActivityName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QDistinct> distinctByActivityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetData, TimesheetData, QDistinct> distinctByIcon({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icon', caseSensitive: caseSensitive);
    });
  }
}

extension TimesheetDataQueryProperty
    on QueryBuilder<TimesheetData, TimesheetData, QQueryProperty> {
  QueryBuilder<TimesheetData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimesheetData, String?, QQueryOperations>
  activityNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityName');
    });
  }

  QueryBuilder<TimesheetData, String?, QQueryOperations>
  activityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityType');
    });
  }

  QueryBuilder<TimesheetData, String?, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }
}
