import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/data/mock/mock_borrowers.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_filters.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_filters.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/data/models/issued_copy_filters.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';

void main() {
  /// Sets up the environment for running tests.
  setUp(() async {
    // Initialize Isar database in test mode.
    await DatabaseRepository.instance.initializeForTest();
  });

  /// Tests data fetching methods, i.e., getting books, authors, issued copies,
  /// and borrowers.
  group('Data fetchers', () {
    /// Tests books data retrieval with sorting and filters.
    test('Get books', () async {
      // Populate the database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Filter by release date range and sort in descending by release date.
      final DateTime oldestReleaseDateFilter = DateTime(1976);
      final DateTime newestReleaseDateFilter = DateTime(2012);
      final BookSort sortBy = BookSort.releaseDate;
      final SortOrder sortOrder = SortOrder.descending;

      // Retrieve books from the database. Also apply filters and sort them.
      final List<Book> books = await DatabaseRepository.instance.getBooks(
        filters: BookFilters(
          oldestReleaseDateFilter: oldestReleaseDateFilter,
          newestReleaseDateFilter: newestReleaseDateFilter,
        ),
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      // Query mock books data to verify filters and sorting in the database.
      final List<Book> referenceBooks = mockBooks
          .where((book) => book.releaseDate.isAfter(oldestReleaseDateFilter))
          .where((book) => book.releaseDate.isBefore(newestReleaseDateFilter))
          .toList()
        ..sort(
          (book1, book2) => book2.releaseDate.compareTo(book1.releaseDate),
        );

      // Create a list of books' titles.
      final List<String> booktitles = books.map((book) => book.title).toList();

      // Similarly, create a list of reference books' titles.
      final List<String> referenceBookTitles =
          referenceBooks.map((book) => book.title).toList();

      // Expect the reference books to match the retrieved books.
      expect(
        booktitles,
        referenceBookTitles,
        reason:
            'Books retrieval from the database works correctly, including filters and sorting.',
      );
    });

    /// Tests authors data retrieval with sorting.
    test('Get authors', () async {
      // Populate the database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Sort by author's name.
      final AuthorSort sortBy = AuthorSort.name;

      // Retrieve sorted authors from the database.
      final List<Author> authors =
          await DatabaseRepository.instance.getAuthors(sortBy: sortBy);

      // Query mock authors data to verify sorting in the database.
      final List<Author> referenceAuthors = mockAuthors
        ..sort((author1, author2) => author1.name.compareTo(author2.name));

      // Create a list of authors' names.
      final List<String> authorNames =
          authors.map((author) => author.name).toList();

      // Similarly, create a list of reference authors' names.
      final List<String> referenceAuthorNames =
          referenceAuthors.map((author) => author.name).toList();

      // Expect the reference authors to match the retrieved authors.
      expect(
        authorNames,
        referenceAuthorNames,
        reason:
            'Authors retrieval from the database works correctly, including sorting.',
      );
    });

    /// Tests borrowers data retrieval with sorting and filters.
    test('Get issued copies', () async {
      // Populate the database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Get all copies from the database and shuffle them to issue random
      // copies.
      final List<BookCopy> copies =
          await DatabaseRepository.instance.getAllCopies()
            ..shuffle();

      // Get all borrowers from the database.
      final List<Borrower> borrowers =
          await DatabaseRepository.instance.getBorrowers();

      // We will issue 6 random copies to a borrower.
      final List<BookCopy> copiesToIssue = copies.sublist(4, 10);
      for (final BookCopy copy in copiesToIssue) {
        await DatabaseRepository.instance.issueCopy(copy, borrowers.first);
      }

      // Filter by book.
      final Book bookFilter = copies.first.book.value!;

      // Retrieve issued copies from the database. Also apply filters.
      final List<BookCopy> issuedCopies =
          await DatabaseRepository.instance.getIssuedCopies(
        filters: IssuedCopyFilters(bookFilter: bookFilter),
      );

      // Query all copies data to verify filters in the database.
      final List<BookCopy> referenceIssuedCopies = copies
          .where((copy) => copy.isIssued)
          .where((copy) => copy.book.value == bookFilter)
          .toList();

      // Create a list of issued copies' IDs.
      final List<Id> issuedCopyIDs =
          issuedCopies.map((copy) => copy.id).toList();

      // Similarly, create a list of reference issued copies' IDs.
      final List<Id> referenceIssuedCopyIDs =
          referenceIssuedCopies.map((copy) => copy.id).toList();

      // Expect the reference issued copies to match the retrieved issued
      // copies.
      expect(
        issuedCopyIDs,
        referenceIssuedCopyIDs,
        reason:
            'Issued copies retrieval from the database works correctly, including filters and sorting.',
      );
    });

    /// Tests borrowers data retrieval with sorting and filters.
    test('Get borrowers', () async {
      // Populate the database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Filter by active status and sort in descending by release date.
      final bool activeFilter = false;
      final BorrowerSort sortBy = BorrowerSort.membershipStartDate;
      final SortOrder sortOrder = SortOrder.descending;

      // Retrieve borrowers from the database. Also apply filters and sort them.
      final List<Borrower> borrowers =
          await DatabaseRepository.instance.getBorrowers(
        filters: BorrowerFilters(activeFilter: activeFilter),
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      // Query mock borrowers data to verify filters and sorting in the
      // database.
      final List<Borrower> referenceBorrowers =
          mockBorrowers.where((borrower) => borrower.isActive == false).toList()
            ..sort(
              (borrower1, borrower2) => borrower2.membershipStartDate
                  .compareTo(borrower1.membershipStartDate),
            );

      // Create a list of borrowers' names.
      final List<String> borrowerNames =
          borrowers.map((borrower) => borrower.name).toList();

      // Similarly, create a list of reference borrowers' names.
      final List<String> referenceBorrowerNames =
          referenceBorrowers.map((borrower) => borrower.name).toList();

      // Expect the reference borrowers to match the retrieved borrowers.
      expect(
        borrowerNames,
        referenceBorrowerNames,
        reason:
            'Borrowers retrieval from the database works correctly, including filters and sorting.',
      );
    });
  });

  /// Tests creation methods, i.e., adding a book and borrower.
  group('Creation', () {
    /// Tests book addition.
    test('Add book', () async {
      // Book object to add to the database.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database. Also adds the author because it doesn't
      // exist yet.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Retrieve the added book from the database.
      final Book? addedBook =
          await DatabaseRepository.instance.getBook(book.id);
      // Retrieve the added author from the database.
      final Author? addedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Expect the added book and author to be in the database.
      expect(
        addedBook?.id,
        book.id,
        reason: 'Book successfully added to the database.',
      );
      expect(
        addedAuthor?.id,
        author.id,
        reason:
            'Book\'s author did not exist before. So, it should be added automatically while adding the book.',
      );
    });

    /// Tests borrower addition.
    test('Add borrower', () async {
      // Borrower object to add to the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Retrieve the added borrower from the database.
      final Borrower? addedBorrower =
          await DatabaseRepository.instance.getBorrower(borrower.id);

      // Expect the added borrower to be in the database.
      expect(
        addedBorrower?.id,
        borrower.id,
        reason: 'Borrower successfully added to the database.',
      );
    });
  });

  /// Tests updation methods, i.e., updating book, author, and borrower.
  group('Updation', () {
    /// Tests book updation.
    test('Update book', () async {
      // Book object to add & update in the database.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to initially add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database to update later.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Update book's properties.
      book
        ..title = 'Harry Potter and the Chamber of Secrets'
        ..genre = Genre.adventure;

      // New author object to link to the book in the database.
      final Author newAuthor = Author(
        name: 'J.K. Rowling',
        bio:
            'J.K. Rowling is a British author, best known for creating the magical world of Harry Potter.',
      );
      // New total number of copies to generate for the book.
      final int newTotalCopies = 10;

      // Update the book in the database with new author and total copies.
      await DatabaseRepository.instance
          .updateBook(book, newAuthor, newTotalCopies);

      // Retrieve the updated book from the database.
      final Book? updatedBook =
          await DatabaseRepository.instance.getBook(book.id);

      // Retrieve the added author from the database.
      final Author? addedAuthor =
          await DatabaseRepository.instance.getAuthor(newAuthor.id);

      // Try to retrieve the old (and removed) author from the database. It
      // doesn't exist, so should return null.
      final Author? oldAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Expect the book's properties to be updated in the database.
      expect(updatedBook?.title, book.title,
          reason: 'Book\'s title successfully updated in the database.');
      expect(updatedBook?.genre, book.genre,
          reason: 'Book\'s genre successfully updated in the database.');
      expect(updatedBook?.author.value?.id, newAuthor.id,
          reason: 'Book\'s author successfully updated in the database.');
      expect(updatedBook?.totalCopies.length, book.totalCopies.length,
          reason: 'Book\'s total copies successfully updated in the database.');

      // Expect the new author to be added in the database, and the old one to
      // be removed.
      expect(
        addedAuthor?.id,
        newAuthor.id,
        reason:
            'Book\'s new author did not exist before. So, it should be added automatically while updating the book.',
      );
      expect(
        oldAuthor?.id,
        null,
        reason:
            'Book\'s old author does not have any of their books in the library now. So, it should be deleted automatically while updating the book.',
      );
    });

    /// Tests author updation.
    test('Update author', () async {
      // Book object to add to the database. Adding a book is the only way to
      // add an author because authors cannot exist independently without books.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add & update in the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book, and consequently its author, to the database to update
      // the author later.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Update author's properties.
      author
        ..name = 'George Orwell'
        ..bio =
            'George Orwell was an English novelist and essayist, known for his works exploring themes of social injustice and totalitarianism.';

      // Update the author in the database.
      await DatabaseRepository.instance.updateAuthor(author);

      // Retrieve the updated author from the database.
      final Author? updatedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Expect the author's properties to be updated in the database.
      expect(updatedAuthor?.name, author.name,
          reason: 'Author\'s name successfully updated in the database.');
      expect(updatedAuthor?.bio, author.bio,
          reason: 'Author\'s bio successfully updated in the database.');
    });

    /// Tests borrower updation.
    test('Update borrower', () async {
      // Borrower object to add & update in the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Update borrower's properties.
      borrower
        ..name = 'Marcus Aurelius'
        ..membershipDuration = 18;

      // Update the borrower in the database.
      await DatabaseRepository.instance.updateBorrower(borrower);

      // Retrieve the updated author from the database.
      final Borrower? updatedBorrower =
          await DatabaseRepository.instance.getBorrower(borrower.id);

      // Expect the borrower's properties to be updated in the database.
      expect(
        updatedBorrower?.name,
        borrower.name,
        reason: 'Borrower\'s name successfully updated in the database.',
      );
      expect(
        updatedBorrower?.membershipDuration,
        borrower.membershipDuration,
        reason:
            'Borrower\'s membership duration successfully updated in the database.',
      );
    });
  });

  /// Tests deletion methods, i.e., deleting book, author, and borrower.
  group('Deletion', () {
    /// Tests book deletion.
    test('Delete book', () async {
      // Clear database to avoid discrepancy.
      await DatabaseRepository.instance.clearDatabase();
      // Book object to add to the database.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database. Also adds the author because it doesn't
      // exist yet.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Retrieve the added book from the database.
      final Book? addedBook =
          await DatabaseRepository.instance.getBook(book.id);

      // Retrieve the added author from the database.
      final Author? addedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Retrieve all the book copies in the database.
      final List<BookCopy> allCopies =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the added book and author to be in the database.
      expect(
        addedBook?.id,
        book.id,
        reason: 'Book successfully added to the database.',
      );
      expect(
        addedAuthor?.id,
        author.id,
        reason:
            'Book\'s author did not exist before. So, it should be added automatically while adding the book.',
      );

      // Expect the total copies in the database to be equal to that of the
      // book.
      expect(
        allCopies.length,
        totalCopies,
        reason:
            'Add book function internally generates copies, and since it\'s the only book, the total copies in the database should be equal to that of the book.',
      );

      // Delete the book from the database. Since this is author's only book,
      // the function deletes the author as well.
      await DatabaseRepository.instance.deleteBook(book);

      // Try to retrieve the deleted book from the database. It doesn't exist,
      // so should return null.
      final Book? deletedBook =
          await DatabaseRepository.instance.getBook(book.id);

      // Try to retrieve the deleted author from the database. It doesn't exist,
      // so should return null.
      final Author? deletedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Retrieve all the book copies in the database post deletion.
      final List<BookCopy> allCopiesAfterDeletion =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the book and its author to be deleted from the database.
      expect(deletedBook, null,
          reason: 'Book successfully deleted from the database');
      expect(deletedAuthor, null,
          reason: 'Author successfully deleted from the database');

      // Expect no copies to exist in the database.
      expect(
        allCopiesAfterDeletion.length,
        0,
        reason:
            'Delete book function deletes all the copies linked to the book, and since it\'s the only book, no copies should exist in the database.',
      );
    });

    /// Tests author deletion.
    test('Delete author', () async {
      // Clear database to avoid discrepancy.
      await DatabaseRepository.instance.clearDatabase();
      // Book object to add to the database.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book, and consequently its author, to the database to delete
      // the author later.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Retrieve the added book from the database.
      final Book? addedBook =
          await DatabaseRepository.instance.getBook(book.id);

      // Retrieve the added author from the database.
      final Author? addedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Retrieve all the book copies in the database.
      final List<BookCopy> allCopies =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the added book and author to be in the database.
      expect(
        addedBook?.id,
        book.id,
        reason: 'Book successfully added to the database.',
      );
      expect(
        addedAuthor?.id,
        author.id,
        reason:
            'Book\'s author did not exist before. So, it should be added automatically while adding the book.',
      );

      // Expect the total copies in the database to be equal to that of the
      // book.
      expect(
        allCopies.length,
        totalCopies,
        reason:
            'Add book function internally generates copies, and since it\'s the only book, the total copies in the database should be equal to that of the book.',
      );

      // Delete the author from the database. This function deletes all the
      // books linked to the author and their respective copies as well.
      await DatabaseRepository.instance.deleteAuthor(author);

      // Try to retrieve the deleted author from the database. It doesn't exist,
      // so should return null.
      final Author? deletedAuthor =
          await DatabaseRepository.instance.getAuthor(author.id);

      // Try to retrieve the deleted book from the database. It doesn't exist,
      // so should return null.
      final Book? deletedBook =
          await DatabaseRepository.instance.getBook(book.id);

      // Retrieve all the book copies in the database post deletion.
      final List<BookCopy> allCopiesAfterDeletion =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the author and the linked book to be deleted from the database.
      expect(deletedAuthor, null,
          reason: 'Author successfully deleted from the database');
      expect(deletedBook, null,
          reason: 'Book successfully deleted from the database');

      // Expect no copies to exist in the database.
      expect(
        allCopiesAfterDeletion.length,
        0,
        reason:
            'Delete author function deletes all the copies of the linked books, and since there\'s only one book, no copies should exist in the database.',
      );
    });

    /// Tests borrower deletion.
    test('Delete borrower', () async {
      // Clear database to avoid discrepancy.
      await DatabaseRepository.instance.clearDatabase();
      // Borrower object to add to the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Retrieve the added borrower from the database.
      final Borrower? addedBorrower =
          await DatabaseRepository.instance.getBorrower(borrower.id);

      // Expect the added borrower to be in the database.
      expect(
        addedBorrower?.id,
        borrower.id,
        reason: 'Borrower successfully added to the database.',
      );

      // Book object to add to the database. We'll issue a copy of this book to
      // the borrower.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Now that both book and borrower are in the database, we issue one of
      // book's copies to the borrower.
      final BookCopy copy = book.totalCopies.first
        ..issueDate = DateTime.now()
        ..returnDate = DateTime.now().add(Duration(days: 7))
        ..status = IssueStatus.issued;
      await DatabaseRepository.instance.issueCopy(copy, borrower);

      // Expect the copy to be issued to the borrower.
      expect(copy.currentBorrower.value?.id, borrower.id,
          reason: 'Copy issued to the borrower.');

      // Delete the borrower. This function also un-issues all the copies issued
      // to the borrower.
      await DatabaseRepository.instance.deleteBorrower(borrower);

      // Try to retrieve the deleted borrower from the database. It doesn't
      // exist, so should return null.
      final Borrower? deletedBorrower =
          await DatabaseRepository.instance.getBorrower(book.id);

      // Retrieve the copy that was issued to the borrower.
      final BookCopy? issuedCopy =
          await DatabaseRepository.instance.getBookCopy(copy.id);

      // Expect the borrower to be deleted from the database.
      expect(deletedBorrower, null,
          reason: 'Borrower successfully deleted from the database');

      // Expect the copy to be available and unlinked to the borrower.
      expect(issuedCopy?.isAvailable, true,
          reason: 'Copy should be made available now.');
      expect(issuedCopy?.currentBorrower.value?.id, null,
          reason: 'Copy should not have a borrower linked to it.');
    });
  });

  /// Tests library transactions, i.e., issue and return copy, and accept fine.
  group('Library transactions', () {
    /// Tests issue book functionality.
    test('Issue book', () async {
      // Borrower object to add to the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Book object to add to the database. We'll issue a copy of this book to
      // the borrower.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Now that both book and borrower are in the database, we can issue one
      // of book's copies to the borrower.
      final BookCopy copy = book.totalCopies.first
        ..issueDate = DateTime.now()
        ..returnDate = DateTime.now().add(Duration(days: 7))
        ..status = IssueStatus.issued;
      await DatabaseRepository.instance.issueCopy(copy, borrower);

      // Expect the copy to be issued to the borrower.
      expect(copy.currentBorrower.value?.id, borrower.id,
          reason: 'Copy issued to the borrower.');
    });

    /// Tests return book functionality.
    test('Return book', () async {
      // Borrower object to add to the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Book object to add to the database. We'll issue a copy of this book to
      // the borrower.
      final Book book = Book(
        title: 'To Kill a Mockingbird',
        genre: Genre.fiction,
        releaseDate: DateTime(1960, 7, 11),
        summary:
            'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      );
      // Author object to add to the database.
      final Author author = Author(
        name: 'Harper Lee',
        bio:
            'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      );
      // Book's total copies. Just need to specify the number of copies because
      // they are generated by the function and linked to the book.
      final int totalCopies = 4;

      // Add the book to the database.
      await DatabaseRepository.instance.addBook(book, author, totalCopies);

      // Now that both book and borrower are in the database, we can issue one
      // of book's copies to the borrower.
      final BookCopy copy = book.totalCopies.first
        ..issueDate = DateTime.now()
        ..returnDate = DateTime.now().add(Duration(days: 7))
        ..status = IssueStatus.issued;
      await DatabaseRepository.instance.issueCopy(copy, borrower);

      // Expect the copy to be issued to the borrower.
      expect(copy.currentBorrower.value?.id, borrower.id,
          reason: 'Copy issued to the borrower.');

      // Mark the copy as available again.
      // Reset issue and return dates.
      copy
        ..issueDate = null
        ..returnDate = null
        ..status = IssueStatus.available;

      // Return the copy back from the borrower.
      await DatabaseRepository.instance.returnCopy(copy, borrower);

      // Expect the copy to be available now.
      expect(copy.currentBorrower.value?.id, null,
          reason: 'Copy does not belong to any borrower.');

      // Expect the borrower to be in the copy's previous borrowers set.
      expect(copy.previousBorrowers.first.id, borrower.id,
          reason: 'Copy maintains its past borrowers list accurately.');
    });

    /// Tests fine acceptance functionality.
    test('Accept fine', () async {
      // Borrower object to add to the database.
      final Borrower borrower = Borrower(
        name: 'Michael Johnson',
        contact: '4155551023',
        membershipStartDate: DateTime(2024, 9, 12),
        membershipDuration: 12,
      );

      // Add the borrower to the database.
      await DatabaseRepository.instance.addBorrower(borrower);

      // Mark the borrower as defaulter and levy fine.
      borrower
        ..isDefaulter = true
        ..fineDue = 10;

      // Update the defaulter status in the database.
      await DatabaseRepository.instance.updateBorrower(borrower);

      // Retrieve the added borrower from the database.
      final Borrower? addedBorrower =
          await DatabaseRepository.instance.getBorrower(borrower.id);

      // Expect the borrower to be marked as defaulter in the database.
      expect(addedBorrower?.isDefaulter, true,
          reason: 'Borrower is marked as defaulter.');

      // Lift the borrower's defaulter status and reset fine.
      borrower
        ..isDefaulter = false
        ..fineDue = 0;

      // Accept the fine in the database.
      await DatabaseRepository.instance.acceptFine(borrower);

      // Retrieve the updated borrower from the database.
      final Borrower? updatedBorrower =
          await DatabaseRepository.instance.getBorrower(borrower.id);

      // Expect the borrower to be a non-defaulter now.
      expect(
        updatedBorrower?.isDefaulter,
        false,
        reason: 'Borrower\'s defaulter status has been removed',
      );
    });
  });

  group('Search functionality', () {
    /// Tests author search.
    test('Search authors', () async {
      // Populate database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Query to search the authors.
      final String query = 'row';

      // Search through the authors and retrieve that match the query.
      final List<Author> searchedAuthors =
          await DatabaseRepository.instance.searchAuthors(query);

      // Create a list of authors' names.
      final List<String> searchedAuthorNames =
          searchedAuthors.map((author) => author.name).toList();

      // Query mock authors data to verify database search.
      final List<String> referenceSearch = mockAuthors
          .map((author) => author.name)
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Expect reference search to match the actual database search.
      expect(searchedAuthorNames, referenceSearch,
          reason: 'Author search functionality works correctly.');
    });

    /// Tests borrower search.
    test('Search borrowers', () async {
      // Populate database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Query to search the borrowers.
      final String query = 'Li';

      // Search through the borrowers and retrieve that match the query.
      final List<Borrower> searchedBorrowers =
          await DatabaseRepository.instance.searchBorrowers(query);

      // Create a list of borrowers' names.
      final List<String> searchedBorrowerNames =
          searchedBorrowers.map((borrower) => borrower.name).toList();

      // Query mock borrowers data to verify database search.
      final List<String> referenceSearch = mockBorrowers
          .map((borrower) => borrower.name)
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Expect reference search to match the actual database search.
      expect(searchedBorrowerNames, referenceSearch,
          reason: 'Borrower search functionality works correctly.');
    });

    /// Tests database search.
    test('Search database', () async {
      // Populate database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Query to search the borrowers.
      final String query = 'Li';

      // Search through the borrowers and retrieve that match the query.
      final SearchResult searchResult =
          await DatabaseRepository.instance.searchDatabase(query);

      // Extract out the data into comparable format -- title for books, and
      // name for authors and borrowers.
      final Set<String> searchedBookTitles =
          searchResult.books.map((book) => book.title).toSet();
      final Set<String> searchedAuthorNames =
          searchResult.authors.map((author) => author.name).toSet();
      final Set<String> searchedBorrowerNames =
          searchResult.borrowers.map((borrower) => borrower.name).toSet();

      // Query mock books data to verify database search.
      final Set<Book> bookReferenceSearch = mockBooks
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toSet();
      final Set<String> bookTitlesReferenceSearch =
          bookReferenceSearch.map((book) => book.title).toSet();

      // Query mock authors data to verify database search.
      final Set<Author> authorReferenceSearch = mockAuthors
          .where((author) =>
              author.name.toLowerCase().contains(query.toLowerCase()))
          .toSet();
      final Set<String> authorNamesReferenceSearch =
          authorReferenceSearch.map((author) => author.name).toSet();

      // Need to append the query-matched books' authors to the reference search
      // because that's how we're filtering in the database as well.
      for (final Book book in bookReferenceSearch) {
        final int index = mockBooks.indexOf(book);
        final Author author = mockAuthors[index];
        authorNamesReferenceSearch.add(author.name);
      }

      // Need to append the query-matched authors' books to the reference search
      // because that's how we're filtering in the database as well.
      for (final Author author in authorReferenceSearch) {
        final int index = mockAuthors.indexOf(author);
        final Book book = mockBooks[index];
        bookTitlesReferenceSearch.add(book.title);
      }

      // Query mock borrowers data to verify database search.
      final Set<String> borrowerNamesReferenceSearch = mockBorrowers
          .where((borrower) =>
              borrower.name.toLowerCase().contains(query.toLowerCase()))
          .map((borrower) => borrower.name)
          .toSet();

      // Expect reference search to match the actual database search.
      expect(searchedBookTitles, bookTitlesReferenceSearch,
          reason: 'Database search functionality works correctly for books.');
      expect(searchedAuthorNames, authorNamesReferenceSearch,
          reason: 'Database search functionality works correctly for authors.');
      expect(searchedBorrowerNames, borrowerNamesReferenceSearch,
          reason:
              'Database search functionality works correctly for borrowers.');
    });
  });

  group('Developer options', () {
    test('Reset database', () async {
      // Reset database to its original state with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Retrieve the data from database.
      final List<Book> books = await DatabaseRepository.instance.getBooks();
      final List<Author> authors =
          await DatabaseRepository.instance.getAuthors();
      final List<Borrower> borrowers =
          await DatabaseRepository.instance.getBorrowers();
      final List<BookCopy> copies =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the database to be populated with mock data.
      expect(
        books.length,
        mockBooks.length,
        reason: 'Database is populated with mock books data.',
      );
      expect(
        authors.length,
        mockAuthors.length,
        reason: 'Database is populated with mock authors data.',
      );
      expect(
        borrowers.length,
        mockBooks.length,
        reason: 'Database is populated with mock borrowers data.',
      );

      // Expect at least one copy to be generated per book.
      expect(
        copies.length >= books.length,
        true,
        reason: 'Database is populated with at least one copy per book.',
      );
    });

    test('Clear database', () async {
      // Populate the database with mock data.
      await DatabaseRepository.instance.resetDatabase(deleteImages: false);

      // Retrieve the data from database.
      final List<Book> books = await DatabaseRepository.instance.getBooks();
      final List<Author> authors =
          await DatabaseRepository.instance.getAuthors();
      final List<Borrower> borrowers =
          await DatabaseRepository.instance.getBorrowers();
      final List<BookCopy> copies =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the database to be populated with mock data.
      expect(
        books.length,
        mockBooks.length,
        reason: 'Database is populated with mock books data.',
      );
      expect(
        authors.length,
        mockAuthors.length,
        reason: 'Database is populated with mock authors data.',
      );
      expect(
        borrowers.length,
        mockBooks.length,
        reason: 'Database is populated with mock borrowers data.',
      );

      // Expect at least one copy to be generated per book.
      expect(
        copies.length >= books.length,
        true,
        reason: 'Database is populated with at least one copy per book.',
      );

      // Clear the database.
      await DatabaseRepository.instance.clearDatabase();

      // Try to retrieve data from database. It should be empty because the
      // database has been cleared.
      final List<Book> clearedBooks =
          await DatabaseRepository.instance.getBooks();
      final List<Author> clearedAuthors =
          await DatabaseRepository.instance.getAuthors();
      final List<Borrower> clearedBorrowers =
          await DatabaseRepository.instance.getBorrowers();
      final List<BookCopy> clearedCopies =
          await DatabaseRepository.instance.getAllCopies();

      // Expect the database to be empty.
      expect([
        ...clearedBooks,
        ...clearedAuthors,
        ...clearedBorrowers,
        ...clearedCopies,
      ], [], reason: 'Database has been cleared');
    });
  });
}
