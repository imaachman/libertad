class BookModel {
  final String title;
  final String author;
  final String genre;
  final DateTime releaseDate;
  final String summary;
  final String coverImage;
  final int totalCopies;
  final int issuedCopies;

  BookModel({
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
