// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_spot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkingSpotCollection on Isar {
  IsarCollection<WorkingSpot> get workingSpots => this.collection();
}

const WorkingSpotSchema = CollectionSchema(
  name: r'WorkingSpot',
  id: 1860143993511687980,
  properties: {
    r'akurasi': PropertySchema(id: 0, name: r'akurasi', type: IsarType.double),
    r'alt': PropertySchema(id: 1, name: r'alt', type: IsarType.long),
    r'deep': PropertySchema(id: 2, name: r'deep', type: IsarType.long),
    r'driverID': PropertySchema(
      id: 3,
      name: r'driverID',
      type: IsarType.string,
    ),
    r'fileID': PropertySchema(id: 4, name: r'fileID', type: IsarType.string),
    r'lastUpdate': PropertySchema(
      id: 5,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'lat': PropertySchema(id: 6, name: r'lat', type: IsarType.double),
    r'lng': PropertySchema(id: 7, name: r'lng', type: IsarType.double),
    r'spotID': PropertySchema(id: 8, name: r'spotID', type: IsarType.long),
    r'status': PropertySchema(id: 9, name: r'status', type: IsarType.long),
    r'totalTime': PropertySchema(
      id: 10,
      name: r'totalTime',
      type: IsarType.long,
    ),
  },

  estimateSize: _workingSpotEstimateSize,
  serialize: _workingSpotSerialize,
  deserialize: _workingSpotDeserialize,
  deserializeProp: _workingSpotDeserializeProp,
  idName: r'id',
  indexes: {
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
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
    r'fileID': IndexSchema(
      id: -7557815517999649950,
      name: r'fileID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fileID',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'spotID': IndexSchema(
      id: 1353039584022161409,
      name: r'spotID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'spotID',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _workingSpotGetId,
  getLinks: _workingSpotGetLinks,
  attach: _workingSpotAttach,
  version: '3.3.0-dev.3',
);

int _workingSpotEstimateSize(
  WorkingSpot object,
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
    final value = object.fileID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _workingSpotSerialize(
  WorkingSpot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.akurasi);
  writer.writeLong(offsets[1], object.alt);
  writer.writeLong(offsets[2], object.deep);
  writer.writeString(offsets[3], object.driverID);
  writer.writeString(offsets[4], object.fileID);
  writer.writeLong(offsets[5], object.lastUpdate);
  writer.writeDouble(offsets[6], object.lat);
  writer.writeDouble(offsets[7], object.lng);
  writer.writeLong(offsets[8], object.spotID);
  writer.writeLong(offsets[9], object.status);
  writer.writeLong(offsets[10], object.totalTime);
}

WorkingSpot _workingSpotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkingSpot(
    akurasi: reader.readDoubleOrNull(offsets[0]),
    alt: reader.readLongOrNull(offsets[1]),
    deep: reader.readLongOrNull(offsets[2]),
    driverID: reader.readStringOrNull(offsets[3]),
    fileID: reader.readStringOrNull(offsets[4]),
    lastUpdate: reader.readLongOrNull(offsets[5]),
    lat: reader.readDoubleOrNull(offsets[6]),
    lng: reader.readDoubleOrNull(offsets[7]),
    spotID: reader.readLongOrNull(offsets[8]),
    status: reader.readLongOrNull(offsets[9]),
    totalTime: reader.readLongOrNull(offsets[10]),
  );
  object.id = id;
  return object;
}

P _workingSpotDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workingSpotGetId(WorkingSpot object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workingSpotGetLinks(WorkingSpot object) {
  return [];
}

void _workingSpotAttach(
  IsarCollection<dynamic> col,
  Id id,
  WorkingSpot object,
) {
  object.id = id;
}

extension WorkingSpotQueryWhereSort
    on QueryBuilder<WorkingSpot, WorkingSpot, QWhere> {
  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhere> anyStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'status'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhere> anySpotID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'spotID'),
      );
    });
  }
}

