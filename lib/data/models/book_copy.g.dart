// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_copy.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookCopyCollection on Isar {
  IsarCollection<BookCopy> get bookCopys => this.collection();
}

const BookCopySchema = CollectionSchema(
  name: r'BookCopy',
  id: 8283972270635216794,
  properties: {
    r'issueDate': PropertySchema(
      id: 0,
      name: r'issueDate',
      type: IsarType.dateTime,
    ),
    r'returnDate': PropertySchema(
      id: 1,
      name: r'returnDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 2,
      name: r'status',
      type: IsarType.byte,
      enumMap: _BookCopystatusEnumValueMap,
    )
  },
  estimateSize: _bookCopyEstimateSize,
  serialize: _bookCopySerialize,
  deserialize: _bookCopyDeserialize,
  deserializeProp: _bookCopyDeserializeProp,
  idName: r'id',
  indexes: {
    r'issueDate': IndexSchema(
      id: 6801322855743028057,
      name: r'issueDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'issueDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'returnDate': IndexSchema(
      id: 9180662992756784512,
      name: r'returnDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'returnDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'book': LinkSchema(
      id: 1590639761893777908,
      name: r'book',
      target: r'Book',
      single: true,
    ),
    r'currentBorrower': LinkSchema(
      id: -6470996825747126961,
      name: r'currentBorrower',
      target: r'Borrower',
      single: true,
    ),
    r'previousBorrowers': LinkSchema(
      id: -8917799924808716902,
      name: r'previousBorrowers',
      target: r'Borrower',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _bookCopyGetId,
  getLinks: _bookCopyGetLinks,
  attach: _bookCopyAttach,
  version: '3.1.0+1',
);

int _bookCopyEstimateSize(
  BookCopy object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _bookCopySerialize(
  BookCopy object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.issueDate);
  writer.writeDateTime(offsets[1], object.returnDate);
  writer.writeByte(offsets[2], object.status.index);
}

BookCopy _bookCopyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookCopy();
  object.id = id;
  object.issueDate = reader.readDateTimeOrNull(offsets[0]);
  object.returnDate = reader.readDateTimeOrNull(offsets[1]);
  object.status =
      _BookCopystatusValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          IssueStatus.issued;
  return object;
}

P _bookCopyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (_BookCopystatusValueEnumMap[reader.readByteOrNull(offset)] ??
          IssueStatus.issued) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BookCopystatusEnumValueMap = {
  'issued': 0,
  'available': 1,
};
const _BookCopystatusValueEnumMap = {
  0: IssueStatus.issued,
  1: IssueStatus.available,
};

Id _bookCopyGetId(BookCopy object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookCopyGetLinks(BookCopy object) {
  return [object.book, object.currentBorrower, object.previousBorrowers];
}

void _bookCopyAttach(IsarCollection<dynamic> col, Id id, BookCopy object) {
  object.id = id;
  object.book.attach(col, col.isar.collection<Book>(), r'book', id);
  object.currentBorrower
      .attach(col, col.isar.collection<Borrower>(), r'currentBorrower', id);
  object.previousBorrowers
      .attach(col, col.isar.collection<Borrower>(), r'previousBorrowers', id);
}

extension BookCopyQueryWhereSort on QueryBuilder<BookCopy, BookCopy, QWhere> {
  QueryBuilder<BookCopy, BookCopy, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhere> anyIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'issueDate'),
      );
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhere> anyReturnDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'returnDate'),
      );
    });
  }
}

