import 'package:isar/isar.dart';
import 'package:libertad/data/models/book_copy.dart';

part 'borrower.g.dart';

@collection
class Borrower {
  Id id = Isar.autoIncrement;
  String name;
  String contact;
  DateTime membershipStartDate;
  int membershipDuration;
  bool isDefaulter;
  double fineDue;
  @Backlink(to: 'currentBorrower')
  final IsarLinks<BookCopy> currentlyIssuedBooks = IsarLinks<BookCopy>();
  @Backlink(to: 'previousBorrowers')
  final IsarLinks<BookCopy> previouslyIssuedBooks = IsarLinks<BookCopy>();

  Borrower({
    required this.name,
    required this.contact,
    required this.membershipStartDate,
    required this.membershipDuration,
    required this.isDefaulter,
    required this.fineDue,
  });

  Borrower copyWith({
    String? name,
    String? contact,
    DateTime? membershipStartDate,
    int? membershipDuration,
    bool? isDefaulter,
    double? fineDue,
  }) =>
      Borrower(
        name: name ?? this.name,
        contact: contact ?? this.contact,
        membershipStartDate: membershipStartDate ?? this.membershipStartDate,
        membershipDuration: membershipDuration ?? this.membershipDuration,
        isDefaulter: isDefaulter ?? this.isDefaulter,
        fineDue: fineDue ?? this.fineDue,
      );
}
