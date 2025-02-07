import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class TotalCopiesField extends ConsumerWidget {
  final Book? book;

  const TotalCopiesField({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Copies',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: ref
                .watch(bookEditorViewModelProvider(book: book).notifier)
                .totalCopies
                .toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              errorMaxLines: 2,
              prefixIcon: Icon(
                Icons.my_library_books_rounded,
                size: 20,
              ),
            ),
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: ref
                .read(bookEditorViewModelProvider(book: book).notifier)
                .validateTotalCopies,
            onChanged: ref
                .read(bookEditorViewModelProvider(book: book).notifier)
                .setTotalCopies,
          ),
        ),
      ],
    );
  }
}
