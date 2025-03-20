import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/books/screens/book_details_screen/book_deletion_dialog.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_viewmodel.g.dart';

@riverpod
class BookDetailsViewModel extends _$BookDetailsViewModel {
  @override
  Book build(Book book) {
    DatabaseRepository.instance
        .bookStream(book.id)
        .listen((_) => ref.notifyListeners());
    DatabaseRepository.instance.bookCopiesStream
        .listen((_) => ref.notifyListeners());
    DatabaseRepository.instance
        .authorStream(book.author.value!.id)
        .listen((_) => ref.notifyListeners());
    return book;
  }

  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => BookDeletionDialog(
        book: book,
        onDelete: () => deleteBook(context),
      ),
    );
  }

  Future<bool> deleteBook(BuildContext context) async {
    final bool bookDeleted = await DatabaseRepository.instance.deleteBook(book);
    if (!bookDeleted) return false;

    if (book.coverImage.isNotEmpty) {
      // Delete cover image file only if the book was deleted succesfully.
      await FilesRepository.instance.deleteFile(book.coverImage);
    }

    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }

    return bookDeleted;
  }

  Future<void> showBookEditor(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BookEditor(book: book),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
