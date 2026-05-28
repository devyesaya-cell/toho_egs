// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_logs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDebugLogsCollection on Isar {
  IsarCollection<DebugLogs> get debugLogs => this.collection();
}

const DebugLogsSchema = CollectionSchema(
  name: r'DebugLogs',
  id: 4265445823136625454,
  properties: {
    r'baseStatus': PropertySchema(
      id: 0,
      name: r'baseStatus',
      type: IsarType.object,

      target: r'BasestatusEmbedded',
    ),
    r'errorAlert': PropertySchema(
      id: 1,
      name: r'errorAlert',
      type: IsarType.object,

      target: r'ErrorAlertEmbedded',
    ),
    r'gpsLoc': PropertySchema(
      id: 2,
      name: r'gpsLoc',
      type: IsarType.object,

      target: r'GPSLocEmbedded',
    ),
    r'lastUpdate': PropertySchema(
      id: 3,
      name: r'lastUpdate',
      type: IsarType.dateTime,
    ),
    r'roverNode': PropertySchema(
      id: 4,
      name: r'roverNode',
      type: IsarType.object,

      target: r'RoverNodeDataEmbedded',
    ),
    r'sensorNode': PropertySchema(
      id: 5,
      name: r'sensorNode',
      type: IsarType.object,

      target: r'SensorNodeDataEmbedded',
    ),
  },

  estimateSize: _debugLogsEstimateSize,
  serialize: _debugLogsSerialize,
  deserialize: _debugLogsDeserialize,
  deserializeProp: _debugLogsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'GPSLocEmbedded': GPSLocEmbeddedSchema,
    r'BasestatusEmbedded': BasestatusEmbeddedSchema,
    r'RoverNodeDataEmbedded': RoverNodeDataEmbeddedSchema,
    r'SensorNodeDataEmbedded': SensorNodeDataEmbeddedSchema,
    r'ErrorAlertEmbedded': ErrorAlertEmbeddedSchema,
  },

  getId: _debugLogsGetId,
  getLinks: _debugLogsGetLinks,
  attach: _debugLogsAttach,
  version: '3.3.0-dev.3',
);

int _debugLogsEstimateSize(
  DebugLogs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.baseStatus;
    if (value != null) {
      bytesCount +=
          3 +
          BasestatusEmbeddedSchema.estimateSize(
            value,
            allOffsets[BasestatusEmbedded]!,
            allOffsets,
          );
    }
  }
  {
    final value = object.errorAlert;
    if (value != null) {
      bytesCount +=
          3 +
          ErrorAlertEmbeddedSchema.estimateSize(
            value,
            allOffsets[ErrorAlertEmbedded]!,
            allOffsets,
          );
    }
  }
  {
    final value = object.gpsLoc;
    if (value != null) {
      bytesCount +=
          3 +
          GPSLocEmbeddedSchema.estimateSize(
            value,
            allOffsets[GPSLocEmbedded]!,
            allOffsets,
          );
    }
  }
  {
    final value = object.roverNode;
    if (value != null) {
      bytesCount +=
          3 +
          RoverNodeDataEmbeddedSchema.estimateSize(
            value,
            allOffsets[RoverNodeDataEmbedded]!,
            allOffsets,
          );
    }
  }
  {
    final value = object.sensorNode;
    if (value != null) {
      bytesCount +=
          3 +
          SensorNodeDataEmbeddedSchema.estimateSize(
            value,
            allOffsets[SensorNodeDataEmbedded]!,
            allOffsets,
          );
    }
  }
  return bytesCount;
}

void _debugLogsSerialize(
  DebugLogs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<BasestatusEmbedded>(
    offsets[0],
    allOffsets,
    BasestatusEmbeddedSchema.serialize,
    object.baseStatus,
  );
  writer.writeObject<ErrorAlertEmbedded>(
    offsets[1],
    allOffsets,
    ErrorAlertEmbeddedSchema.serialize,
    object.errorAlert,
  );
  writer.writeObject<GPSLocEmbedded>(
    offsets[2],
    allOffsets,
    GPSLocEmbeddedSchema.serialize,
    object.gpsLoc,
  );
  writer.writeDateTime(offsets[3], object.lastUpdate);
  writer.writeObject<RoverNodeDataEmbedded>(
    offsets[4],
    allOffsets,
    RoverNodeDataEmbeddedSchema.serialize,
    object.roverNode,
  );
  writer.writeObject<SensorNodeDataEmbedded>(
    offsets[5],
    allOffsets,
    SensorNodeDataEmbeddedSchema.serialize,
    object.sensorNode,
  );
}

DebugLogs _debugLogsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DebugLogs(
    baseStatus: reader.readObjectOrNull<BasestatusEmbedded>(
      offsets[0],
      BasestatusEmbeddedSchema.deserialize,
      allOffsets,
    ),
    errorAlert: reader.readObjectOrNull<ErrorAlertEmbedded>(
      offsets[1],
      ErrorAlertEmbeddedSchema.deserialize,
      allOffsets,
    ),
    gpsLoc: reader.readObjectOrNull<GPSLocEmbedded>(
      offsets[2],
      GPSLocEmbeddedSchema.deserialize,
      allOffsets,
    ),
    id: id,
    lastUpdate: reader.readDateTime(offsets[3]),
    roverNode: reader.readObjectOrNull<RoverNodeDataEmbedded>(
      offsets[4],
      RoverNodeDataEmbeddedSchema.deserialize,
      allOffsets,
    ),
    sensorNode: reader.readObjectOrNull<SensorNodeDataEmbedded>(
      offsets[5],
      SensorNodeDataEmbeddedSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _debugLogsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<BasestatusEmbedded>(
            offset,
            BasestatusEmbeddedSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 1:
      return (reader.readObjectOrNull<ErrorAlertEmbedded>(
            offset,
            ErrorAlertEmbeddedSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 2:
      return (reader.readObjectOrNull<GPSLocEmbedded>(
            offset,
            GPSLocEmbeddedSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<RoverNodeDataEmbedded>(
            offset,
            RoverNodeDataEmbeddedSchema.deserialize,
            allOffsets,
          ))
          as P;
    case 5:
      return (reader.readObjectOrNull<SensorNodeDataEmbedded>(
            offset,
            SensorNodeDataEmbeddedSchema.deserialize,
            allOffsets,
          ))
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _debugLogsGetId(DebugLogs object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _debugLogsGetLinks(DebugLogs object) {
  return [];
}

void _debugLogsAttach(IsarCollection<dynamic> col, Id id, DebugLogs object) {
  object.id = id;
}

extension DebugLogsQueryWhereSort
    on QueryBuilder<DebugLogs, DebugLogs, QWhere> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DebugLogsQueryWhere
    on QueryBuilder<DebugLogs, DebugLogs, QWhereClause> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterWhereClause> idBetween(
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

extension DebugLogsQueryFilter
    on QueryBuilder<DebugLogs, DebugLogs, QFilterCondition> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> baseStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'baseStatus'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition>
  baseStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'baseStatus'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> errorAlertIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errorAlert'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition>
  errorAlertIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errorAlert'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> gpsLocIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gpsLoc'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> gpsLocIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gpsLoc'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> lastUpdateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition>
  lastUpdateGreaterThan(DateTime value, {bool include = false}) {
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> lastUpdateLessThan(
    DateTime value, {
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> lastUpdateBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> roverNodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'roverNode'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition>
  roverNodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'roverNode'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> sensorNodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sensorNode'),
      );
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition>
  sensorNodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sensorNode'),
      );
    });
  }
}

extension DebugLogsQueryObject
    on QueryBuilder<DebugLogs, DebugLogs, QFilterCondition> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> baseStatus(
    FilterQuery<BasestatusEmbedded> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'baseStatus');
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> errorAlert(
    FilterQuery<ErrorAlertEmbedded> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'errorAlert');
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> gpsLoc(
    FilterQuery<GPSLocEmbedded> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'gpsLoc');
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> roverNode(
    FilterQuery<RoverNodeDataEmbedded> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'roverNode');
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterFilterCondition> sensorNode(
    FilterQuery<SensorNodeDataEmbedded> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sensorNode');
    });
  }
}

extension DebugLogsQueryLinks
    on QueryBuilder<DebugLogs, DebugLogs, QFilterCondition> {}

extension DebugLogsQuerySortBy on QueryBuilder<DebugLogs, DebugLogs, QSortBy> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }
}

