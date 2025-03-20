import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

/// Button that adds a new book to the database, or updates an existing one.
class BookAddUpdateButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final Book? book;

  const BookAddUpdateButton({super.key, required this.formKey, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);

    return TextButton(
      onPressed: () {
        if (book == null) {
          model.addBook(context, formKey);
        } else {
          model.updateBook(context, formKey, book!);
        }
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).primaryColor,
        ),
      ),
      child: SizedBox(
        height: 48,
        child: Center(
          child: Text(
            book == null ? 'Add Book' : 'Update Book',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
