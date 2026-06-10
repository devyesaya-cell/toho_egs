// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivationCollection on Isar {
  IsarCollection<Activation> get activations => this.collection();
}

const ActivationSchema = CollectionSchema(
  name: r'Activation',
  id: -7684604371779148580,
  properties: {
    r'equipmentId': PropertySchema(
      id: 0,
      name: r'equipmentId',
      type: IsarType.string,
    ),
    r'lastUpdate': PropertySchema(
      id: 1,
      name: r'lastUpdate',
      type: IsarType.dateTime,
    ),
    r'macAddress': PropertySchema(
      id: 2,
      name: r'macAddress',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 3, name: r'status', type: IsarType.bool),
    r'token': PropertySchema(id: 4, name: r'token', type: IsarType.string),
  },

  estimateSize: _activationEstimateSize,
  serialize: _activationSerialize,
  deserialize: _activationDeserialize,
  deserializeProp: _activationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _activationGetId,
  getLinks: _activationGetLinks,
  attach: _activationAttach,
  version: '3.3.0-dev.3',
);

int _activationEstimateSize(
  Activation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.equipmentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.macAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _activationSerialize(
  Activation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.equipmentId);
  writer.writeDateTime(offsets[1], object.lastUpdate);
  writer.writeString(offsets[2], object.macAddress);
  writer.writeBool(offsets[3], object.status);
  writer.writeString(offsets[4], object.token);
}

Activation _activationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Activation(
    equipmentId: reader.readStringOrNull(offsets[0]),
    lastUpdate: reader.readDateTimeOrNull(offsets[1]),
    macAddress: reader.readStringOrNull(offsets[2]),
    status: reader.readBoolOrNull(offsets[3]) ?? false,
    token: reader.readStringOrNull(offsets[4]),
  );
  object.id = id;
  return object;
}

P _activationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activationGetId(Activation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activationGetLinks(Activation object) {
  return [];
}

void _activationAttach(IsarCollection<dynamic> col, Id id, Activation object) {
  object.id = id;
}

extension ActivationQueryWhereSort
    on QueryBuilder<Activation, Activation, QWhere> {
  QueryBuilder<Activation, Activation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActivationQueryWhere
    on QueryBuilder<Activation, Activation, QWhereClause> {
  QueryBuilder<Activation, Activation, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Activation, Activation, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Activation, Activation, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterWhereClause> idBetween(
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

extension ActivationQueryFilter
    on QueryBuilder<Activation, Activation, QFilterCondition> {
  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'equipmentId'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'equipmentId'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'equipmentId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'equipmentId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'equipmentId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'equipmentId', value: ''),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  equipmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'equipmentId', value: ''),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  lastUpdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  lastUpdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdate'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> lastUpdateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdate', value: value),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  lastUpdateGreaterThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  lastUpdateLessThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition> lastUpdateBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'macAddress'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'macAddress'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> macAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> macAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'macAddress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'macAddress',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> macAddressMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'macAddress',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'macAddress', value: ''),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  macAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'macAddress', value: ''),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> statusEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'token'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'token'),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'token',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'token',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'token',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition> tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'token', value: ''),
      );
    });
  }

  QueryBuilder<Activation, Activation, QAfterFilterCondition>
  tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'token', value: ''),
      );
    });
  }
}

extension ActivationQueryObject
    on QueryBuilder<Activation, Activation, QFilterCondition> {}

extension ActivationQueryLinks
    on QueryBuilder<Activation, Activation, QFilterCondition> {}

extension ActivationQuerySortBy
    on QueryBuilder<Activation, Activation, QSortBy> {
  QueryBuilder<Activation, Activation, QAfterSortBy> sortByEquipmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByEquipmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }
}

extension ActivationQuerySortThenBy
    on QueryBuilder<Activation, Activation, QSortThenBy> {
  QueryBuilder<Activation, Activation, QAfterSortBy> thenByEquipmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByEquipmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByLastUpdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdate', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<Activation, Activation, QAfterSortBy> thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }
}

extension ActivationQueryWhereDistinct
    on QueryBuilder<Activation, Activation, QDistinct> {
  QueryBuilder<Activation, Activation, QDistinct> distinctByEquipmentId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Activation, Activation, QDistinct> distinctByLastUpdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdate');
    });
  }

  QueryBuilder<Activation, Activation, QDistinct> distinctByMacAddress({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'macAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Activation, Activation, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<Activation, Activation, QDistinct> distinctByToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }
}

extension ActivationQueryProperty
    on QueryBuilder<Activation, Activation, QQueryProperty> {
  QueryBuilder<Activation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Activation, String?, QQueryOperations> equipmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipmentId');
    });
  }

  QueryBuilder<Activation, DateTime?, QQueryOperations> lastUpdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdate');
    });
  }

  QueryBuilder<Activation, String?, QQueryOperations> macAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'macAddress');
    });
  }

  QueryBuilder<Activation, bool, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Activation, String?, QQueryOperations> tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }
}
