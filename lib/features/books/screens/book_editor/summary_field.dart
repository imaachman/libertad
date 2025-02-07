import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class SummaryField extends ConsumerWidget {
  final Book? book;

  const SummaryField({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter book\'s summary',
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
          initialValue: model.summary,
          validator: model.validateSummary,
          onChanged: model.setSummary,
        ),
      ],
    );
  }
}
