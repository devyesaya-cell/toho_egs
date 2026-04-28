// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_data_result.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSyncDataResultCollection on Isar {
  IsarCollection<SyncDataResult> get syncDataResults => this.collection();
}

const SyncDataResultSchema = CollectionSchema(
  name: r'SyncDataResult',
  id: -296969202084185009,
  properties: {
    r'driverID': PropertySchema(
      id: 0,
      name: r'driverID',
      type: IsarType.string,
    ),
    r'endTime': PropertySchema(id: 1, name: r'endTime', type: IsarType.long),
    r'shift': PropertySchema(id: 2, name: r'shift', type: IsarType.string),
    r'shiftTime': PropertySchema(
      id: 3,
      name: r'shiftTime',
      type: IsarType.long,
    ),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.long,
    ),
    r'status': PropertySchema(id: 5, name: r'status', type: IsarType.string),
    r'syncTime': PropertySchema(id: 6, name: r'syncTime', type: IsarType.long),
    r'totalSpot': PropertySchema(
      id: 7,
      name: r'totalSpot',
      type: IsarType.long,
    ),
  },

  estimateSize: _syncDataResultEstimateSize,
  serialize: _syncDataResultSerialize,
  deserialize: _syncDataResultDeserialize,
  deserializeProp: _syncDataResultDeserializeProp,
  idName: r'id',
  indexes: {
    r'driverID': IndexSchema(
      id: 7523974413673763963,
      name: r'driverID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'driverID',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'shiftTime': IndexSchema(
      id: 6191699155322051578,
      name: r'shiftTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'shiftTime',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _syncDataResultGetId,
  getLinks: _syncDataResultGetLinks,
  attach: _syncDataResultAttach,
  version: '3.3.0-dev.3',
);

int _syncDataResultEstimateSize(
  SyncDataResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.driverID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shift;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _syncDataResultSerialize(
  SyncDataResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.driverID);
  writer.writeLong(offsets[1], object.endTime);
  writer.writeString(offsets[2], object.shift);
  writer.writeLong(offsets[3], object.shiftTime);
  writer.writeLong(offsets[4], object.startTime);
  writer.writeString(offsets[5], object.status);
  writer.writeLong(offsets[6], object.syncTime);
  writer.writeLong(offsets[7], object.totalSpot);
}

SyncDataResult _syncDataResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SyncDataResult(
    driverID: reader.readStringOrNull(offsets[0]),
    endTime: reader.readLongOrNull(offsets[1]),
    shift: reader.readStringOrNull(offsets[2]),
    shiftTime: reader.readLongOrNull(offsets[3]),
    startTime: reader.readLongOrNull(offsets[4]),
    status: reader.readStringOrNull(offsets[5]),
    syncTime: reader.readLongOrNull(offsets[6]),
    totalSpot: reader.readLongOrNull(offsets[7]),
  );
  object.id = id;
  return object;
}

P _syncDataResultDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _syncDataResultGetId(SyncDataResult object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _syncDataResultGetLinks(SyncDataResult object) {
  return [];
}

void _syncDataResultAttach(
  IsarCollection<dynamic> col,
  Id id,
  SyncDataResult object,
) {
  object.id = id;
}

extension SyncDataResultQueryWhereSort
    on QueryBuilder<SyncDataResult, SyncDataResult, QWhere> {
  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhere> anyShiftTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'shiftTime'),
      );
    });
  }
}

