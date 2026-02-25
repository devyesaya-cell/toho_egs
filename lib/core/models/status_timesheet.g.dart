// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_timesheet.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStatusTimesheetCollection on Isar {
  IsarCollection<StatusTimesheet> get statusTimesheets => this.collection();
}

const StatusTimesheetSchema = CollectionSchema(
  name: r'StatusTimesheet',
  id: -6622718429492882084,
  properties: {
    r'idTimesheet': PropertySchema(
      id: 0,
      name: r'idTimesheet',
      type: IsarType.long,
    ),
    r'lastUpdate': PropertySchema(
      id: 1,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'status': PropertySchema(id: 2, name: r'status', type: IsarType.string),
  },

  estimateSize: _statusTimesheetEstimateSize,
  serialize: _statusTimesheetSerialize,
  deserialize: _statusTimesheetDeserialize,
  deserializeProp: _statusTimesheetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _statusTimesheetGetId,
  getLinks: _statusTimesheetGetLinks,
  attach: _statusTimesheetAttach,
  version: '3.3.0-dev.3',
);

int _statusTimesheetEstimateSize(
  StatusTimesheet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _statusTimesheetSerialize(
  StatusTimesheet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.idTimesheet);
  writer.writeLong(offsets[1], object.lastUpdate);
  writer.writeString(offsets[2], object.status);
}

StatusTimesheet _statusTimesheetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StatusTimesheet(
    id: id,
    idTimesheet: reader.readLong(offsets[0]),
    lastUpdate: reader.readLong(offsets[1]),
    status: reader.readString(offsets[2]),
  );
  return object;
}

P _statusTimesheetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _statusTimesheetGetId(StatusTimesheet object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _statusTimesheetGetLinks(StatusTimesheet object) {
  return [];
}

void _statusTimesheetAttach(
  IsarCollection<dynamic> col,
  Id id,
  StatusTimesheet object,
) {
  object.id = id;
}

extension StatusTimesheetQueryWhereSort
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QWhere> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StatusTimesheetQueryWhere
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QWhereClause> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterWhereClause> idBetween(
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
}

extension StatusTimesheetQueryFilter
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QFilterCondition> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idTimesheetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'idTimesheet', value: value),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idTimesheetGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idTimesheet',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idTimesheetLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idTimesheet',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  idTimesheetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idTimesheet',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  lastUpdateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  lastUpdateGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  lastUpdateLessThan(int value, {bool include = false}) {
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  lastUpdateBetween(
    int lower,
    int upper, {
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

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension StatusTimesheetQueryObject
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QFilterCondition> {}

extension StatusTimesheetQueryLinks
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QFilterCondition> {}

extension StatusTimesheetQuerySortBy
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QSortBy> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  sortByIdTimesheet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTimesheet', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  sortByIdTimesheetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTimesheet', Sort.desc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension StatusTimesheetQuerySortThenBy
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QSortThenBy> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  thenByIdTimesheet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTimesheet', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  thenByIdTimesheetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTimesheet', Sort.desc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension StatusTimesheetQueryWhereDistinct
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QDistinct> {
  QueryBuilder<StatusTimesheet, StatusTimesheet, QDistinct>
  distinctByIdTimesheet() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idTimesheet');
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QDistinct>
  distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<StatusTimesheet, StatusTimesheet, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension StatusTimesheetQueryProperty
    on QueryBuilder<StatusTimesheet, StatusTimesheet, QQueryProperty> {
  QueryBuilder<StatusTimesheet, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StatusTimesheet, int, QQueryOperations> idTimesheetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idTimesheet');
    });
  }

  QueryBuilder<StatusTimesheet, int, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<StatusTimesheet, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
