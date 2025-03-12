import 'package:isar/isar.dart';
import 'package:libertad/data/models/book_copy.dart';

part 'borrower.g.dart';

@collection
class Borrower {
  Id id = Isar.autoIncrement;
  @Index()
  String name;
  String contact;
  String profilePicture;
  @Index()
  DateTime membershipStartDate;
  int membershipDuration;
  bool isDefaulter = false;
  double fineDue = 0;
  @Backlink(to: 'currentBorrower')
  final IsarLinks<BookCopy> currentlyIssuedBooks = IsarLinks<BookCopy>();
  @Backlink(to: 'previousBorrowers')
  final IsarLinks<BookCopy> previouslyIssuedBooks = IsarLinks<BookCopy>();
  @Index()
  final DateTime createdAt = DateTime.now();
  @Index()
  DateTime updatedAt = DateTime.now();

  Borrower({
    required this.name,
    required this.contact,
    this.profilePicture = '',
    required this.membershipStartDate,
    required this.membershipDuration,
  });

  Borrower copyWith({
    String? name,
    String? contact,
    String? profilePicture,
    DateTime? membershipStartDate,
    int? membershipDuration,
    bool? isDefaulter,
    double? fineDue,
  }) =>
      Borrower(
        name: name ?? this.name,
        contact: contact ?? this.contact,
        profilePicture: profilePicture ?? this.profilePicture,
        membershipStartDate: membershipStartDate ?? this.membershipStartDate,
        membershipDuration: membershipDuration ?? this.membershipDuration,
      );
}
