import 'package:isar/isar.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/issue_status.dart';

part 'book_copy.g.dart';

@collection
class BookCopy {
  Id id = Isar.autoIncrement;
  final IsarLink<Book> book = IsarLink<Book>();
  @Index()
  DateTime? issueDate;
  @Index()
  DateTime? returnDate;
  final IsarLink<Borrower> currentBorrower = IsarLink<Borrower>();
  final IsarLinks<Borrower> previousBorrowers = IsarLinks<Borrower>();
  @enumerated
  IssueStatus status = IssueStatus.available;

  @ignore
  bool get isIssued => status.isIssued;

  @ignore
  bool get isAvailable => status.isAvailable;

  BookCopy copyWith() => BookCopy();
}