extension DebugLogsQuerySortThenBy
    on QueryBuilder<DebugLogs, DebugLogs, QSortThenBy> {
  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<DebugLogs, DebugLogs, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }
}

extension DebugLogsQueryWhereDistinct
    on QueryBuilder<DebugLogs, DebugLogs, QDistinct> {
  QueryBuilder<DebugLogs, DebugLogs, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }
}

extension DebugLogsQueryProperty
    on QueryBuilder<DebugLogs, DebugLogs, QQueryProperty> {
  QueryBuilder<DebugLogs, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DebugLogs, BasestatusEmbedded?, QQueryOperations>
  baseStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseStatus');
    });
  }

  QueryBuilder<DebugLogs, ErrorAlertEmbedded?, QQueryOperations>
  errorAlertProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorAlert');
    });
  }

  QueryBuilder<DebugLogs, GPSLocEmbedded?, QQueryOperations> gpsLocProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLoc');
    });
  }

  QueryBuilder<DebugLogs, DateTime, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<DebugLogs, RoverNodeDataEmbedded?, QQueryOperations>
  roverNodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roverNode');
    });
  }

  QueryBuilder<DebugLogs, SensorNodeDataEmbedded?, QQueryOperations>
  sensorNodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensorNode');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GPSLocEmbeddedSchema = Schema(
  name: r'GPSLocEmbedded',
  id: 8917571452083115594,
  properties: {
    r'attachAlt': PropertySchema(
      id: 0,
      name: r'attachAlt',
      type: IsarType.double,
    ),
    r'attachLat': PropertySchema(
      id: 1,
      name: r'attachLat',
      type: IsarType.double,
    ),
    r'attachLng': PropertySchema(
      id: 2,
      name: r'attachLng',
      type: IsarType.double,
    ),
    r'attachTilt': PropertySchema(
      id: 3,
      name: r'attachTilt',
      type: IsarType.double,
    ),
    r'boomAlt': PropertySchema(id: 4, name: r'boomAlt', type: IsarType.double),
    r'boomLat': PropertySchema(id: 5, name: r'boomLat', type: IsarType.double),
    r'boomLng': PropertySchema(id: 6, name: r'boomLng', type: IsarType.double),
    r'boomTilt': PropertySchema(
      id: 7,
      name: r'boomTilt',
      type: IsarType.double,
    ),
    r'bsDistance': PropertySchema(
      id: 8,
      name: r'bsDistance',
      type: IsarType.long,
    ),
    r'bucketLat': PropertySchema(
      id: 9,
      name: r'bucketLat',
      type: IsarType.double,
    ),
    r'bucketLong': PropertySchema(
      id: 10,
      name: r'bucketLong',
      type: IsarType.double,
    ),
    r'hAcc1': PropertySchema(id: 11, name: r'hAcc1', type: IsarType.long),
    r'hAcc2': PropertySchema(id: 12, name: r'hAcc2', type: IsarType.long),
    r'heading': PropertySchema(id: 13, name: r'heading', type: IsarType.double),
    r'lastBasePacket': PropertySchema(
      id: 14,
      name: r'lastBasePacket',
      type: IsarType.long,
    ),
    r'lastCorrection': PropertySchema(
      id: 15,
      name: r'lastCorrection',
      type: IsarType.long,
    ),
    r'mcuTemperature': PropertySchema(
      id: 16,
      name: r'mcuTemperature',
      type: IsarType.double,
    ),
    r'mcuVoltage': PropertySchema(
      id: 17,
      name: r'mcuVoltage',
      type: IsarType.double,
    ),
    r'pitch': PropertySchema(id: 18, name: r'pitch', type: IsarType.double),
    r'roll': PropertySchema(id: 19, name: r'roll', type: IsarType.double),
    r'rssi': PropertySchema(id: 20, name: r'rssi', type: IsarType.long),
    r'satelit': PropertySchema(id: 21, name: r'satelit', type: IsarType.long),
    r'satelit2': PropertySchema(id: 22, name: r'satelit2', type: IsarType.long),
    r'status': PropertySchema(id: 23, name: r'status', type: IsarType.string),
    r'status2': PropertySchema(id: 24, name: r'status2', type: IsarType.string),
    r'stickAlt': PropertySchema(
      id: 25,
      name: r'stickAlt',
      type: IsarType.double,
    ),
    r'stickLat': PropertySchema(
      id: 26,
      name: r'stickLat',
      type: IsarType.double,
    ),
    r'stickLng': PropertySchema(
      id: 27,
      name: r'stickLng',
      type: IsarType.double,
    ),
    r'stickTilt': PropertySchema(
      id: 28,
      name: r'stickTilt',
      type: IsarType.double,
    ),
    r'tipAlt': PropertySchema(id: 29, name: r'tipAlt', type: IsarType.double),
    r'tipLat': PropertySchema(id: 30, name: r'tipLat', type: IsarType.double),
    r'tipLng': PropertySchema(id: 31, name: r'tipLng', type: IsarType.double),
    r'trackHeight': PropertySchema(
      id: 32,
      name: r'trackHeight',
      type: IsarType.long,
    ),
    r'vAcc1': PropertySchema(id: 33, name: r'vAcc1', type: IsarType.long),
    r'vAcc2': PropertySchema(id: 34, name: r'vAcc2', type: IsarType.long),
  },

  estimateSize: _gPSLocEmbeddedEstimateSize,
  serialize: _gPSLocEmbeddedSerialize,
  deserialize: _gPSLocEmbeddedDeserialize,
  deserializeProp: _gPSLocEmbeddedDeserializeProp,
);

