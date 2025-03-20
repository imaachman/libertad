import 'package:isar/isar.dart';
import 'package:libertad/data/models/book_copy.dart';

part 'borrower.g.dart';

/// Represents author collection in the database.
@collection
class Borrower {
  /// Borrower's unique identifier.
  /// [autoIncrement] method automatically assigns a unique integer by keeping
  /// a count of objects.
  Id id = Isar.autoIncrement;

  /// Borrower's name.
  @Index()
  String name;

  /// Borrower's contact.
  String contact;

  /// Path to the borrower's profile picture in the app's directory.
  String profilePicture;

  /// Date when borrower's membership started.
  @Index()
  DateTime membershipStartDate;

  /// Duration of membership.
  int membershipDuration;

  /// Whether the borrower is a defaulter.
  bool isDefaulter = false;

  /// The amount of fine due against the borrower.
  double fineDue = 0;

  /// Link to all the books currently issued by the borrower.
  @Backlink(to: 'currentBorrower')
  final IsarLinks<BookCopy> currentlyIssuedBooks = IsarLinks<BookCopy>();

  /// Link to all the books issued by the borrower in the past.
  @Backlink(to: 'previousBorrowers')
  final IsarLinks<BookCopy> previouslyIssuedBooks = IsarLinks<BookCopy>();

  /// Date/time of object creation.
  @Index()
  late final DateTime createdAt;

  /// Date/time of object updation.
  @Index()
  late DateTime updatedAt;

  /// Date when the borrower's membership ends.
  DateTime get membershipEndDate => membershipStartDate.copyWith(
      month: membershipStartDate.month + membershipDuration);

  /// Whether the borrower's membership is active.
  @ignore
  bool get isActive => membershipEndDate.isAfter(DateTime.now());

  Borrower({
    required this.name,
    required this.contact,
    this.profilePicture = '',
    required this.membershipStartDate,
    required this.membershipDuration,
  });

  /// Creates a copy of the object with the provided parameters.
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
