import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';

/// Holds the data that is returned as the output of complete database search.
class SearchResult {
  final List<Book> books;
  final List<Author> authors;
  final List<BookCopy> issuedCopies;
  final List<Borrower> borrowers;

  SearchResult({
    required this.books,
    required this.authors,
    required this.issuedCopies,
    required this.borrowers,
  });
}
