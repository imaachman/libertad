import 'package:isar/isar.dart';

part 'book.g.dart';

@collection
class Book {
  final Id id = Isar.autoIncrement;
  final String title;
  final String author;
  final String genre;
  final DateTime releaseDate;
  final String summary;
  final String coverImage;
  final int totalCopies;
  final int issuedCopies;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.releaseDate,
    required this.summary,
    required this.coverImage,
    required this.totalCopies,
    required this.issuedCopies,
  });
}
