import 'package:isar/isar.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/genre.dart';

part 'book.g.dart';

@collection
class Book {
  Id id = Isar.autoIncrement;
  String title;
  final IsarLink<Author> author = IsarLink<Author>();
  @enumerated
  Genre genre;
  DateTime releaseDate;
  String summary;
  String coverImage;
  @Backlink(to: 'book')
  final IsarLinks<BookCopy> totalCopies = IsarLinks<BookCopy>();

  @ignore
  Set<BookCopy> get issuedCopies =>
      totalCopies.where((copy) => copy.status == IssueStatus.issued).toSet();

  Book({
    required this.title,
    required this.genre,
    required this.releaseDate,
    required this.summary,
    required this.coverImage,
  });

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
