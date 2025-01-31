import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_editor_viewmodel.g.dart';

@riverpod
class BookEditorViewModel extends _$BookEditorViewModel {
  /// Title of the book.
  String title = 'title';

  /// Author of the book.
  Author? author;

  /// Genre of the book.
  Genre? genre;

  /// Release date of the book.
  DateTime releaseDate = DateTime(1997, 6, 26);

  /// Summary of the book.
  String summary = '';

  /// Total copies of the book available in the library.
  int totalCopies = 1;

  /// Whether an author is selected via [AuthorField] or not.
  bool isAuthorSelected = true;

  @override
  Book? build({Book? book}) {
    if (book != null) {
      title = book.title;
      author = book.author.value;
      genre = Genre.adventure;
      releaseDate = book.releaseDate;
      summary = book.summary;
      totalCopies = book.totalCopies;
    }
    return book;
  }

  /// Creates a [Book] object from the form fields' values and adds it to the
  /// database.
  Future<void> addBook(
      BuildContext context, GlobalKey<FormState> formKey) async {
    // Check if the inputs of all [TextFormField]s are valid.
    if (formKey.currentState!.validate()) {
      // Check if an author is selected.
      if (author == null) {
        // Mark author as unselected to show invalid state in [AuthorField].
        isAuthorSelected = false;
        ref.notifyListeners();
        return;
      }
      // Create a new [Book] object with the values of form fields.
      final Book newBook = Book(
        title: title,
        genre: Genre.adventure.name,
        releaseDate: releaseDate,
        summary: summary,
        coverImage: 'coverImage',
        totalCopies: totalCopies,
        issuedCopies: 0,
      )..author.value = author;
      // Add the book to the database.
      await DatabaseRepository.instance.addBook(newBook);
      // Context mount check to prevent memory leaks.
      if (!context.mounted) return;
      // Navigate back from the book editor.
      Navigator.of(context).pop();
    }
  }

  /// Updates [title].
  void setTitle(String value) {
    title = value;
  }

  /// Checks if the input for book's title is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) return 'Title cannot be empty';
    return null;
  }

  /// Updates [author] and makes the author as selected to show valid state in
  /// [AuthorField].
  void setAuthor(Author? value) {
    author = value;
    // Mark author as selected.
    isAuthorSelected = true;
    ref.notifyListeners();
  }

  /// Updates [genre].
  void setGenre(Genre value) {
    genre = value;
  }

  /// Updates [releaseDate].
  void setReleaseDate(DateTime value) {
    releaseDate = value;
  }

  /// Updates [summary].
  void setSummary(String value) {
    summary = value;
  }

  /// Checks if the input for book's summary is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateSummary(String? value) {
    if (value == null || value.isEmpty) return 'Summary cannot be empty';
    return null;
  }

  /// Updates [totalCopies].
  void setTotalCopies(int value) {
    totalCopies = value;
  }
}
