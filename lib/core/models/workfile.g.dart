// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workfile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkFileCollection on Isar {
  IsarCollection<WorkFile> get workFiles => this.collection();
}

const WorkFileSchema = CollectionSchema(
  name: r'WorkFile',
  id: -8184710040028081999,
  properties: {
    r'areaID': PropertySchema(id: 0, name: r'areaID', type: IsarType.long),
    r'areaName': PropertySchema(
      id: 1,
      name: r'areaName',
      type: IsarType.string,
    ),
    r'contractor': PropertySchema(
      id: 2,
      name: r'contractor',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(id: 3, name: r'createAt', type: IsarType.long),
    r'doneAt': PropertySchema(id: 4, name: r'doneAt', type: IsarType.long),
    r'equipment': PropertySchema(
      id: 5,
      name: r'equipment',
      type: IsarType.string,
    ),
    r'equipmentID': PropertySchema(
      id: 6,
      name: r'equipmentID',
      type: IsarType.long,
    ),
    r'lastUpdate': PropertySchema(
      id: 7,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'lebar': PropertySchema(id: 8, name: r'lebar', type: IsarType.double),
    r'luasArea': PropertySchema(
      id: 9,
      name: r'luasArea',
      type: IsarType.double,
    ),
    r'operatorID': PropertySchema(
      id: 10,
      name: r'operatorID',
      type: IsarType.long,
    ),
    r'panjang': PropertySchema(id: 11, name: r'panjang', type: IsarType.double),
    r'spotDone': PropertySchema(id: 12, name: r'spotDone', type: IsarType.long),
    r'status': PropertySchema(id: 13, name: r'status', type: IsarType.string),
    r'totalSpot': PropertySchema(
      id: 14,
      name: r'totalSpot',
      type: IsarType.long,
    ),
    r'uid': PropertySchema(id: 15, name: r'uid', type: IsarType.long),
  },

  estimateSize: _workFileEstimateSize,
  serialize: _workFileSerialize,
  deserialize: _workFileDeserialize,
  deserializeProp: _workFileDeserializeProp,
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
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _workFileGetId,
  getLinks: _workFileGetLinks,
  attach: _workFileAttach,
  version: '3.3.0-dev.3',
);

int _workFileEstimateSize(
  WorkFile object,
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
    final value = object.contractor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.equipment;
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

void _workFileSerialize(
  WorkFile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.areaID);
  writer.writeString(offsets[1], object.areaName);
  writer.writeString(offsets[2], object.contractor);
  writer.writeLong(offsets[3], object.createAt);
  writer.writeLong(offsets[4], object.doneAt);
  writer.writeString(offsets[5], object.equipment);
  writer.writeLong(offsets[6], object.equipmentID);
  writer.writeLong(offsets[7], object.lastUpdate);
  writer.writeDouble(offsets[8], object.lebar);
  writer.writeDouble(offsets[9], object.luasArea);
  writer.writeLong(offsets[10], object.operatorID);
  writer.writeDouble(offsets[11], object.panjang);
  writer.writeLong(offsets[12], object.spotDone);
  writer.writeString(offsets[13], object.status);
  writer.writeLong(offsets[14], object.totalSpot);
  writer.writeLong(offsets[15], object.uid);
}

WorkFile _workFileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkFile(
    areaID: reader.readLongOrNull(offsets[0]),
    areaName: reader.readStringOrNull(offsets[1]),
    contractor: reader.readStringOrNull(offsets[2]),
    createAt: reader.readLongOrNull(offsets[3]),
    doneAt: reader.readLongOrNull(offsets[4]),
    equipment: reader.readStringOrNull(offsets[5]),
    equipmentID: reader.readLongOrNull(offsets[6]),
    lastUpdate: reader.readLongOrNull(offsets[7]),
    lebar: reader.readDoubleOrNull(offsets[8]),
    luasArea: reader.readDoubleOrNull(offsets[9]),
    operatorID: reader.readLongOrNull(offsets[10]),
    panjang: reader.readDoubleOrNull(offsets[11]),
    spotDone: reader.readLongOrNull(offsets[12]),
    status: reader.readStringOrNull(offsets[13]),
    totalSpot: reader.readLongOrNull(offsets[14]),
    uid: reader.readLongOrNull(offsets[15]),
  );
  object.id = id;
  return object;
}

P _workFileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
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
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workFileGetId(WorkFile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workFileGetLinks(WorkFile object) {
  return [];
}

void _workFileAttach(IsarCollection<dynamic> col, Id id, WorkFile object) {
  object.id = id;
}

extension WorkFileQueryWhereSort on QueryBuilder<WorkFile, WorkFile, QWhere> {
  QueryBuilder<WorkFile, WorkFile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkFileQueryWhere on QueryBuilder<WorkFile, WorkFile, QWhereClause> {
  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> idBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [null]),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> statusIsNotNull() {
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

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> statusEqualTo(
    String? status,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'status', value: [status]),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterWhereClause> statusNotEqualTo(
    String? status,
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
}

extension WorkFileQueryFilter
    on QueryBuilder<WorkFile, WorkFile, QFilterCondition> {
  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'areaID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'areaID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'areaID', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'areaID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'areaID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'areaID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'areaName'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'areaName'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameEqualTo(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameGreaterThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameLessThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameStartsWith(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameEndsWith(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameContains(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameMatches(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'areaName', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> areaNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'areaName', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'contractor'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  contractorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'contractor'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'contractor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'contractor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'contractor',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> contractorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'contractor', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  contractorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'contractor', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createAt'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createAt'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createAt', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> createAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'doneAt'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'doneAt'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'doneAt', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'doneAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'doneAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> doneAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'doneAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'equipment'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'equipment'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'equipment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'equipment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'equipment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'equipment', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  equipmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'equipment', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'equipmentID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  equipmentIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'equipmentID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIDEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'equipmentID', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  equipmentIDGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'equipmentID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'equipmentID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> equipmentIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'equipmentID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lastUpdateEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lastUpdateGreaterThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lastUpdateLessThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lastUpdateBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lebar'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lebar'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lebar',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lebar',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lebar',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> lebarBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lebar',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'luasArea'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'luasArea'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaEqualTo(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaGreaterThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaLessThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> luasAreaBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> operatorIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'operatorID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition>
  operatorIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'operatorID'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> operatorIDEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'operatorID', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> operatorIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'operatorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> operatorIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'operatorID',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> operatorIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'operatorID',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'panjang'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'panjang'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'panjang',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'panjang',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'panjang',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> panjangBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'panjang',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'spotDone'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'spotDone'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'spotDone', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'spotDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'spotDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> spotDoneBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'spotDone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'status'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'status'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusGreaterThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusLessThan(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusContains(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'totalSpot'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'totalSpot'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalSpot', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotGreaterThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotLessThan(
    int? value, {
    bool include = false,
  }) {
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> totalSpotBetween(
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

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: value),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uid',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uid',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterFilterCondition> uidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkFileQueryObject
    on QueryBuilder<WorkFile, WorkFile, QFilterCondition> {}

extension WorkFileQueryLinks
    on QueryBuilder<WorkFile, WorkFile, QFilterCondition> {}

extension WorkFileQuerySortBy on QueryBuilder<WorkFile, WorkFile, QSortBy> {
  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByAreaID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByAreaIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByAreaName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByAreaNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByContractor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractor', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByContractorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractor', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByDoneAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doneAt', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByDoneAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doneAt', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByEquipmentID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByEquipmentIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLebar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lebar', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLebarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lebar', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByLuasAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByOperatorID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByOperatorIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByPanjang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panjang', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByPanjangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panjang', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortBySpotDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotDone', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortBySpotDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotDone', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByTotalSpotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension WorkFileQuerySortThenBy
    on QueryBuilder<WorkFile, WorkFile, QSortThenBy> {
  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByAreaID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByAreaIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByAreaName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByAreaNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'areaName', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByContractor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractor', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByContractorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractor', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByDoneAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doneAt', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByDoneAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doneAt', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipment', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByEquipmentID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByEquipmentIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLebar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lebar', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLebarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lebar', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByLuasAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'luasArea', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByOperatorID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorID', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByOperatorIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorID', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByPanjang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panjang', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByPanjangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panjang', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenBySpotDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotDone', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenBySpotDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spotDone', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByTotalSpotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpot', Sort.desc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension WorkFileQueryWhereDistinct
    on QueryBuilder<WorkFile, WorkFile, QDistinct> {
  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByAreaID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaID');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByAreaName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'areaName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByContractor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contractor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByDoneAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doneAt');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByEquipment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByEquipmentID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipmentID');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByLebar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lebar');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByLuasArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'luasArea');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByOperatorID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operatorID');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByPanjang() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'panjang');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctBySpotDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spotDone');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByTotalSpot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpot');
    });
  }

  QueryBuilder<WorkFile, WorkFile, QDistinct> distinctByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid');
    });
  }
}

extension WorkFileQueryProperty
    on QueryBuilder<WorkFile, WorkFile, QQueryProperty> {
  QueryBuilder<WorkFile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> areaIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaID');
    });
  }

  QueryBuilder<WorkFile, String?, QQueryOperations> areaNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'areaName');
    });
  }

  QueryBuilder<WorkFile, String?, QQueryOperations> contractorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractor');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> doneAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doneAt');
    });
  }

  QueryBuilder<WorkFile, String?, QQueryOperations> equipmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipment');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> equipmentIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipmentID');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<WorkFile, double?, QQueryOperations> lebarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lebar');
    });
  }

  QueryBuilder<WorkFile, double?, QQueryOperations> luasAreaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'luasArea');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> operatorIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operatorID');
    });
  }

  QueryBuilder<WorkFile, double?, QQueryOperations> panjangProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'panjang');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> spotDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spotDone');
    });
  }

  QueryBuilder<WorkFile, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> totalSpotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpot');
    });
  }

  QueryBuilder<WorkFile, int?, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
