import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/books/screens/book_details_screen/book_deletion_dialog.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_viewmodel.g.dart';

/// Business logic layer for book details page.
@riverpod
class BookDetailsViewModel extends _$BookDetailsViewModel {
  @override
  Book build(Book book) {
    // Listen for changes to this particular book object and update the state
    // with the latest data.
    DatabaseRepository.instance
        .bookStream(book.id)
        .listen((_) => ref.notifyListeners());
    // Listen for changes in book copies collection and update the state with
    // the latest data.
    DatabaseRepository.instance.bookCopiesStream
        .listen((_) => ref.notifyListeners());
    // Listen for changes to linked author object and update the state with
    // the latest data.
    DatabaseRepository.instance
        .authorStream(book.author.value!.id)
        .listen((_) => ref.notifyListeners());
    return book;
  }

  /// Shows book deletion dialog.
  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => BookDeletionDialog(
        book: book,
        onDelete: () => deleteBook(context),
      ),
    );
  }

  /// Deletes the book from database and also its cover image from the app
  /// directory.
  Future<bool> deleteBook(BuildContext context) async {
    // Delete the book from database.
    final bool bookDeleted = await DatabaseRepository.instance.deleteBook(book);
    // If book wasn't successfully deleted, return false.
    if (!bookDeleted) return false;
    // If book had a cover image.
    if (book.coverImage.isNotEmpty) {
      // Delete cover image file only if the book was deleted successfully.
      await FilesRepository.instance.deleteFile(book.coverImage);
    }
    // Navigate back to the home page.
    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }
    // Return deletion status.
    return bookDeleted;
  }

  /// Shows book editor.
  Future<void> showBookEditor(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BookEditor(book: book),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
