// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrower.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBorrowerCollection on Isar {
  IsarCollection<Borrower> get borrowers => this.collection();
}

const BorrowerSchema = CollectionSchema(
  name: r'Borrower',
  id: -7056133101480292584,
  properties: {
    r'contact': PropertySchema(
      id: 0,
      name: r'contact',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'fineDue': PropertySchema(
      id: 2,
      name: r'fineDue',
      type: IsarType.double,
    ),
    r'isDefaulter': PropertySchema(
      id: 3,
      name: r'isDefaulter',
      type: IsarType.bool,
    ),
    r'membershipDuration': PropertySchema(
      id: 4,
      name: r'membershipDuration',
      type: IsarType.long,
    ),
    r'membershipStartDate': PropertySchema(
      id: 5,
      name: r'membershipStartDate',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'profilePicture': PropertySchema(
      id: 7,
      name: r'profilePicture',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _borrowerEstimateSize,
  serialize: _borrowerSerialize,
  deserialize: _borrowerDeserialize,
  deserializeProp: _borrowerDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'membershipStartDate': IndexSchema(
      id: -8228581695139532011,
      name: r'membershipStartDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'membershipStartDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'currentlyIssuedBooks': LinkSchema(
      id: -1123658905267344679,
      name: r'currentlyIssuedBooks',
      target: r'BookCopy',
      single: false,
      linkName: r'currentBorrower',
    ),
    r'previouslyIssuedBooks': LinkSchema(
      id: -5548564570885221112,
      name: r'previouslyIssuedBooks',
      target: r'BookCopy',
      single: false,
      linkName: r'previousBorrowers',
    )
  },
  embeddedSchemas: {},
  getId: _borrowerGetId,
  getLinks: _borrowerGetLinks,
  attach: _borrowerAttach,
  version: '3.1.0+1',
);

int _borrowerEstimateSize(
  Borrower object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contact.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.profilePicture.length * 3;
  return bytesCount;
}

void _borrowerSerialize(
  Borrower object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contact);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDouble(offsets[2], object.fineDue);
  writer.writeBool(offsets[3], object.isDefaulter);
  writer.writeLong(offsets[4], object.membershipDuration);
  writer.writeDateTime(offsets[5], object.membershipStartDate);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.profilePicture);
  writer.writeDateTime(offsets[8], object.updatedAt);
}

Borrower _borrowerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Borrower(
    contact: reader.readString(offsets[0]),
    membershipDuration: reader.readLong(offsets[4]),
    membershipStartDate: reader.readDateTime(offsets[5]),
    name: reader.readString(offsets[6]),
    profilePicture: reader.readStringOrNull(offsets[7]) ?? '',
  );
  object.createdAt = reader.readDateTime(offsets[1]);
  object.fineDue = reader.readDouble(offsets[2]);
  object.id = id;
  object.isDefaulter = reader.readBool(offsets[3]);
  object.updatedAt = reader.readDateTime(offsets[8]);
  return object;
}

P _borrowerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _borrowerGetId(Borrower object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _borrowerGetLinks(Borrower object) {
  return [object.currentlyIssuedBooks, object.previouslyIssuedBooks];
}

void _borrowerAttach(IsarCollection<dynamic> col, Id id, Borrower object) {
  object.id = id;
  object.currentlyIssuedBooks.attach(
      col, col.isar.collection<BookCopy>(), r'currentlyIssuedBooks', id);
  object.previouslyIssuedBooks.attach(
      col, col.isar.collection<BookCopy>(), r'previouslyIssuedBooks', id);
}

extension BorrowerQueryWhereSort on QueryBuilder<Borrower, Borrower, QWhere> {
  QueryBuilder<Borrower, Borrower, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhere> anyMembershipStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'membershipStartDate'),
      );
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension BorrowerQueryWhere on QueryBuilder<Borrower, Borrower, QWhereClause> {
  QueryBuilder<Borrower, Borrower, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause>
      membershipStartDateEqualTo(DateTime membershipStartDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'membershipStartDate',
        value: [membershipStartDate],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause>
      membershipStartDateNotEqualTo(DateTime membershipStartDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'membershipStartDate',
              lower: [],
              upper: [membershipStartDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'membershipStartDate',
              lower: [membershipStartDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'membershipStartDate',
              lower: [membershipStartDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'membershipStartDate',
              lower: [],
              upper: [membershipStartDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause>
      membershipStartDateGreaterThan(
    DateTime membershipStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'membershipStartDate',
        lower: [membershipStartDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause>
      membershipStartDateLessThan(
    DateTime membershipStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'membershipStartDate',
        lower: [],
        upper: [membershipStartDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause>
      membershipStartDateBetween(
    DateTime lowerMembershipStartDate,
    DateTime upperMembershipStartDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'membershipStartDate',
        lower: [lowerMembershipStartDate],
        includeLower: includeLower,
        upper: [upperMembershipStartDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> updatedAtEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> updatedAtNotEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> updatedAtGreaterThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> updatedAtLessThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterWhereClause> updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BorrowerQueryFilter
    on QueryBuilder<Borrower, Borrower, QFilterCondition> {
  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contact',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contact',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contact',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> contactIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contact',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> fineDueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fineDue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> fineDueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fineDue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> fineDueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fineDue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> fineDueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fineDue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> isDefaulterEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefaulter',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'membershipDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'membershipDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'membershipDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'membershipDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipStartDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'membershipStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipStartDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'membershipStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipStartDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'membershipStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      membershipStartDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'membershipStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> profilePictureEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> profilePictureBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profilePicture',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profilePicture',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> profilePictureMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profilePicture',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profilePicture',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      profilePictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profilePicture',
        value: '',
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BorrowerQueryObject
    on QueryBuilder<Borrower, Borrower, QFilterCondition> {}

extension BorrowerQueryLinks
    on QueryBuilder<Borrower, Borrower, QFilterCondition> {
  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> currentlyIssuedBooks(
      FilterQuery<BookCopy> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'currentlyIssuedBooks');
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'currentlyIssuedBooks', length, true, length, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'currentlyIssuedBooks', 0, true, 0, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'currentlyIssuedBooks', 0, false, 999999, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'currentlyIssuedBooks', 0, true, length, include);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'currentlyIssuedBooks', length, include, 999999, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      currentlyIssuedBooksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'currentlyIssuedBooks', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition> previouslyIssuedBooks(
      FilterQuery<BookCopy> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'previouslyIssuedBooks');
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previouslyIssuedBooks', length, true, length, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previouslyIssuedBooks', 0, true, 0, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previouslyIssuedBooks', 0, false, 999999, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previouslyIssuedBooks', 0, true, length, include);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previouslyIssuedBooks', length, include, 999999, true);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      previouslyIssuedBooksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previouslyIssuedBooks', lower, includeLower, upper, includeUpper);
    });
  }
}

extension BorrowerQuerySortBy on QueryBuilder<Borrower, Borrower, QSortBy> {
  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByFineDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fineDue', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByFineDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fineDue', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByIsDefaulter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefaulter', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByIsDefaulterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefaulter', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByMembershipDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipDuration', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy>
      sortByMembershipDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipDuration', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByMembershipStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipStartDate', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy>
      sortByMembershipStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipStartDate', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByProfilePicture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicture', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByProfilePictureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicture', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BorrowerQuerySortThenBy
    on QueryBuilder<Borrower, Borrower, QSortThenBy> {
  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByFineDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fineDue', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByFineDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fineDue', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByIsDefaulter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefaulter', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByIsDefaulterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefaulter', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByMembershipDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipDuration', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy>
      thenByMembershipDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipDuration', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByMembershipStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipStartDate', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy>
      thenByMembershipStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'membershipStartDate', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByProfilePicture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicture', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByProfilePictureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profilePicture', Sort.desc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Borrower, Borrower, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BorrowerQueryWhereDistinct
    on QueryBuilder<Borrower, Borrower, QDistinct> {
  QueryBuilder<Borrower, Borrower, QDistinct> distinctByContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contact', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByFineDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fineDue');
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByIsDefaulter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefaulter');
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByMembershipDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'membershipDuration');
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByMembershipStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'membershipStartDate');
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByProfilePicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profilePicture',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Borrower, Borrower, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension BorrowerQueryProperty
    on QueryBuilder<Borrower, Borrower, QQueryProperty> {
  QueryBuilder<Borrower, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Borrower, String, QQueryOperations> contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contact');
    });
  }

  QueryBuilder<Borrower, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Borrower, double, QQueryOperations> fineDueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fineDue');
    });
  }

  QueryBuilder<Borrower, bool, QQueryOperations> isDefaulterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefaulter');
    });
  }

  QueryBuilder<Borrower, int, QQueryOperations> membershipDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'membershipDuration');
    });
  }

  QueryBuilder<Borrower, DateTime, QQueryOperations>
      membershipStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'membershipStartDate');
    });
  }

  QueryBuilder<Borrower, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Borrower, String, QQueryOperations> profilePictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profilePicture');
    });
  }

  QueryBuilder<Borrower, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
