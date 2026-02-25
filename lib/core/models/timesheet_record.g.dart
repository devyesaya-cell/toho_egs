// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimesheetRecordCollection on Isar {
  IsarCollection<TimesheetRecord> get timesheetRecords => this.collection();
}

const TimesheetRecordSchema = CollectionSchema(
  name: r'TimesheetRecord',
  id: 2553963115734829440,
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
    r'endTime': PropertySchema(id: 2, name: r'endTime', type: IsarType.long),
    r'hmEnd': PropertySchema(id: 3, name: r'hmEnd', type: IsarType.long),
    r'hmStart': PropertySchema(id: 4, name: r'hmStart', type: IsarType.long),
    r'modeSystem': PropertySchema(
      id: 5,
      name: r'modeSystem',
      type: IsarType.string,
    ),
    r'personID': PropertySchema(
      id: 6,
      name: r'personID',
      type: IsarType.string,
    ),
    r'startTime': PropertySchema(
      id: 7,
      name: r'startTime',
      type: IsarType.long,
    ),
    r'totalSpots': PropertySchema(
      id: 8,
      name: r'totalSpots',
      type: IsarType.double,
    ),
    r'totalTime': PropertySchema(
      id: 9,
      name: r'totalTime',
      type: IsarType.long,
    ),
    r'workspeed': PropertySchema(
      id: 10,
      name: r'workspeed',
      type: IsarType.double,
    ),
  },

  estimateSize: _timesheetRecordEstimateSize,
  serialize: _timesheetRecordSerialize,
  deserialize: _timesheetRecordDeserialize,
  deserializeProp: _timesheetRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'modeSystem': IndexSchema(
      id: 8626337158230989180,
      name: r'modeSystem',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modeSystem',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'activityType': IndexSchema(
      id: 1012544980970652462,
      name: r'activityType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'activityType',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'activityName': IndexSchema(
      id: -3417391711198963146,
      name: r'activityName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'activityName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'totalTime': IndexSchema(
      id: -9094958156418688816,
      name: r'totalTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'totalTime',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'personID': IndexSchema(
      id: -3032728716875136577,
      name: r'personID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'personID',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _timesheetRecordGetId,
  getLinks: _timesheetRecordGetLinks,
  attach: _timesheetRecordAttach,
  version: '3.3.0-dev.3',
);

int _timesheetRecordEstimateSize(
  TimesheetRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activityName.length * 3;
  bytesCount += 3 + object.activityType.length * 3;
  bytesCount += 3 + object.modeSystem.length * 3;
  bytesCount += 3 + object.personID.length * 3;
  return bytesCount;
}

void _timesheetRecordSerialize(
  TimesheetRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityName);
  writer.writeString(offsets[1], object.activityType);
  writer.writeLong(offsets[2], object.endTime);
  writer.writeLong(offsets[3], object.hmEnd);
  writer.writeLong(offsets[4], object.hmStart);
  writer.writeString(offsets[5], object.modeSystem);
  writer.writeString(offsets[6], object.personID);
  writer.writeLong(offsets[7], object.startTime);
  writer.writeDouble(offsets[8], object.totalSpots);
  writer.writeLong(offsets[9], object.totalTime);
  writer.writeDouble(offsets[10], object.workspeed);
}

TimesheetRecord _timesheetRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimesheetRecord(
    activityName: reader.readString(offsets[0]),
    activityType: reader.readString(offsets[1]),
    endTime: reader.readLong(offsets[2]),
    hmEnd: reader.readLong(offsets[3]),
    hmStart: reader.readLong(offsets[4]),
    id: id,
    modeSystem: reader.readString(offsets[5]),
    personID: reader.readString(offsets[6]),
    startTime: reader.readLong(offsets[7]),
    totalSpots: reader.readDouble(offsets[8]),
    totalTime: reader.readLong(offsets[9]),
    workspeed: reader.readDouble(offsets[10]),
  );
  return object;
}

P _timesheetRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timesheetRecordGetId(TimesheetRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timesheetRecordGetLinks(TimesheetRecord object) {
  return [];
}

void _timesheetRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  TimesheetRecord object,
) {
  object.id = id;
}

extension TimesheetRecordQueryWhereSort
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QWhere> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhere> anyTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'totalTime'),
      );
    });
  }
}

