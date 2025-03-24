import 'dart:math';

import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/genre.dart';

/// Contains methods that generate data for books, authors, copies, and
/// borrowers.
class DataGenerators {
  static var random = Random();

  /// Generates mock authors and books and links them together.
  /// Links need to be saved manually.
  /// - Random names and titles like "Author 1" and "Book 3".
  /// - Bio and summary are based on name and title.
  /// - Genre is random.
  /// - Release dates range from 1990 to current year.
  static AuthorsAndBooks generateAuthorsAndBooks(
      int authorCount, int booksPerAuthorMin, int booksPerAuthorMax) {
    final List<Author> authors = [];
    final List<Book> allBooks = [];

    // Generate authors and random number of books for each author.
    for (int i = 0; i < authorCount; i++) {
      // Author model with name and bio based on count.
      final Author author = Author(
        name: 'Author ${i + 1}',
        bio: 'Bio for Author ${i + 1}',
      );

      // Number of books between [booksPerAuthorMin] and [booksPerAuthorMax].
      final int numBooks = booksPerAuthorMin +
          random.nextInt(booksPerAuthorMax - booksPerAuthorMin + 1);

      // Stores author's books.
      final List<Book> booksByAuthor = [];

      // Generate books and link them to the author.
      // Genre and release date are random.
      for (int j = 0; j < numBooks; j++) {
        final title = 'Book Title ${allBooks.length + 1}';
        final book = Book(
          title: title,
          genre: Genre.values[random.nextInt(Genre.values.length)],
          releaseDate: DateTime(1990 + random.nextInt(35),
              random.nextInt(12) + 1, random.nextInt(28) + 1),
          summary: 'Summary for $title by ${author.name}.',
        );

        // Link the book to the author.
        book.author.value = author;

        // Add it to author's books list and all books list.
        booksByAuthor.add(book);
        allBooks.add(book);
      }

      // Link the author back to books.
      author.books.addAll(booksByAuthor);

      // Add it to the authors list.
      authors.add(author);
    }

    return AuthorsAndBooks(authors: authors, books: allBooks);
  }

  /// Generates a list of [Borrower] objects with mixed active/inactive
  /// memberships.
  /// - Random names like "Borrower 1", "Borrower 2", etc.
  /// - Contact is a unique 10-digit number.
  /// - Start dates range from 2022 to current year.
  /// - Membership duration ranges from 6 to 24 months.
  static List<Borrower> generateBorrowers(int count) {
    List<Borrower> borrowers = [];

    for (int i = 0; i < count; i++) {
      String name = 'Borrower ${i + 1}';
      String contact = (1000000000 + random.nextInt(900000000)).toString();

      DateTime startDate = DateTime(
        2022 + random.nextInt(4), // Year: 2022 to 2025
        random.nextInt(12) + 1, // Month: 1 to 12
        random.nextInt(28) + 1, // Day: 1 to 28
      );

      int duration = 6 + random.nextInt(24); // Duration in months (6–30)

      borrowers.add(Borrower(
        name: name,
        contact: contact,
        membershipStartDate: startDate,
        membershipDuration: duration,
      ));
    }

    return borrowers;
  }

  /// Generates [totalCopies] number of [BookCopy] objects and links each of
  /// them to the provided [book] object.
  static List<BookCopy> generateCopies(Book book, int totalCopies) {
    return List.generate(
      totalCopies,
      (index) => BookCopy()..book.value = book,
    );
  }
}

/// Holds the result with both authors and books.
class AuthorsAndBooks {
  final List<Author> authors;
  final List<Book> books;

  AuthorsAndBooks({required this.authors, required this.books});
}
