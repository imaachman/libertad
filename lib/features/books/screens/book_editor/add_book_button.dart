import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class AddBookButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const AddBookButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => ref
          .read(bookEditorViewModelProvider().notifier)
          .addBook(context, formKey),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).primaryColor,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth / 2,
            height: 48,
            child: Center(
              child: Text(
                'Add Book',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