int _gPSLocEmbeddedEstimateSize(
  GPSLocEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _gPSLocEmbeddedSerialize(
  GPSLocEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.attachAlt);
  writer.writeDouble(offsets[1], object.attachLat);
  writer.writeDouble(offsets[2], object.attachLng);
  writer.writeDouble(offsets[3], object.attachTilt);
  writer.writeDouble(offsets[4], object.boomAlt);
  writer.writeDouble(offsets[5], object.boomLat);
  writer.writeDouble(offsets[6], object.boomLng);
  writer.writeDouble(offsets[7], object.boomTilt);
  writer.writeLong(offsets[8], object.bsDistance);
  writer.writeDouble(offsets[9], object.bucketLat);
  writer.writeDouble(offsets[10], object.bucketLong);
  writer.writeLong(offsets[11], object.hAcc1);
  writer.writeLong(offsets[12], object.hAcc2);
  writer.writeDouble(offsets[13], object.heading);
  writer.writeLong(offsets[14], object.lastBasePacket);
  writer.writeLong(offsets[15], object.lastCorrection);
  writer.writeDouble(offsets[16], object.mcuTemperature);
  writer.writeDouble(offsets[17], object.mcuVoltage);
  writer.writeDouble(offsets[18], object.pitch);
  writer.writeDouble(offsets[19], object.roll);
  writer.writeLong(offsets[20], object.rssi);
  writer.writeLong(offsets[21], object.satelit);
  writer.writeLong(offsets[22], object.satelit2);
  writer.writeString(offsets[23], object.status);
  writer.writeString(offsets[24], object.status2);
  writer.writeDouble(offsets[25], object.stickAlt);
  writer.writeDouble(offsets[26], object.stickLat);
  writer.writeDouble(offsets[27], object.stickLng);
  writer.writeDouble(offsets[28], object.stickTilt);
  writer.writeDouble(offsets[29], object.tipAlt);
  writer.writeDouble(offsets[30], object.tipLat);
  writer.writeDouble(offsets[31], object.tipLng);
  writer.writeLong(offsets[32], object.trackHeight);
  writer.writeLong(offsets[33], object.vAcc1);
  writer.writeLong(offsets[34], object.vAcc2);
}

GPSLocEmbedded _gPSLocEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GPSLocEmbedded();
  object.attachAlt = reader.readDoubleOrNull(offsets[0]);
  object.attachLat = reader.readDoubleOrNull(offsets[1]);
  object.attachLng = reader.readDoubleOrNull(offsets[2]);
  object.attachTilt = reader.readDoubleOrNull(offsets[3]);
  object.boomAlt = reader.readDoubleOrNull(offsets[4]);
  object.boomLat = reader.readDoubleOrNull(offsets[5]);
  object.boomLng = reader.readDoubleOrNull(offsets[6]);
  object.boomTilt = reader.readDoubleOrNull(offsets[7]);
  object.bsDistance = reader.readLongOrNull(offsets[8]);
  object.bucketLat = reader.readDoubleOrNull(offsets[9]);
  object.bucketLong = reader.readDoubleOrNull(offsets[10]);
  object.hAcc1 = reader.readLongOrNull(offsets[11]);
  object.hAcc2 = reader.readLongOrNull(offsets[12]);
  object.heading = reader.readDoubleOrNull(offsets[13]);
  object.lastBasePacket = reader.readLongOrNull(offsets[14]);
  object.lastCorrection = reader.readLongOrNull(offsets[15]);
  object.mcuTemperature = reader.readDoubleOrNull(offsets[16]);
  object.mcuVoltage = reader.readDoubleOrNull(offsets[17]);
  object.pitch = reader.readDoubleOrNull(offsets[18]);
  object.roll = reader.readDoubleOrNull(offsets[19]);
  object.rssi = reader.readLongOrNull(offsets[20]);
  object.satelit = reader.readLongOrNull(offsets[21]);
  object.satelit2 = reader.readLongOrNull(offsets[22]);
  object.status = reader.readStringOrNull(offsets[23]);
  object.status2 = reader.readStringOrNull(offsets[24]);
  object.stickAlt = reader.readDoubleOrNull(offsets[25]);
  object.stickLat = reader.readDoubleOrNull(offsets[26]);
  object.stickLng = reader.readDoubleOrNull(offsets[27]);
  object.stickTilt = reader.readDoubleOrNull(offsets[28]);
  object.tipAlt = reader.readDoubleOrNull(offsets[29]);
  object.tipLat = reader.readDoubleOrNull(offsets[30]);
  object.tipLng = reader.readDoubleOrNull(offsets[31]);
  object.trackHeight = reader.readLongOrNull(offsets[32]);
  object.vAcc1 = reader.readLongOrNull(offsets[33]);
  object.vAcc2 = reader.readLongOrNull(offsets[34]);
  return object;
}

