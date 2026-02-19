// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContractorCollection on Isar {
  IsarCollection<Contractor> get contractors => this.collection();
}

const ContractorSchema = CollectionSchema(
  name: r'Contractor',
  id: 213870700840147031,
  properties: {
    r'area': PropertySchema(id: 0, name: r'area', type: IsarType.string),
    r'lastUpdate': PropertySchema(
      id: 1,
      name: r'lastUpdate',
      type: IsarType.long,
    ),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'numberEquipment': PropertySchema(
      id: 3,
      name: r'numberEquipment',
      type: IsarType.double,
    ),
    r'numberOperator': PropertySchema(
      id: 4,
      name: r'numberOperator',
      type: IsarType.double,
    ),
    r'sector': PropertySchema(id: 5, name: r'sector', type: IsarType.string),
    r'uid': PropertySchema(id: 6, name: r'uid', type: IsarType.string),
  },

  estimateSize: _contractorEstimateSize,
  serialize: _contractorSerialize,
  deserialize: _contractorDeserialize,
  deserializeProp: _contractorDeserializeProp,
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

  getId: _contractorGetId,
  getLinks: _contractorGetLinks,
  attach: _contractorAttach,
  version: '3.3.0-dev.3',
);

int _contractorEstimateSize(
  Contractor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.area;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sector;
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

void _contractorSerialize(
  Contractor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.area);
  writer.writeLong(offsets[1], object.lastUpdate);
  writer.writeString(offsets[2], object.name);
  writer.writeDouble(offsets[3], object.numberEquipment);
  writer.writeDouble(offsets[4], object.numberOperator);
  writer.writeString(offsets[5], object.sector);
  writer.writeString(offsets[6], object.uid);
}

Contractor _contractorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Contractor(
    area: reader.readStringOrNull(offsets[0]),
    lastUpdate: reader.readLongOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]),
    numberEquipment: reader.readDoubleOrNull(offsets[3]),
    numberOperator: reader.readDoubleOrNull(offsets[4]),
    sector: reader.readStringOrNull(offsets[5]),
    uid: reader.readStringOrNull(offsets[6]),
  );
  object.id = id;
  return object;
}

P _contractorDeserializeProp<P>(
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contractorGetId(Contractor object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contractorGetLinks(Contractor object) {
  return [];
}

void _contractorAttach(IsarCollection<dynamic> col, Id id, Contractor object) {
  object.id = id;
}

extension ContractorQueryWhereSort
    on QueryBuilder<Contractor, Contractor, QWhere> {
  QueryBuilder<Contractor, Contractor, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContractorQueryWhere
    on QueryBuilder<Contractor, Contractor, QWhereClause> {
  QueryBuilder<Contractor, Contractor, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> idBetween(
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

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [null]),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> uidIsNotNull() {
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

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> uidEqualTo(
    String? uid,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uid', value: [uid]),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterWhereClause> uidNotEqualTo(
    String? uid,
  ) {
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

extension ContractorQueryFilter
    on QueryBuilder<Contractor, Contractor, QFilterCondition> {
  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'area'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'area'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'area',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'area',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'area',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'area', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> areaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'area', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> lastUpdateEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> lastUpdateBetween(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'name'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'name'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numberEquipment'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numberEquipment'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'numberEquipment',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numberEquipment',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numberEquipment',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberEquipmentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numberEquipment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numberOperator'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numberOperator'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'numberOperator',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numberOperator',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numberOperator',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  numberOperatorBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numberOperator',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sector'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  sectorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sector'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sector',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sector',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sector',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> sectorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sector', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition>
  sectorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sector', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uid'),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidEqualTo(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidGreaterThan(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidLessThan(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidBetween(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidStartsWith(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidEndsWith(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidContains(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidMatches(
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

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uid', value: ''),
      );
    });
  }
}

extension ContractorQueryObject
    on QueryBuilder<Contractor, Contractor, QFilterCondition> {}

extension ContractorQueryLinks
    on QueryBuilder<Contractor, Contractor, QFilterCondition> {}

extension ContractorQuerySortBy
    on QueryBuilder<Contractor, Contractor, QSortBy> {
  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'area', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'area', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByNumberEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberEquipment', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy>
  sortByNumberEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberEquipment', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByNumberOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOperator', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy>
  sortByNumberOperatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOperator', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortBySector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortBySectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension ContractorQuerySortThenBy
    on QueryBuilder<Contractor, Contractor, QSortThenBy> {
  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByArea() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'area', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByAreaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'area', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByNumberEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberEquipment', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy>
  thenByNumberEquipmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberEquipment', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByNumberOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOperator', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy>
  thenByNumberOperatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOperator', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenBySector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenBySectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.desc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Contractor, Contractor, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension ContractorQueryWhereDistinct
    on QueryBuilder<Contractor, Contractor, QDistinct> {
  QueryBuilder<Contractor, Contractor, QDistinct> distinctByArea({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'area', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctByNumberEquipment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberEquipment');
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctByNumberOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberOperator');
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctBySector({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sector', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contractor, Contractor, QDistinct> distinctByUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension ContractorQueryProperty
    on QueryBuilder<Contractor, Contractor, QQueryProperty> {
  QueryBuilder<Contractor, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Contractor, String?, QQueryOperations> areaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'area');
    });
  }

  QueryBuilder<Contractor, int?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<Contractor, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Contractor, double?, QQueryOperations>
  numberEquipmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberEquipment');
    });
  }

  QueryBuilder<Contractor, double?, QQueryOperations> numberOperatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberOperator');
    });
  }

  QueryBuilder<Contractor, String?, QQueryOperations> sectorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sector');
    });
  }

  QueryBuilder<Contractor, String?, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
