import 'package:isar/isar.dart';
import 'package:libertad/data/models/book.dart';

part 'author.g.dart';

/// Represents author collection in the database.
@collection
class Author {
  /// Author's unique identifier.
  /// [autoIncrement] method automatically assigns a unique integer by keeping
  /// a count of objects.
  Id id = Isar.autoIncrement;

  /// Author's name.
  @Index()
  String name;

  /// Author's bio.
  String bio;

  /// Path to the author's profile picture in the app's directory.
  String profilePicture;

  /// Link to the books written by the author.
  @Backlink(to: 'author')
  final IsarLinks<Book> books = IsarLinks<Book>();

  /// Date/time of object creation.
  @Index()
  late final DateTime createdAt;

  /// Date/time of object updation.
  @Index()
  late DateTime updatedAt;

  Author({
    required this.name,
    required this.bio,
    this.profilePicture = '',
  });

  /// Creates a copy of the object with the provided parameters.
  Author copyWith({
    String? name,
    String? bio,
    String? profilePicture,
  }) =>
      Author(
        name: name ?? this.name,
        bio: bio ?? this.bio,
        profilePicture: profilePicture ?? this.profilePicture,
      );
}