P _gPSLocEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readDoubleOrNull(offset)) as P;
    case 26:
      return (reader.readDoubleOrNull(offset)) as P;
    case 27:
      return (reader.readDoubleOrNull(offset)) as P;
    case 28:
      return (reader.readDoubleOrNull(offset)) as P;
    case 29:
      return (reader.readDoubleOrNull(offset)) as P;
    case 30:
      return (reader.readDoubleOrNull(offset)) as P;
    case 31:
      return (reader.readDoubleOrNull(offset)) as P;
    case 32:
      return (reader.readLongOrNull(offset)) as P;
    case 33:
      return (reader.readLongOrNull(offset)) as P;
    case 34:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GPSLocEmbeddedQueryFilter
    on QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QFilterCondition> {
  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'attachAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'attachAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'attachAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attachAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attachAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachAltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attachAlt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'attachLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'attachLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'attachLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attachLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attachLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attachLat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'attachLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'attachLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'attachLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attachLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attachLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attachLng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'attachTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'attachTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'attachTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attachTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attachTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  attachTiltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attachTilt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'boomAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomAltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomAlt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'boomLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomLat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'boomLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomLng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'boomTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  boomTiltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomTilt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bsDistance'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bsDistance'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bsDistance', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bsDistance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bsDistance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bsDistanceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bsDistance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bucketLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bucketLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bucketLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bucketLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bucketLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bucketLat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bucketLong'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bucketLong'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bucketLong',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bucketLong',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bucketLong',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  bucketLongBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bucketLong',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'hAcc1'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'hAcc1'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hAcc1', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hAcc1',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hAcc1',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc1Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hAcc1',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'hAcc2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'hAcc2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hAcc2', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hAcc2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hAcc2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  hAcc2Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hAcc2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'heading'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'heading'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'heading',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'heading',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'heading',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  headingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'heading',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastBasePacket'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastBasePacket'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastBasePacket', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastBasePacket',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastBasePacket',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastBasePacketBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastBasePacket',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastCorrection'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastCorrection'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastCorrection', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastCorrection',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastCorrection',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  lastCorrectionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastCorrection',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mcuTemperature'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mcuTemperature'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mcuTemperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mcuTemperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mcuTemperature',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuTemperatureBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mcuTemperature',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mcuVoltage'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mcuVoltage'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mcuVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mcuVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mcuVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  mcuVoltageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mcuVoltage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pitch'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pitch'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  pitchBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pitch',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'roll'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'roll'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rollBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'roll',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rssi'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rssi'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rssi', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rssi',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rssi',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  rssiBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rssi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'satelit'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'satelit'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'satelit', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'satelit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'satelit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelitBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'satelit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'satelit2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'satelit2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'satelit2', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'satelit2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'satelit2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  satelit2Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'satelit2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
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

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2EqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2StartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2EndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status2',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status2',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status2', value: ''),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  status2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status2', value: ''),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stickAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickAltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickAlt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stickLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickLat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stickLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickLng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickTilt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stickTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickTilt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  stickTiltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickTilt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipAlt'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipAlt',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipAltBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipAlt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipLat'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipLat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipLat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tipLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tipLng'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tipLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipLng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  tipLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipLng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'trackHeight'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'trackHeight'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trackHeight', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'trackHeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'trackHeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  trackHeightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'trackHeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'vAcc1'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'vAcc1'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vAcc1', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vAcc1',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vAcc1',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc1Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vAcc1',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'vAcc2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'vAcc2'),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vAcc2', value: value),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vAcc2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vAcc2',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QAfterFilterCondition>
  vAcc2Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vAcc2',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension GPSLocEmbeddedQueryObject
    on QueryBuilder<GPSLocEmbedded, GPSLocEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BasestatusEmbeddedSchema = Schema(
  name: r'BasestatusEmbedded',
  id: -3517316721660090446,
  properties: {
    r'akurasi': PropertySchema(id: 0, name: r'akurasi', type: IsarType.long),
    r'altitude': PropertySchema(id: 1, name: r'altitude', type: IsarType.long),
    r'batteryCurrent': PropertySchema(
      id: 2,
      name: r'batteryCurrent',
      type: IsarType.double,
    ),
    r'batteryVoltage': PropertySchema(
      id: 3,
      name: r'batteryVoltage',
      type: IsarType.double,
    ),
    r'bcc': PropertySchema(id: 4, name: r'bcc', type: IsarType.long),
    r'bmc': PropertySchema(id: 5, name: r'bmc', type: IsarType.long),
    r'bsDistance': PropertySchema(
      id: 6,
      name: r'bsDistance',
      type: IsarType.long,
    ),
    r'chargetype': PropertySchema(
      id: 7,
      name: r'chargetype',
      type: IsarType.string,
    ),
    r'lat': PropertySchema(id: 8, name: r'lat', type: IsarType.double),
    r'long': PropertySchema(id: 9, name: r'long', type: IsarType.double),
    r'pitch': PropertySchema(id: 10, name: r'pitch', type: IsarType.double),
    r'roll': PropertySchema(id: 11, name: r'roll', type: IsarType.double),
    r'satelit': PropertySchema(id: 12, name: r'satelit', type: IsarType.long),
    r'status': PropertySchema(id: 13, name: r'status', type: IsarType.string),
  },

  estimateSize: _basestatusEmbeddedEstimateSize,
  serialize: _basestatusEmbeddedSerialize,
  deserialize: _basestatusEmbeddedDeserialize,
  deserializeProp: _basestatusEmbeddedDeserializeProp,
);

int _basestatusEmbeddedEstimateSize(
  BasestatusEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.chargetype;
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

void _basestatusEmbeddedSerialize(
  BasestatusEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.akurasi);
  writer.writeLong(offsets[1], object.altitude);
  writer.writeDouble(offsets[2], object.batteryCurrent);
  writer.writeDouble(offsets[3], object.batteryVoltage);
  writer.writeLong(offsets[4], object.bcc);
  writer.writeLong(offsets[5], object.bmc);
  writer.writeLong(offsets[6], object.bsDistance);
  writer.writeString(offsets[7], object.chargetype);
  writer.writeDouble(offsets[8], object.lat);
  writer.writeDouble(offsets[9], object.long);
  writer.writeDouble(offsets[10], object.pitch);
  writer.writeDouble(offsets[11], object.roll);
  writer.writeLong(offsets[12], object.satelit);
  writer.writeString(offsets[13], object.status);
}

BasestatusEmbedded _basestatusEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BasestatusEmbedded();
  object.akurasi = reader.readLongOrNull(offsets[0]);
  object.altitude = reader.readLongOrNull(offsets[1]);
  object.batteryCurrent = reader.readDoubleOrNull(offsets[2]);
  object.batteryVoltage = reader.readDoubleOrNull(offsets[3]);
  object.bcc = reader.readLongOrNull(offsets[4]);
  object.bmc = reader.readLongOrNull(offsets[5]);
  object.bsDistance = reader.readLongOrNull(offsets[6]);
  object.chargetype = reader.readStringOrNull(offsets[7]);
  object.lat = reader.readDoubleOrNull(offsets[8]);
  object.long = reader.readDoubleOrNull(offsets[9]);
  object.pitch = reader.readDoubleOrNull(offsets[10]);
  object.roll = reader.readDoubleOrNull(offsets[11]);
  object.satelit = reader.readLongOrNull(offsets[12]);
  object.status = reader.readStringOrNull(offsets[13]);
  return object;
}

