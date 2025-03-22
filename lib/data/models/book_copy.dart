import 'package:isar/isar.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/issue_status.dart';

part 'book_copy.g.dart';

/// Represents book copy collection in the database.
@collection
class BookCopy {
  /// Copy's unique identifier.
  /// [autoIncrement] method automatically assigns a unique integer by keeping
  /// a count of objects.
  Id id = Isar.autoIncrement;

  /// Link to the copy's book.
  final IsarLink<Book> book = IsarLink<Book>();

  /// Date when the copy is issued.
  @Index()
  DateTime? issueDate;

  /// Date when the copy is due to return.
  @Index()
  DateTime? returnDate;

  /// Link to the current borrower of the copy.
  final IsarLink<Borrower> currentBorrower = IsarLink<Borrower>();

  /// Link to the previous borrowers of the copy.
  final IsarLinks<Borrower> previousBorrowers = IsarLinks<Borrower>();

  /// Defines whether the copy is currently issued or available.
  @enumerated
  IssueStatus status = IssueStatus.available;

  /// Whether the copy is issued.
  @ignore
  bool get isIssued => status.isIssued;

  /// Whether the copy is available.
  @ignore
  bool get isAvailable => status.isAvailable;

  /// Whether the copy's return date has passed.
  @ignore
  bool get returnDatePassed => returnDate?.isBefore(DateTime.now()) ?? false;

  /// Returns the number of days by which the issued copy has surpassed the
  /// return date.
  int overdueBy() {
    if (returnDatePassed) {
      return DateTime.now().difference(returnDate!).inDays;
    } else {
      return 0;
    }
  }

  /// Creates a copy of the object.
  BookCopy copyWith() => BookCopy();
}