extension SyncDataResultQueryWhere
    on QueryBuilder<SyncDataResult, SyncDataResult, QWhereClause> {
  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> idBetween(
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  driverIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'driverID', value: [null]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  driverIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'driverID',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  driverIDEqualTo(String? driverID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'driverID', value: [driverID]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  driverIDNotEqualTo(String? driverID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'driverID',
                lower: [],
                upper: [driverID],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'driverID',
                lower: [driverID],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'driverID',
                lower: [driverID],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'driverID',
                lower: [],
                upper: [driverID],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [null]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'status',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause> statusEqualTo(
    String? status,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [status]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  statusNotEqualTo(String? status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'status',
                lower: [],
                upper: [status],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'status',
                lower: [status],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'status',
                lower: [status],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'status',
                lower: [],
                upper: [status],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'shiftTime', value: [null]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'shiftTime',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeEqualTo(int? shiftTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'shiftTime', value: [shiftTime]),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeNotEqualTo(int? shiftTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'shiftTime',
                lower: [],
                upper: [shiftTime],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'shiftTime',
                lower: [shiftTime],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'shiftTime',
                lower: [shiftTime],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'shiftTime',
                lower: [],
                upper: [shiftTime],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeGreaterThan(int? shiftTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'shiftTime',
          lower: [shiftTime],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeLessThan(int? shiftTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'shiftTime',
          lower: [],
          upper: [shiftTime],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterWhereClause>
  shiftTimeBetween(
    int? lowerShiftTime,
    int? upperShiftTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'shiftTime',
          lower: [lowerShiftTime],
          includeLower: includeLower,
          upper: [upperShiftTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SyncDataResultQueryFilter
    on QueryBuilder<SyncDataResult, SyncDataResult, QFilterCondition> {
  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'driverID'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'driverID'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'driverID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'driverID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'driverID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'driverID', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  driverIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'driverID', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  endTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'shift'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'shift'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'shift',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'shift',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'shift',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'shift', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'shift', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'shiftTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'shiftTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'shiftTime', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'shiftTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'shiftTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  shiftTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'shiftTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'startTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'startTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  startTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusGreaterThan(
    String? value, {
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusLessThan(
    String? value, {
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
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

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'syncTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'syncTime'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncTime', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  syncTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'totalSpot'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'totalSpot'),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalSpot', value: value),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalSpot',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalSpot',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterFilterCondition>
  totalSpotBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalSpot',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SyncDataResultQueryObject
    on QueryBuilder<SyncDataResult, SyncDataResult, QFilterCondition> {}

extension SyncDataResultQueryLinks
    on QueryBuilder<SyncDataResult, SyncDataResult, QFilterCondition> {}

extension SyncDataResultQuerySortBy
    on QueryBuilder<SyncDataResult, SyncDataResult, QSortBy> {
  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByDriverID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByDriverIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByShiftTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByShiftTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortBySyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortBySyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> sortByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  sortByTotalSpotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.desc);
    });
  }
}

extension SyncDataResultQuerySortThenBy
    on QueryBuilder<SyncDataResult, SyncDataResult, QSortThenBy> {
  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByDriverID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByDriverIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByShift() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByShiftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shift', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByShiftTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByShiftTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenBySyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncTime', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenBySyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncTime', Sort.desc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy> thenByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.asc);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QAfterSortBy>
  thenByTotalSpotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.desc);
    });
  }
}

extension SyncDataResultQueryWhereDistinct
    on QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> {
  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> distinctByDriverID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> distinctByShift({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shift', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct>
  distinctByShiftTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftTime');
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct>
  distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct> distinctBySyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncTime');
    });
  }

  QueryBuilder<SyncDataResult, SyncDataResult, QDistinct>
  distinctByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpot');
    });
  }
}

extension SyncDataResultQueryProperty
    on QueryBuilder<SyncDataResult, SyncDataResult, QQueryProperty> {
  QueryBuilder<SyncDataResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SyncDataResult, String?, QQueryOperations> driverIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverID');
    });
  }

  QueryBuilder<SyncDataResult, int?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<SyncDataResult, String?, QQueryOperations> shiftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shift');
    });
  }

  QueryBuilder<SyncDataResult, int?, QQueryOperations> shiftTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftTime');
    });
  }

  QueryBuilder<SyncDataResult, int?, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<SyncDataResult, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<SyncDataResult, int?, QQueryOperations> syncTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncTime');
    });
  }

  QueryBuilder<SyncDataResult, int?, QQueryOperations> totalSpotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpot');
    });
  }
}