P _basestatusEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BasestatusEmbeddedQueryFilter
    on QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QFilterCondition> {
  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'akurasi'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'akurasi'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'akurasi', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'akurasi',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'akurasi',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  akurasiBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'akurasi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'altitude'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'altitude'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'altitude', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'altitude',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'altitude',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  altitudeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'altitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'batteryCurrent'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'batteryCurrent'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'batteryCurrent',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'batteryCurrent',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'batteryCurrent',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryCurrentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'batteryCurrent',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'batteryVoltage'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'batteryVoltage'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'batteryVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'batteryVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'batteryVoltage',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  batteryVoltageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'batteryVoltage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bcc'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bcc'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bcc', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bcc',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bcc',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bccBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bcc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bmc'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bmc'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bmc', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bmc',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bmc',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bmcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bmc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bsDistance'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bsDistance'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bsDistance', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bsDistance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bsDistance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  bsDistanceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bsDistance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'chargetype'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'chargetype'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'chargetype',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'chargetype',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'chargetype',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'chargetype', value: ''),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  chargetypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'chargetype', value: ''),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  latBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'long'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'long'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'long',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'long',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'long',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  longBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'long',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pitch'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pitch'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pitch',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  pitchBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pitch',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'roll'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'roll'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'roll',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  rollBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'roll',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'satelit'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'satelit'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'satelit', value: value),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'satelit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'satelit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  satelitBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'satelit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
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

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension BasestatusEmbeddedQueryObject
    on QueryBuilder<BasestatusEmbedded, BasestatusEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoverNodeDataEmbeddedSchema = Schema(
  name: r'RoverNodeDataEmbedded',
  id: 3694883172787963183,
  properties: {
    r'accelX': PropertySchema(id: 0, name: r'accelX', type: IsarType.long),
    r'accelY': PropertySchema(id: 1, name: r'accelY', type: IsarType.long),
    r'accelZ': PropertySchema(id: 2, name: r'accelZ', type: IsarType.long),
    r'adc5VRaw': PropertySchema(id: 3, name: r'adc5VRaw', type: IsarType.long),
    r'boomCounter': PropertySchema(
      id: 4,
      name: r'boomCounter',
      type: IsarType.long,
    ),
    r'bsStationRx': PropertySchema(
      id: 5,
      name: r'bsStationRx',
      type: IsarType.long,
    ),
    r'bucketCounter': PropertySchema(
      id: 6,
      name: r'bucketCounter',
      type: IsarType.long,
    ),
    r'canRxTimeout': PropertySchema(
      id: 7,
      name: r'canRxTimeout',
      type: IsarType.long,
    ),
    r'crc16': PropertySchema(id: 8, name: r'crc16', type: IsarType.long),
    r'errorBits': PropertySchema(
      id: 9,
      name: r'errorBits',
      type: IsarType.long,
    ),
    r'gnss1Counter': PropertySchema(
      id: 10,
      name: r'gnss1Counter',
      type: IsarType.long,
    ),
    r'gnss2Counter': PropertySchema(
      id: 11,
      name: r'gnss2Counter',
      type: IsarType.long,
    ),
    r'length': PropertySchema(id: 12, name: r'length', type: IsarType.long),
    r'mainCounter': PropertySchema(
      id: 13,
      name: r'mainCounter',
      type: IsarType.long,
    ),
    r'offsetX': PropertySchema(id: 14, name: r'offsetX', type: IsarType.long),
    r'offsetY': PropertySchema(id: 15, name: r'offsetY', type: IsarType.long),
    r'offsetZ': PropertySchema(id: 16, name: r'offsetZ', type: IsarType.long),
    r'opcode': PropertySchema(id: 17, name: r'opcode', type: IsarType.long),
    r'rawBoom': PropertySchema(id: 18, name: r'rawBoom', type: IsarType.long),
    r'rawBucket': PropertySchema(
      id: 19,
      name: r'rawBucket',
      type: IsarType.long,
    ),
    r'rawPitch': PropertySchema(id: 20, name: r'rawPitch', type: IsarType.long),
    r'rawRoll': PropertySchema(id: 21, name: r'rawRoll', type: IsarType.long),
    r'rawStick': PropertySchema(id: 22, name: r'rawStick', type: IsarType.long),
    r'resetReason': PropertySchema(
      id: 23,
      name: r'resetReason',
      type: IsarType.long,
    ),
    r'restartNumber': PropertySchema(
      id: 24,
      name: r'restartNumber',
      type: IsarType.long,
    ),
    r'rs485Rx': PropertySchema(id: 25, name: r'rs485Rx', type: IsarType.long),
    r'scaleRawX': PropertySchema(
      id: 26,
      name: r'scaleRawX',
      type: IsarType.long,
    ),
    r'scaleRawY': PropertySchema(
      id: 27,
      name: r'scaleRawY',
      type: IsarType.long,
    ),
    r'scaleRawZ': PropertySchema(
      id: 28,
      name: r'scaleRawZ',
      type: IsarType.long,
    ),
    r'sdCardCapacity': PropertySchema(
      id: 29,
      name: r'sdCardCapacity',
      type: IsarType.long,
    ),
    r'sdCardSpeed': PropertySchema(
      id: 30,
      name: r'sdCardSpeed',
      type: IsarType.long,
    ),
    r'sensorID': PropertySchema(id: 31, name: r'sensorID', type: IsarType.long),
    r'sensorType': PropertySchema(
      id: 32,
      name: r'sensorType',
      type: IsarType.long,
    ),
    r'stickCounter': PropertySchema(
      id: 33,
      name: r'stickCounter',
      type: IsarType.long,
    ),
    r'tempRaw': PropertySchema(id: 34, name: r'tempRaw', type: IsarType.long),
    r'uptime': PropertySchema(id: 35, name: r'uptime', type: IsarType.long),
    r'vinAdcRaw': PropertySchema(
      id: 36,
      name: r'vinAdcRaw',
      type: IsarType.long,
    ),
  },

  estimateSize: _roverNodeDataEmbeddedEstimateSize,
  serialize: _roverNodeDataEmbeddedSerialize,
  deserialize: _roverNodeDataEmbeddedDeserialize,
  deserializeProp: _roverNodeDataEmbeddedDeserializeProp,
);

int _roverNodeDataEmbeddedEstimateSize(
  RoverNodeDataEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _roverNodeDataEmbeddedSerialize(
  RoverNodeDataEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accelX);
  writer.writeLong(offsets[1], object.accelY);
  writer.writeLong(offsets[2], object.accelZ);
  writer.writeLong(offsets[3], object.adc5VRaw);
  writer.writeLong(offsets[4], object.boomCounter);
  writer.writeLong(offsets[5], object.bsStationRx);
  writer.writeLong(offsets[6], object.bucketCounter);
  writer.writeLong(offsets[7], object.canRxTimeout);
  writer.writeLong(offsets[8], object.crc16);
  writer.writeLong(offsets[9], object.errorBits);
  writer.writeLong(offsets[10], object.gnss1Counter);
  writer.writeLong(offsets[11], object.gnss2Counter);
  writer.writeLong(offsets[12], object.length);
  writer.writeLong(offsets[13], object.mainCounter);
  writer.writeLong(offsets[14], object.offsetX);
  writer.writeLong(offsets[15], object.offsetY);
  writer.writeLong(offsets[16], object.offsetZ);
  writer.writeLong(offsets[17], object.opcode);
  writer.writeLong(offsets[18], object.rawBoom);
  writer.writeLong(offsets[19], object.rawBucket);
  writer.writeLong(offsets[20], object.rawPitch);
  writer.writeLong(offsets[21], object.rawRoll);
  writer.writeLong(offsets[22], object.rawStick);
  writer.writeLong(offsets[23], object.resetReason);
  writer.writeLong(offsets[24], object.restartNumber);
  writer.writeLong(offsets[25], object.rs485Rx);
  writer.writeLong(offsets[26], object.scaleRawX);
  writer.writeLong(offsets[27], object.scaleRawY);
  writer.writeLong(offsets[28], object.scaleRawZ);
  writer.writeLong(offsets[29], object.sdCardCapacity);
  writer.writeLong(offsets[30], object.sdCardSpeed);
  writer.writeLong(offsets[31], object.sensorID);
  writer.writeLong(offsets[32], object.sensorType);
  writer.writeLong(offsets[33], object.stickCounter);
  writer.writeLong(offsets[34], object.tempRaw);
  writer.writeLong(offsets[35], object.uptime);
  writer.writeLong(offsets[36], object.vinAdcRaw);
}