extension WorkingSpotQueryWhere
    on QueryBuilder<WorkingSpot, WorkingSpot, QWhereClause> {
  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> idBetween(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [null]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusIsNotNull() {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusEqualTo(
    int? status,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [status]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusNotEqualTo(
    int? status,
  ) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusGreaterThan(
    int? status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'status',
          lower: [status],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusLessThan(
    int? status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'status',
          lower: [],
          upper: [status],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> statusBetween(
    int? lowerStatus,
    int? upperStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'status',
          lower: [lowerStatus],
          includeLower: includeLower,
          upper: [upperStatus],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> driverIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'driverID', value: [null]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> driverIDEqualTo(
    String? driverID,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'driverID', value: [driverID]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> driverIDNotEqualTo(
    String? driverID,
  ) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> fileIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fileID', value: [null]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> fileIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'fileID',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> fileIDEqualTo(
    String? fileID,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'fileID', value: [fileID]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> fileIDNotEqualTo(
    String? fileID,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fileID',
                lower: [],
                upper: [fileID],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fileID',
                lower: [fileID],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fileID',
                lower: [fileID],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'fileID',
                lower: [],
                upper: [fileID],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'spotID', value: [null]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'spotID',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDEqualTo(
    int? spotID,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'spotID', value: [spotID]),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDNotEqualTo(
    int? spotID,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'spotID',
                lower: [],
                upper: [spotID],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'spotID',
                lower: [spotID],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'spotID',
                lower: [spotID],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'spotID',
                lower: [],
                upper: [spotID],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDGreaterThan(
    int? spotID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'spotID',
          lower: [spotID],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDLessThan(
    int? spotID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'spotID',
          lower: [],
          upper: [spotID],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterWhereClause> spotIDBetween(
    int? lowerSpotID,
    int? upperSpotID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'spotID',
          lower: [lowerSpotID],
          includeLower: includeLower,
          upper: [upperSpotID],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkingSpotQueryFilter
    on QueryBuilder<WorkingSpot, WorkingSpot, QFilterCondition> {
  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  akurasiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'akurasi'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  akurasiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'akurasi'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> akurasiEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'akurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  akurasiGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'akurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> akurasiLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'akurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> akurasiBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'akurasi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'alt'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'alt'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'alt', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'alt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'alt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> altBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'alt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> deepIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'deep'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  deepIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'deep'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> deepEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'deep', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> deepGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'deep',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> deepLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'deep',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> deepBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'deep',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  driverIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'driverID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  driverIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'driverID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> driverIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> driverIDBetween(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> driverIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  driverIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'driverID', value: ''),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  driverIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'driverID', value: ''),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fileID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  fileIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fileID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  fileIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fileID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  fileIDStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fileID',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> fileIDMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fileID',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  fileIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fileID', value: ''),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  fileIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fileID', value: ''),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  lastUpdateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  lastUpdateLessThan(int? value, {bool include = false}) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  lastUpdateBetween(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latGreaterThan(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latLessThan(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> latBetween(
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lng'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lng'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> lngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> spotIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spotID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  spotIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spotID'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> spotIDEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spotID', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  spotIDGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spotID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> spotIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spotID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> spotIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spotID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> statusEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  statusGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> statusLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition> statusBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'totalTime'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'totalTime'),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalTime', value: value),
      );
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeGreaterThan(int? value, {bool include = false}) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeLessThan(int? value, {bool include = false}) {
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

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterFilterCondition>
  totalTimeBetween(
    int? lower,
    int? upper, {
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
}

extension WorkingSpotQueryObject
    on QueryBuilder<WorkingSpot, WorkingSpot, QFilterCondition> {}

extension WorkingSpotQueryLinks
    on QueryBuilder<WorkingSpot, WorkingSpot, QFilterCondition> {}

extension WorkingSpotQuerySortBy
    on QueryBuilder<WorkingSpot, WorkingSpot, QSortBy> {
  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'akurasi', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByAkurasiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'akurasi', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByAltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deep', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deep', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByDriverID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByDriverIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByFileID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByFileIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lng', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lng', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortBySpotID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortBySpotIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> sortByTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.desc);
    });
  }
}

extension WorkingSpotQuerySortThenBy
    on QueryBuilder<WorkingSpot, WorkingSpot, QSortThenBy> {
  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'akurasi', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByAkurasiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'akurasi', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByAltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alt', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deep', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByDeepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deep', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByDriverID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByDriverIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByFileID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByFileIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lat', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lng', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lng', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenBySpotID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotID', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenBySpotIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotID', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.asc);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QAfterSortBy> thenByTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTime', Sort.desc);
    });
  }
}

extension WorkingSpotQueryWhereDistinct
    on QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> {
  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'akurasi');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByAlt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alt');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByDeep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deep');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByDriverID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByFileID({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lat');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lng');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctBySpotID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spotID');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<WorkingSpot, WorkingSpot, QDistinct> distinctByTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTime');
    });
  }
}

extension WorkingSpotQueryProperty
    on QueryBuilder<WorkingSpot, WorkingSpot, QQueryProperty> {
  QueryBuilder<WorkingSpot, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkingSpot, double?, QQueryOperations> akurasiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'akurasi');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> altProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alt');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> deepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deep');
    });
  }

  QueryBuilder<WorkingSpot, String?, QQueryOperations> driverIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverID');
    });
  }

  QueryBuilder<WorkingSpot, String?, QQueryOperations> fileIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileID');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<WorkingSpot, double?, QQueryOperations> latProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lat');
    });
  }

  QueryBuilder<WorkingSpot, double?, QQueryOperations> lngProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lng');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> spotIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spotID');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<WorkingSpot, int?, QQueryOperations> totalTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTime');
    });
  }
}
