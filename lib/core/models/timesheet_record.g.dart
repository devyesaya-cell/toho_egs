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
    r'accuracy': PropertySchema(
      id: 0,
      name: r'accuracy',
      type: IsarType.double,
    ),
    r'activity': PropertySchema(id: 1, name: r'activity', type: IsarType.long),
    r'activityName': PropertySchema(
      id: 2,
      name: r'activityName',
      type: IsarType.string,
    ),
    r'activityType': PropertySchema(
      id: 3,
      name: r'activityType',
      type: IsarType.string,
    ),
    r'activityTypeInt': PropertySchema(
      id: 4,
      name: r'activityTypeInt',
      type: IsarType.long,
    ),
    r'alarm': PropertySchema(id: 5, name: r'alarm', type: IsarType.long),
    r'areaUid': PropertySchema(id: 6, name: r'areaUid', type: IsarType.string),
    r'compUid': PropertySchema(id: 7, name: r'compUid', type: IsarType.string),
    r'endTime': PropertySchema(id: 8, name: r'endTime', type: IsarType.long),
    r'equUid': PropertySchema(id: 9, name: r'equUid', type: IsarType.string),
    r'fuel': PropertySchema(id: 10, name: r'fuel', type: IsarType.double),
    r'hmEnd': PropertySchema(id: 11, name: r'hmEnd', type: IsarType.double),
    r'hmStart': PropertySchema(id: 12, name: r'hmStart', type: IsarType.double),
    r'modeSystem': PropertySchema(
      id: 13,
      name: r'modeSystem',
      type: IsarType.string,
    ),
    r'opUid': PropertySchema(id: 14, name: r'opUid', type: IsarType.string),
    r'personID': PropertySchema(
      id: 15,
      name: r'personID',
      type: IsarType.string,
    ),
    r'production': PropertySchema(
      id: 16,
      name: r'production',
      type: IsarType.double,
    ),
    r'productivity': PropertySchema(
      id: 17,
      name: r'productivity',
      type: IsarType.double,
    ),
    r'startTime': PropertySchema(
      id: 18,
      name: r'startTime',
      type: IsarType.long,
    ),
    r'totalSpots': PropertySchema(
      id: 19,
      name: r'totalSpots',
      type: IsarType.double,
    ),
    r'totalTime': PropertySchema(
      id: 20,
      name: r'totalTime',
      type: IsarType.long,
    ),
    r'workhours': PropertySchema(
      id: 21,
      name: r'workhours',
      type: IsarType.double,
    ),
    r'workspeed': PropertySchema(
      id: 22,
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
  {
    final value = object.areaUid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.compUid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.equUid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.modeSystem.length * 3;
  {
    final value = object.opUid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.personID.length * 3;
  return bytesCount;
}

void _timesheetRecordSerialize(
  TimesheetRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.accuracy);
  writer.writeLong(offsets[1], object.activity);
  writer.writeString(offsets[2], object.activityName);
  writer.writeString(offsets[3], object.activityType);
  writer.writeLong(offsets[4], object.activityTypeInt);
  writer.writeLong(offsets[5], object.alarm);
  writer.writeString(offsets[6], object.areaUid);
  writer.writeString(offsets[7], object.compUid);
  writer.writeLong(offsets[8], object.endTime);
  writer.writeString(offsets[9], object.equUid);
  writer.writeDouble(offsets[10], object.fuel);
  writer.writeDouble(offsets[11], object.hmEnd);
  writer.writeDouble(offsets[12], object.hmStart);
  writer.writeString(offsets[13], object.modeSystem);
  writer.writeString(offsets[14], object.opUid);
  writer.writeString(offsets[15], object.personID);
  writer.writeDouble(offsets[16], object.production);
  writer.writeDouble(offsets[17], object.productivity);
  writer.writeLong(offsets[18], object.startTime);
  writer.writeDouble(offsets[19], object.totalSpots);
  writer.writeLong(offsets[20], object.totalTime);
  writer.writeDouble(offsets[21], object.workhours);
  writer.writeDouble(offsets[22], object.workspeed);
}

TimesheetRecord _timesheetRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimesheetRecord(
    accuracy: reader.readDoubleOrNull(offsets[0]),
    activity: reader.readLongOrNull(offsets[1]),
    activityName: reader.readString(offsets[2]),
    activityType: reader.readString(offsets[3]),
    activityTypeInt: reader.readLongOrNull(offsets[4]),
    alarm: reader.readLongOrNull(offsets[5]),
    areaUid: reader.readStringOrNull(offsets[6]),
    compUid: reader.readStringOrNull(offsets[7]),
    endTime: reader.readLong(offsets[8]),
    equUid: reader.readStringOrNull(offsets[9]),
    fuel: reader.readDoubleOrNull(offsets[10]),
    hmEnd: reader.readDouble(offsets[11]),
    hmStart: reader.readDouble(offsets[12]),
    id: id,
    modeSystem: reader.readString(offsets[13]),
    opUid: reader.readStringOrNull(offsets[14]),
    personID: reader.readString(offsets[15]),
    production: reader.readDoubleOrNull(offsets[16]),
    productivity: reader.readDoubleOrNull(offsets[17]),
    startTime: reader.readLong(offsets[18]),
    totalSpots: reader.readDouble(offsets[19]),
    totalTime: reader.readLong(offsets[20]),
    workhours: reader.readDoubleOrNull(offsets[21]),
    workspeed: reader.readDouble(offsets[22]),
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readDouble(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
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
  accuracyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accuracy'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  accuracyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accuracy'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  accuracyEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'accuracy',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  accuracyGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accuracy',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  accuracyLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accuracy',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  accuracyBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accuracy',
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
  activityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'activity'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'activity'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activity', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

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
  activityTypeIntIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'activityTypeInt'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIntIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'activityTypeInt'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIntEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityTypeInt', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIntGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activityTypeInt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIntLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activityTypeInt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  activityTypeIntBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activityTypeInt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'alarm'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'alarm'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alarm', value: value),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alarm',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alarm',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  alarmBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alarm',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'areaUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'areaUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'areaUid',
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
  areaUidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'areaUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'areaUid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'areaUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  areaUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'areaUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'compUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'compUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'compUid',
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
  compUidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'compUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'compUid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'compUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  compUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'compUid', value: ''),
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
  equUidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'equUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'equUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'equUid',
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
  equUidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'equUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'equUid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'equUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  equUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'equUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fuel'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fuel'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fuel',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fuel',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fuel',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  fuelBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fuel',
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
  hmEndEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hmEnd',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hmEnd',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hmEnd',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmEndBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hmEnd',
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
  hmStartEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hmStart',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hmStart',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hmStart',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  hmStartBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hmStart',
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
  opUidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'opUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'opUid'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'opUid',
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
  opUidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'opUid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'opUid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'opUid', value: ''),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  opUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'opUid', value: ''),
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
  productionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'production'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'production'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productionEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'production',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productionGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'production',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productionLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'production',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productionBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'production',
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
  productivityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'productivity'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productivityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'productivity'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productivityEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'productivity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productivityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'productivity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productivityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'productivity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  productivityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'productivity',
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
  workhoursIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'workhours'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workhoursIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'workhours'),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workhoursEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'workhours',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workhoursGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'workhours',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workhoursLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'workhours',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterFilterCondition>
  workhoursBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'workhours',
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
  sortByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityTypeInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeInt', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByActivityTypeIntDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeInt', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByAlarm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarm', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByAlarmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarm', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByAreaUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByAreaUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaUid', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByCompUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByCompUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compUid', Sort.desc);
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByEquUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByEquUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equUid', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuel', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByFuelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuel', Sort.desc);
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> sortByOpUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByOpUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opUid', Sort.desc);
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
  sortByProduction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'production', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByProductionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'production', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByProductivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productivity', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByProductivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productivity', Sort.desc);
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
  sortByWorkhours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workhours', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  sortByWorkhoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workhours', Sort.desc);
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
  thenByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityTypeInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeInt', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByActivityTypeIntDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeInt', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByAlarm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarm', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByAlarmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarm', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByAreaUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByAreaUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaUid', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByCompUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByCompUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compUid', Sort.desc);
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByEquUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByEquUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equUid', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuel', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByFuelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fuel', Sort.desc);
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy> thenByOpUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opUid', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByOpUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opUid', Sort.desc);
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
  thenByProduction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'production', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByProductionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'production', Sort.desc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByProductivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productivity', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByProductivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productivity', Sort.desc);
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
  thenByWorkhours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workhours', Sort.asc);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QAfterSortBy>
  thenByWorkhoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workhours', Sort.desc);
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
  distinctByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accuracy');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activity');
    });
  }

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
  distinctByActivityTypeInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeInt');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByAlarm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarm');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByAreaUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaUid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByCompUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compUid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByEquUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equUid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByFuel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fuel');
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

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct> distinctByOpUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'opUid', caseSensitive: caseSensitive);
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
  distinctByProduction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'production');
    });
  }

  QueryBuilder<TimesheetRecord, TimesheetRecord, QDistinct>
  distinctByProductivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productivity');
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
  distinctByWorkhours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workhours');
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

  QueryBuilder<TimesheetRecord, double?, QQueryOperations> accuracyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accuracy');
    });
  }

  QueryBuilder<TimesheetRecord, int?, QQueryOperations> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activity');
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

  QueryBuilder<TimesheetRecord, int?, QQueryOperations>
  activityTypeIntProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeInt');
    });
  }

  QueryBuilder<TimesheetRecord, int?, QQueryOperations> alarmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarm');
    });
  }

  QueryBuilder<TimesheetRecord, String?, QQueryOperations> areaUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaUid');
    });
  }

  QueryBuilder<TimesheetRecord, String?, QQueryOperations> compUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compUid');
    });
  }

  QueryBuilder<TimesheetRecord, int, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<TimesheetRecord, String?, QQueryOperations> equUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equUid');
    });
  }

  QueryBuilder<TimesheetRecord, double?, QQueryOperations> fuelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fuel');
    });
  }

  QueryBuilder<TimesheetRecord, double, QQueryOperations> hmEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hmEnd');
    });
  }

  QueryBuilder<TimesheetRecord, double, QQueryOperations> hmStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hmStart');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations> modeSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modeSystem');
    });
  }

  QueryBuilder<TimesheetRecord, String?, QQueryOperations> opUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'opUid');
    });
  }

  QueryBuilder<TimesheetRecord, String, QQueryOperations> personIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personID');
    });
  }

  QueryBuilder<TimesheetRecord, double?, QQueryOperations>
  productionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'production');
    });
  }

  QueryBuilder<TimesheetRecord, double?, QQueryOperations>
  productivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productivity');
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

  QueryBuilder<TimesheetRecord, double?, QQueryOperations> workhoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workhours');
    });
  }

  QueryBuilder<TimesheetRecord, double, QQueryOperations> workspeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workspeed');
    });
  }
}