RoverNodeDataEmbedded _roverNodeDataEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoverNodeDataEmbedded();
  object.accelX = reader.readLongOrNull(offsets[0]);
  object.accelY = reader.readLongOrNull(offsets[1]);
  object.accelZ = reader.readLongOrNull(offsets[2]);
  object.adc5VRaw = reader.readLongOrNull(offsets[3]);
  object.boomCounter = reader.readLongOrNull(offsets[4]);
  object.bsStationRx = reader.readLongOrNull(offsets[5]);
  object.bucketCounter = reader.readLongOrNull(offsets[6]);
  object.canRxTimeout = reader.readLongOrNull(offsets[7]);
  object.crc16 = reader.readLongOrNull(offsets[8]);
  object.errorBits = reader.readLongOrNull(offsets[9]);
  object.gnss1Counter = reader.readLongOrNull(offsets[10]);
  object.gnss2Counter = reader.readLongOrNull(offsets[11]);
  object.length = reader.readLongOrNull(offsets[12]);
  object.mainCounter = reader.readLongOrNull(offsets[13]);
  object.offsetX = reader.readLongOrNull(offsets[14]);
  object.offsetY = reader.readLongOrNull(offsets[15]);
  object.offsetZ = reader.readLongOrNull(offsets[16]);
  object.opcode = reader.readLongOrNull(offsets[17]);
  object.rawBoom = reader.readLongOrNull(offsets[18]);
  object.rawBucket = reader.readLongOrNull(offsets[19]);
  object.rawPitch = reader.readLongOrNull(offsets[20]);
  object.rawRoll = reader.readLongOrNull(offsets[21]);
  object.rawStick = reader.readLongOrNull(offsets[22]);
  object.resetReason = reader.readLongOrNull(offsets[23]);
  object.restartNumber = reader.readLongOrNull(offsets[24]);
  object.rs485Rx = reader.readLongOrNull(offsets[25]);
  object.scaleRawX = reader.readLongOrNull(offsets[26]);
  object.scaleRawY = reader.readLongOrNull(offsets[27]);
  object.scaleRawZ = reader.readLongOrNull(offsets[28]);
  object.sdCardCapacity = reader.readLongOrNull(offsets[29]);
  object.sdCardSpeed = reader.readLongOrNull(offsets[30]);
  object.sensorID = reader.readLongOrNull(offsets[31]);
  object.sensorType = reader.readLongOrNull(offsets[32]);
  object.stickCounter = reader.readLongOrNull(offsets[33]);
  object.tempRaw = reader.readLongOrNull(offsets[34]);
  object.uptime = reader.readLongOrNull(offsets[35]);
  object.vinAdcRaw = reader.readLongOrNull(offsets[36]);
  return object;
}

