import 'package:isar/isar.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/genre.dart';

part 'book.g.dart';

/// Represents book collection in the database.
@collection
class Book {
  /// Book's unique identifier.
  /// [autoIncrement] method automatically assigns a unique integer by keeping
  /// a count of objects.
  Id id = Isar.autoIncrement;

  /// Book's title.
  @Index()
  String title;

  /// Link to book's author.
  final IsarLink<Author> author = IsarLink<Author>();

  /// Book's genre.
  @enumerated
  Genre genre;

  /// Book's release date.
  @Index()
  DateTime releaseDate;

  /// Book's summary.
  String summary;

  /// Path to book's cover image in the app's directory.
  String coverImage;

  /// Link to all the copies of the book.
  @Index()
  @Backlink(to: 'book')
  final IsarLinks<BookCopy> totalCopies = IsarLinks<BookCopy>();

  /// Date/time of object creation.
  @Index()
  late final DateTime createdAt;

  /// Date/time of object updation.
  @Index()
  late DateTime updatedAt;

  /// Set of issued copies.
  @ignore
  Set<BookCopy> get issuedCopies =>
      totalCopies.where((copy) => copy.isIssued).toSet();

  Book({
    required this.title,
    required this.genre,
    required this.releaseDate,
    required this.summary,
    this.coverImage = '',
  });

  /// Creates a copy of the object with the provided parameters.
  Book copyWith({
    String? title,
    Genre? genre,
    DateTime? releaseDate,
    String? summary,
    String? coverImage,
  }) =>
      Book(
        title: title ?? this.title,
        genre: genre ?? this.genre,
        releaseDate: releaseDate ?? this.releaseDate,
        summary: summary ?? this.summary,
        coverImage: coverImage ?? this.coverImage,
      );
}