extension TimesheetRecordQueryWhere
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QWhereClause> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  modeSystemEqualTo(String modeSystem) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'modeSystem', value: [modeSystem]),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  modeSystemNotEqualTo(String modeSystem) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'modeSystem',
                lower: [],
                upper: [modeSystem],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'modeSystem',
                lower: [modeSystem],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'modeSystem',
                lower: [modeSystem],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'modeSystem',
                lower: [],
                upper: [modeSystem],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  activityTypeEqualTo(String activityType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'activityType',
          value: [activityType],
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  activityTypeNotEqualTo(String activityType) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  activityNameEqualTo(String activityName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'activityName',
          value: [activityName],
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  activityNameNotEqualTo(String activityName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityName',
                lower: [],
                upper: [activityName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityName',
                lower: [activityName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityName',
                lower: [activityName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityName',
                lower: [],
                upper: [activityName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  totalTimeEqualTo(int totalTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'totalTime', value: [totalTime]),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  totalTimeNotEqualTo(int totalTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'totalTime',
                lower: [],
                upper: [totalTime],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'totalTime',
                lower: [totalTime],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'totalTime',
                lower: [totalTime],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'totalTime',
                lower: [],
                upper: [totalTime],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  totalTimeGreaterThan(int totalTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'totalTime',
          lower: [totalTime],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  totalTimeLessThan(int totalTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'totalTime',
          lower: [],
          upper: [totalTime],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  totalTimeBetween(
    int lowerTotalTime,
    int upperTotalTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'totalTime',
          lower: [lowerTotalTime],
          includeLower: includeLower,
          upper: [upperTotalTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  personIDEqualTo(String personID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'personID', value: [personID]),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterWhereClause>
  personIDNotEqualTo(String personID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'personID',
                lower: [],
                upper: [personID],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'personID',
                lower: [personID],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'personID',
                lower: [personID],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'personID',
                lower: [],
                upper: [personID],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension TimesheetRecordQueryFilter
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QFilterCondition> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameGreaterThan(
    String value, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameLessThan(
    String value, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityName', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'activityName', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeGreaterThan(
    String value, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeLessThan(
    String value, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityType', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'activityType', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  endTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  endTimeGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  endTimeLessThan(int value, {bool include = false}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  endTimeBetween(
    int lower,
    int upper, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hmEnd', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hmEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hmEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hmEnd',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hmStart', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hmStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hmStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hmStart',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'modeSystem',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'modeSystem',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'modeSystem',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'modeSystem', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  modeSystemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'modeSystem', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'personID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'personID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'personID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'personID', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  personIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'personID', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  startTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  startTimeGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  startTimeLessThan(int value, {bool include = false}) {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  startTimeBetween(
    int lower,
    int upper, {
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalSpotsEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'totalSpots',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalSpotsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalSpots',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalSpotsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalSpots',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalSpotsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalSpots',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalTime', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalTimeGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalTimeLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  totalTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workspeedEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'workspeed',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workspeedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workspeed',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workspeedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workspeed',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workspeedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workspeed',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension TimesheetRecordQueryObject
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QFilterCondition> {}

extension TimesheetRecordQueryLinks
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QFilterCondition> {}

extension TimesheetRecordQuerySortBy
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QSortBy> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByHmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmEnd', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByHmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmEnd', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByHmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmStart', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByHmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmStart', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByModeSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modeSystem', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByModeSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modeSystem', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByPersonID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personID', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByPersonIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personID', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByTotalSpots() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpots', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByTotalSpotsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpots', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByWorkspeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workspeed', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByWorkspeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workspeed', Sort.desc);
    });
  }
}

extension TimesheetRecordQuerySortThenBy
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QSortThenBy> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityName', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByHmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmEnd', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByHmEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmEnd', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByHmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmStart', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByHmStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hmStart', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByModeSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modeSystem', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByModeSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modeSystem', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByPersonID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personID', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByPersonIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personID', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByTotalSpots() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpots', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByTotalSpotsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpots', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByWorkspeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workspeed', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByWorkspeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workspeed', Sort.desc);
    });
  }
}

extension TimesheetRecordQueryWhereDistinct
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> {
  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByActivityName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByActivityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByHmEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hmEnd');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByHmStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hmStart');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByModeSystem({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modeSystem', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByPersonID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByTotalSpots() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpots');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTime');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByWorkspeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workspeed');
    });
  }
}

extension TimesheetRecordQueryProperty
    on QueryBuilder<TimesheetRecord, TimesheetRecord, QQueryProperty> {
  QueryBuilder<TimesheetRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations>
  activityNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityName');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations>
  activityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityType');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> hmEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hmEnd');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> hmStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hmStart');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations> modeSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modeSystem');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations> personIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personID');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<TimesheetRecord, double, QQueryOperations> totalSpotsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpots');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> totalTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTime');
    });
  }

  QueryBuilder<TimesheetRecord, double, QQueryOperations> workspeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workspeed');
    });
  }
}