P _roverNodeDataEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readLongOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readLongOrNull(offset)) as P;
    case 27:
      return (reader.readLongOrNull(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readLongOrNull(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readLongOrNull(offset)) as P;
    case 32:
      return (reader.readLongOrNull(offset)) as P;
    case 33:
      return (reader.readLongOrNull(offset)) as P;
    case 34:
      return (reader.readLongOrNull(offset)) as P;
    case 35:
      return (reader.readLongOrNull(offset)) as P;
    case 36:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RoverNodeDataEmbeddedQueryFilter
    on
        QueryBuilder<
          RoverNodeDataEmbedded,
          RoverNodeDataEmbedded,
          QFilterCondition
        > {
  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelX', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelY', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelZ', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'adc5VRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'adc5VRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'adc5VRaw', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'adc5VRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'adc5VRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'adc5VRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'boomCounter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bsStationRx'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bsStationRx'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bsStationRx', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bsStationRx',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bsStationRx',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bsStationRxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bsStationRx',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bucketCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bucketCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bucketCounter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bucketCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bucketCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bucketCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'canRxTimeout'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'canRxTimeout'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'canRxTimeout', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'canRxTimeout',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'canRxTimeout',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'canRxTimeout',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'crc16'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'crc16'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'crc16', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'crc16',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'crc16',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'crc16',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errorBits'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errorBits'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errorBits', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errorBits',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errorBits',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errorBits',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gnss1Counter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gnss1Counter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gnss1Counter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gnss1Counter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gnss1Counter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss1CounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gnss1Counter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gnss2Counter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gnss2Counter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gnss2Counter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gnss2Counter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gnss2Counter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  gnss2CounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gnss2Counter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'length'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'length'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'length', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'length',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'length',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'length',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mainCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mainCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mainCounter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mainCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mainCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mainCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetX', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetY', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetZ', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'opcode'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'opcode'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'opcode', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'opcode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'opcode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'opcode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rawBoom'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rawBoom'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rawBoom', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rawBoom',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rawBoom',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBoomBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rawBoom',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rawBucket'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rawBucket'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rawBucket', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rawBucket',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rawBucket',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawBucketBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rawBucket',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rawPitch'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rawPitch'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rawPitch', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rawPitch',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rawPitch',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawPitchBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rawPitch',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rawRoll'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rawRoll'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rawRoll', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rawRoll',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rawRoll',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawRollBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rawRoll',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rawStick'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rawStick'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rawStick', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rawStick',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rawStick',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rawStickBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rawStick',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'resetReason'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'resetReason'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'resetReason', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'resetReason',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'resetReason',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'resetReason',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restartNumber'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restartNumber'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restartNumber', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restartNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restartNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restartNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rs485Rx'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rs485Rx'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rs485Rx', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rs485Rx',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rs485Rx',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  rs485RxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rs485Rx',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawX'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawX', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawY'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawY', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawZ'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawZ', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sdCardCapacity'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sdCardCapacity'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sdCardCapacity', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sdCardCapacity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sdCardCapacity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardCapacityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sdCardCapacity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sdCardSpeed'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sdCardSpeed'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sdCardSpeed', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sdCardSpeed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sdCardSpeed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sdCardSpeedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sdCardSpeed',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sensorID'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sensorID'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sensorID', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sensorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sensorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sensorID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sensorType'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sensorType'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sensorType', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sensorType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sensorType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sensorType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickCounter'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stickCounter', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tempRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tempRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tempRaw', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tempRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tempRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tempRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uptime'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uptime'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uptime', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uptime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uptime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uptime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'vinAdcRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'vinAdcRaw'),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vinAdcRaw', value: value),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vinAdcRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vinAdcRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    RoverNodeDataEmbedded,
    RoverNodeDataEmbedded,
    QAfterFilterCondition
  >
  vinAdcRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vinAdcRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RoverNodeDataEmbeddedQueryObject
    on
        QueryBuilder<
          RoverNodeDataEmbedded,
          RoverNodeDataEmbedded,
          QFilterCondition
        > {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SensorNodeDataEmbeddedSchema = Schema(
  name: r'SensorNodeDataEmbedded',
  id: 4421640748243324284,
  properties: {
    r'accelX': PropertySchema(id: 0, name: r'accelX', type: IsarType.long),
    r'accelY': PropertySchema(id: 1, name: r'accelY', type: IsarType.long),
    r'accelZ': PropertySchema(id: 2, name: r'accelZ', type: IsarType.long),
    r'adc3V3Raw': PropertySchema(
      id: 3,
      name: r'adc3V3Raw',
      type: IsarType.long,
    ),
    r'adc5VRaw': PropertySchema(id: 4, name: r'adc5VRaw', type: IsarType.long),
    r'boomCounter': PropertySchema(
      id: 5,
      name: r'boomCounter',
      type: IsarType.long,
    ),
    r'bucketCounter': PropertySchema(
      id: 6,
      name: r'bucketCounter',
      type: IsarType.long,
    ),
    r'canRxTimeout': PropertySchema(
      id: 7,
      name: r'canRxTimeout',
      type: IsarType.long,
    ),
    r'crc16': PropertySchema(id: 8, name: r'crc16', type: IsarType.long),
    r'errCANSendFail': PropertySchema(
      id: 9,
      name: r'errCANSendFail',
      type: IsarType.long,
    ),
    r'errSensorRead': PropertySchema(
      id: 10,
      name: r'errSensorRead',
      type: IsarType.long,
    ),
    r'errSensorUncalib': PropertySchema(
      id: 11,
      name: r'errSensorUncalib',
      type: IsarType.long,
    ),
    r'errorBits': PropertySchema(
      id: 12,
      name: r'errorBits',
      type: IsarType.long,
    ),
    r'length': PropertySchema(id: 13, name: r'length', type: IsarType.long),
    r'mainCounter': PropertySchema(
      id: 14,
      name: r'mainCounter',
      type: IsarType.long,
    ),
    r'offsetX': PropertySchema(id: 15, name: r'offsetX', type: IsarType.long),
    r'offsetY': PropertySchema(id: 16, name: r'offsetY', type: IsarType.long),
    r'offsetZ': PropertySchema(id: 17, name: r'offsetZ', type: IsarType.long),
    r'opcode': PropertySchema(id: 18, name: r'opcode', type: IsarType.long),
    r'resetReason': PropertySchema(
      id: 19,
      name: r'resetReason',
      type: IsarType.long,
    ),
    r'restartNumber': PropertySchema(
      id: 20,
      name: r'restartNumber',
      type: IsarType.long,
    ),
    r'scaleRawX': PropertySchema(
      id: 21,
      name: r'scaleRawX',
      type: IsarType.long,
    ),
    r'scaleRawY': PropertySchema(
      id: 22,
      name: r'scaleRawY',
      type: IsarType.long,
    ),
    r'scaleRawZ': PropertySchema(
      id: 23,
      name: r'scaleRawZ',
      type: IsarType.long,
    ),
    r'sensorID': PropertySchema(id: 24, name: r'sensorID', type: IsarType.long),
    r'sensorType': PropertySchema(
      id: 25,
      name: r'sensorType',
      type: IsarType.long,
    ),
    r'sourceID': PropertySchema(id: 26, name: r'sourceID', type: IsarType.long),
    r'stickCounter': PropertySchema(
      id: 27,
      name: r'stickCounter',
      type: IsarType.long,
    ),
    r'tempRaw': PropertySchema(id: 28, name: r'tempRaw', type: IsarType.long),
    r'tiltRaw': PropertySchema(id: 29, name: r'tiltRaw', type: IsarType.long),
    r'uptime': PropertySchema(id: 30, name: r'uptime', type: IsarType.long),
  },

  estimateSize: _sensorNodeDataEmbeddedEstimateSize,
  serialize: _sensorNodeDataEmbeddedSerialize,
  deserialize: _sensorNodeDataEmbeddedDeserialize,
  deserializeProp: _sensorNodeDataEmbeddedDeserializeProp,
);

int _sensorNodeDataEmbeddedEstimateSize(
  SensorNodeDataEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sensorNodeDataEmbeddedSerialize(
  SensorNodeDataEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accelX);
  writer.writeLong(offsets[1], object.accelY);
  writer.writeLong(offsets[2], object.accelZ);
  writer.writeLong(offsets[3], object.adc3V3Raw);
  writer.writeLong(offsets[4], object.adc5VRaw);
  writer.writeLong(offsets[5], object.boomCounter);
  writer.writeLong(offsets[6], object.bucketCounter);
  writer.writeLong(offsets[7], object.canRxTimeout);
  writer.writeLong(offsets[8], object.crc16);
  writer.writeLong(offsets[9], object.errCANSendFail);
  writer.writeLong(offsets[10], object.errSensorRead);
  writer.writeLong(offsets[11], object.errSensorUncalib);
  writer.writeLong(offsets[12], object.errorBits);
  writer.writeLong(offsets[13], object.length);
  writer.writeLong(offsets[14], object.mainCounter);
  writer.writeLong(offsets[15], object.offsetX);
  writer.writeLong(offsets[16], object.offsetY);
  writer.writeLong(offsets[17], object.offsetZ);
  writer.writeLong(offsets[18], object.opcode);
  writer.writeLong(offsets[19], object.resetReason);
  writer.writeLong(offsets[20], object.restartNumber);
  writer.writeLong(offsets[21], object.scaleRawX);
  writer.writeLong(offsets[22], object.scaleRawY);
  writer.writeLong(offsets[23], object.scaleRawZ);
  writer.writeLong(offsets[24], object.sensorID);
  writer.writeLong(offsets[25], object.sensorType);
  writer.writeLong(offsets[26], object.sourceID);
  writer.writeLong(offsets[27], object.stickCounter);
  writer.writeLong(offsets[28], object.tempRaw);
  writer.writeLong(offsets[29], object.tiltRaw);
  writer.writeLong(offsets[30], object.uptime);
}

SensorNodeDataEmbedded _sensorNodeDataEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SensorNodeDataEmbedded();
  object.accelX = reader.readLongOrNull(offsets[0]);
  object.accelY = reader.readLongOrNull(offsets[1]);
  object.accelZ = reader.readLongOrNull(offsets[2]);
  object.adc3V3Raw = reader.readLongOrNull(offsets[3]);
  object.adc5VRaw = reader.readLongOrNull(offsets[4]);
  object.boomCounter = reader.readLongOrNull(offsets[5]);
  object.bucketCounter = reader.readLongOrNull(offsets[6]);
  object.canRxTimeout = reader.readLongOrNull(offsets[7]);
  object.crc16 = reader.readLongOrNull(offsets[8]);
  object.errCANSendFail = reader.readLongOrNull(offsets[9]);
  object.errSensorRead = reader.readLongOrNull(offsets[10]);
  object.errSensorUncalib = reader.readLongOrNull(offsets[11]);
  object.errorBits = reader.readLongOrNull(offsets[12]);
  object.length = reader.readLongOrNull(offsets[13]);
  object.mainCounter = reader.readLongOrNull(offsets[14]);
  object.offsetX = reader.readLongOrNull(offsets[15]);
  object.offsetY = reader.readLongOrNull(offsets[16]);
  object.offsetZ = reader.readLongOrNull(offsets[17]);
  object.opcode = reader.readLongOrNull(offsets[18]);
  object.resetReason = reader.readLongOrNull(offsets[19]);
  object.restartNumber = reader.readLongOrNull(offsets[20]);
  object.scaleRawX = reader.readLongOrNull(offsets[21]);
  object.scaleRawY = reader.readLongOrNull(offsets[22]);
  object.scaleRawZ = reader.readLongOrNull(offsets[23]);
  object.sensorID = reader.readLongOrNull(offsets[24]);
  object.sensorType = reader.readLongOrNull(offsets[25]);
  object.sourceID = reader.readLongOrNull(offsets[26]);
  object.stickCounter = reader.readLongOrNull(offsets[27]);
  object.tempRaw = reader.readLongOrNull(offsets[28]);
  object.tiltRaw = reader.readLongOrNull(offsets[29]);
  object.uptime = reader.readLongOrNull(offsets[30]);
  return object;
}

P _sensorNodeDataEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readLongOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readLongOrNull(offset)) as P;
    case 27:
      return (reader.readLongOrNull(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readLongOrNull(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SensorNodeDataEmbeddedQueryFilter
    on
        QueryBuilder<
          SensorNodeDataEmbedded,
          SensorNodeDataEmbedded,
          QFilterCondition
        > {
  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelX', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelY', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accelZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accelZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accelZ', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accelZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accelZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  accelZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accelZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'adc3V3Raw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'adc3V3Raw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'adc3V3Raw', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'adc3V3Raw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'adc3V3Raw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc3V3RawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'adc3V3Raw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'adc5VRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'adc5VRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'adc5VRaw', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'adc5VRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'adc5VRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  adc5VRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'adc5VRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'boomCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'boomCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'boomCounter', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'boomCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'boomCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  boomCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'boomCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bucketCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bucketCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bucketCounter', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bucketCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bucketCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  bucketCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bucketCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'canRxTimeout'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'canRxTimeout'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'canRxTimeout', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'canRxTimeout',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'canRxTimeout',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  canRxTimeoutBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'canRxTimeout',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'crc16'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'crc16'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'crc16', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16GreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'crc16',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16LessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'crc16',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  crc16Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'crc16',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errCANSendFail'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errCANSendFail'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errCANSendFail', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errCANSendFail',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errCANSendFail',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errCANSendFailBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errCANSendFail',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errSensorRead'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errSensorRead'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errSensorRead', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errSensorRead',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errSensorRead',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorReadBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errSensorRead',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errSensorUncalib'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errSensorUncalib'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errSensorUncalib', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errSensorUncalib',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errSensorUncalib',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errSensorUncalibBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errSensorUncalib',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errorBits'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errorBits'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errorBits', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errorBits',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errorBits',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  errorBitsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errorBits',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'length'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'length'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'length', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'length',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'length',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  lengthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'length',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mainCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mainCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mainCounter', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mainCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mainCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  mainCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mainCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetX', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetY', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'offsetZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'offsetZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'offsetZ', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'offsetZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'offsetZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  offsetZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'offsetZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'opcode'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'opcode'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'opcode', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'opcode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'opcode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  opcodeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'opcode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'resetReason'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'resetReason'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'resetReason', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'resetReason',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'resetReason',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  resetReasonBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'resetReason',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'restartNumber'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'restartNumber'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restartNumber', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restartNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restartNumber',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  restartNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restartNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawX'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawX', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawX',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawXBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawY'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawY', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawY',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawYBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'scaleRawZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'scaleRawZ'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scaleRawZ', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scaleRawZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scaleRawZ',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  scaleRawZBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scaleRawZ',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sensorID'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sensorID'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sensorID', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sensorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sensorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sensorID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sensorType'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sensorType'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sensorType', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sensorType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sensorType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sensorTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sensorType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sourceID'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sourceID'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceID', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  sourceIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stickCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stickCounter'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stickCounter', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stickCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stickCounter',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  stickCounterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stickCounter',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tempRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tempRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tempRaw', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tempRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tempRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tempRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tempRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tiltRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tiltRaw'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tiltRaw', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tiltRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tiltRaw',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  tiltRawBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tiltRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uptime'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uptime'),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uptime', value: value),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uptime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uptime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    SensorNodeDataEmbedded,
    SensorNodeDataEmbedded,
    QAfterFilterCondition
  >
  uptimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uptime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SensorNodeDataEmbeddedQueryObject
    on
        QueryBuilder<
          SensorNodeDataEmbedded,
          SensorNodeDataEmbedded,
          QFilterCondition
        > {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ErrorAlertEmbeddedSchema = Schema(
  name: r'ErrorAlertEmbedded',
  id: -2673803716222695415,
  properties: {
    r'alertType': PropertySchema(
      id: 0,
      name: r'alertType',
      type: IsarType.string,
    ),
    r'message': PropertySchema(id: 1, name: r'message', type: IsarType.string),
    r'sourceID': PropertySchema(
      id: 2,
      name: r'sourceID',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 3,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _errorAlertEmbeddedEstimateSize,
  serialize: _errorAlertEmbeddedSerialize,
  deserialize: _errorAlertEmbeddedDeserialize,
  deserializeProp: _errorAlertEmbeddedDeserializeProp,
);

int _errorAlertEmbeddedEstimateSize(
  ErrorAlertEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.alertType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sourceID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _errorAlertEmbeddedSerialize(
  ErrorAlertEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alertType);
  writer.writeString(offsets[1], object.message);
  writer.writeString(offsets[2], object.sourceID);
  writer.writeDateTime(offsets[3], object.timestamp);
}

ErrorAlertEmbedded _errorAlertEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ErrorAlertEmbedded();
  object.alertType = reader.readStringOrNull(offsets[0]);
  object.message = reader.readStringOrNull(offsets[1]);
  object.sourceID = reader.readStringOrNull(offsets[2]);
  object.timestamp = reader.readDateTimeOrNull(offsets[3]);
  return object;
}

P _errorAlertEmbeddedDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ErrorAlertEmbeddedQueryFilter
    on QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QFilterCondition> {
  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'alertType'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'alertType'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alertType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'alertType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'alertType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alertType', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  alertTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'alertType', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'message'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'message'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'message',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'message',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sourceID'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sourceID'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceID', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  sourceIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceID', value: ''),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timestamp'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timestamp'),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QAfterFilterCondition>
  timestampBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ErrorAlertEmbeddedQueryObject
    on QueryBuilder<ErrorAlertEmbedded, ErrorAlertEmbedded, QFilterCondition> {}
