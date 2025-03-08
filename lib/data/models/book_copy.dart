import 'package:isar/isar.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/borrower.dart';

part 'book_copy.g.dart';

enum IssueStatus { issued, available }

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

  BookCopy copyWith() => BookCopy();
}
