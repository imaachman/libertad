import 'package:isar/isar.dart';
import 'package:libertad/data/models/author.dart';

part 'book.g.dart';

@collection
class Book {
  Id id = Isar.autoIncrement;
  final String title;
  final IsarLink<Author> author = IsarLink<Author>();
  final String genre;
  final DateTime releaseDate;
  final String summary;
  final String coverImage;
  final int totalCopies;
  final int issuedCopies;

  Book({
    required this.title,
    required this.genre,
    required this.releaseDate,
    required this.summary,
    required this.coverImage,
    required this.totalCopies,
    required this.issuedCopies,
  });

  Book copyWith({
    String? title,
    String? genre,
    DateTime? releaseDate,
    String? summary,
    String? coverImage,
    int? totalCopies,
    int? issuedCopies,
  }) =>
      Book(
        title: title ?? this.title,
        genre: genre ?? this.genre,
        releaseDate: releaseDate ?? this.releaseDate,
        summary: summary ?? this.summary,
        coverImage: coverImage ?? this.coverImage,
        totalCopies: totalCopies ?? this.totalCopies,
        issuedCopies: issuedCopies ?? this.issuedCopies,
      );
}
