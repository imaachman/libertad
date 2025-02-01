import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
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

  /// Path to the cover image of the book.
  String coverImage = '';

  /// Total copies of the book available in the library.
  int totalCopies = 1;

  /// Whether an author is selected via [AuthorField] or not.
  bool isAuthorSelected = true;

  /// Whether a genre is selected via [GenreField] or not.
  bool isGenreSelected = true;

  /// Temporary path to the cover image of the book. This is used to display the
  /// book cover before the book is added to the database.
  String temporaryCoverImage = '';

  @override
  Book? build({Book? book}) {
    if (book != null) {
      title = book.title;
      author = book.author.value;
      genre = book.genre;
      releaseDate = book.releaseDate;
      summary = book.summary;
      coverImage = book.coverImage;
      totalCopies = book.totalCopies;
    }
    return book;
  }

  /// Creates a [Book] object from the form fields' values and adds it to the
  /// database.
  Future<void> addBook(
      BuildContext context, GlobalKey<FormState> formKey) async {
    // Check if an author is selected.
    if (author == null) {
      // Mark author as unselected to show invalid state in [AuthorField].
      isAuthorSelected = false;
      ref.notifyListeners();
    }

    // Check if a genre is selected.
    if (genre == null) {
      // Mark genre as unselected to show invalid state in [GenreField].
      isGenreSelected = false;
      ref.notifyListeners();
    }

    // Check if the inputs of all [TextFormField]s are valid.
    final bool isFormValid = formKey.currentState!.validate();

    // If any of the inputs are invalid, do not add the book to the database.
    if (!isAuthorSelected || !isGenreSelected || !isFormValid) {
      return;
    }

    // If a cover image has been selected, copy it to the app's documents
    // directory and update [coverImage] with the new path.
    if (temporaryCoverImage.isNotEmpty) {
      final File copiedFile =
          await FilesRepository.instance.copyImageFile(temporaryCoverImage);
      // Update the cover image path to the new file path.
      coverImage = copiedFile.path;
    }

    // Create a new [Book] object with the values of form fields.
    final Book newBook = Book(
      title: title,
      genre: genre!,
      releaseDate: releaseDate,
      summary: summary,
      coverImage: coverImage,
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

  /// Updates [title].
  void setTitle(String value) {
    title = value;
    ref.notifyListeners();
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

  /// Opens file picker to select a cover image for the book.
  Future<void> selectCoverImage() async {
    // Select an image file from the device.
    final File? file = await FilesRepository.instance.selectImageFile();
    // If no file is selected, return.
    if (file == null) return;
    // Get the path to the selected file and update [temporaryCoverImage] to
    // display in [BookCover].
    temporaryCoverImage = file.path;
    ref.notifyListeners();
  }

  /// Clears the temporary cover image so that the default book cover is
  /// displayed.
  void clearCoverImage() {
    temporaryCoverImage = '';
    ref.notifyListeners();
  }

  /// Updates [genre].
  void setGenre(Genre value) {
    genre = value;
    // Mark genre as selected.
    isGenreSelected = true;
    ref.notifyListeners();
  }

  /// Opens date picker and selects the release date of the book.
  Future<void> selectReleaseDate(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: releaseDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the release date.
    if (selectedDate != null) {
      releaseDate = selectedDate;
      ref.notifyListeners();
    }
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
  void setTotalCopies(String value) {
    if (value.isEmpty) return;
    totalCopies = int.parse(value);
  }

  /// Checks if the input for total copies is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateTotalCopies(String? value) {
    if (value == null || value.isEmpty) return 'Add at least one copy';
    return null;
  }
}