extension BookCopyQueryWhere on QueryBuilder<BookCopy, BookCopy, QWhereClause> {
  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> idBetween(
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

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'issueDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'issueDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateEqualTo(
      DateTime? issueDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'issueDate',
        value: [issueDate],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateNotEqualTo(
      DateTime? issueDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'issueDate',
              lower: [],
              upper: [issueDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'issueDate',
              lower: [issueDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'issueDate',
              lower: [issueDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'issueDate',
              lower: [],
              upper: [issueDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateGreaterThan(
    DateTime? issueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'issueDate',
        lower: [issueDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateLessThan(
    DateTime? issueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'issueDate',
        lower: [],
        upper: [issueDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> issueDateBetween(
    DateTime? lowerIssueDate,
    DateTime? upperIssueDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'issueDate',
        lower: [lowerIssueDate],
        includeLower: includeLower,
        upper: [upperIssueDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'returnDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'returnDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateEqualTo(
      DateTime? returnDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'returnDate',
        value: [returnDate],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateNotEqualTo(
      DateTime? returnDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'returnDate',
              lower: [],
              upper: [returnDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'returnDate',
              lower: [returnDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'returnDate',
              lower: [returnDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'returnDate',
              lower: [],
              upper: [returnDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateGreaterThan(
    DateTime? returnDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'returnDate',
        lower: [returnDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateLessThan(
    DateTime? returnDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'returnDate',
        lower: [],
        upper: [returnDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterWhereClause> returnDateBetween(
    DateTime? lowerReturnDate,
    DateTime? upperReturnDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'returnDate',
        lower: [lowerReturnDate],
        includeLower: includeLower,
        upper: [upperReturnDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookCopyQueryFilter
    on QueryBuilder<BookCopy, BookCopy, QFilterCondition> {
  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'issueDate',
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'issueDate',
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> issueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'issueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> returnDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'returnDate',
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      returnDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'returnDate',
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> returnDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'returnDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> returnDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'returnDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> returnDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'returnDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> returnDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'returnDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> statusEqualTo(
      IssueStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> statusGreaterThan(
    IssueStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> statusLessThan(
    IssueStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> statusBetween(
    IssueStatus lower,
    IssueStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookCopyQueryObject
    on QueryBuilder<BookCopy, BookCopy, QFilterCondition> {}

extension BookCopyQueryLinks
    on QueryBuilder<BookCopy, BookCopy, QFilterCondition> {
  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> book(
      FilterQuery<Book> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'book');
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> bookIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'book', 0, true, 0, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> currentBorrower(
      FilterQuery<Borrower> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'currentBorrower');
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      currentBorrowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'currentBorrower', 0, true, 0, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> previousBorrowers(
      FilterQuery<Borrower> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'previousBorrowers');
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previousBorrowers', length, true, length, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previousBorrowers', 0, true, 0, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previousBorrowers', 0, false, 999999, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'previousBorrowers', 0, true, length, include);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previousBorrowers', length, include, 999999, true);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      previousBorrowersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'previousBorrowers', lower, includeLower, upper, includeUpper);
    });
  }
}

extension BookCopyQuerySortBy on QueryBuilder<BookCopy, BookCopy, QSortBy> {
  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByIssueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.desc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByReturnDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returnDate', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByReturnDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returnDate', Sort.desc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension BookCopyQuerySortThenBy
    on QueryBuilder<BookCopy, BookCopy, QSortThenBy> {
  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByIssueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.desc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByReturnDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returnDate', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByReturnDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returnDate', Sort.desc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BookCopy, BookCopy, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension BookCopyQueryWhereDistinct
    on QueryBuilder<BookCopy, BookCopy, QDistinct> {
  QueryBuilder<BookCopy, BookCopy, QDistinct> distinctByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'issueDate');
    });
  }

  QueryBuilder<BookCopy, BookCopy, QDistinct> distinctByReturnDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'returnDate');
    });
  }

  QueryBuilder<BookCopy, BookCopy, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension BookCopyQueryProperty
    on QueryBuilder<BookCopy, BookCopy, QQueryProperty> {
  QueryBuilder<BookCopy, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookCopy, DateTime?, QQueryOperations> issueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'issueDate');
    });
  }

  QueryBuilder<BookCopy, DateTime?, QQueryOperations> returnDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'returnDate');
    });
  }

  QueryBuilder<BookCopy, IssueStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
