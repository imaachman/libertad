import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_viewmodel.g.dart';

@riverpod
class BookDetailsViewModel extends _$BookDetailsViewModel {
  @override
  Book build(Book book) {
    DatabaseRepository.instance
        .bookStream(book.id)
        .listen((_) => ref.notifyListeners());
    return book;
  }

  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(text: 'Are you sure you want to delete '),
              TextSpan(
                text: book.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await deleteBook(book);
              if (!context.mounted) return;
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<bool> deleteBook(Book book) async {
    final bool bookDeleted = await DatabaseRepository.instance.deleteBook(book);
    if (!bookDeleted) return false;
    if (book.coverImage.isNotEmpty) {
      // Delete cover image file only if the book was deleted succesfully.
      await FilesRepository.instance.deleteFile(book.coverImage);
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
