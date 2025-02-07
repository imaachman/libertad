import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_viewmodel.g.dart';

@riverpod
class BookDetailsViewModel extends _$BookDetailsViewModel {
  @override
  void build() {}

  Future<void> showDeletionDialog(BuildContext context, Book book) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete "${book.title}"?'),
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
    return await DatabaseRepository.instance.deleteBook(book);
  }

  Future<void> showBookEditor(BuildContext context, Book book) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BookEditor(book: book),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
