import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class TitleField extends ConsumerWidget {
  final Book? book;

  const TitleField({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter book\'s title',
          ),
          initialValue: model.title,
          validator: model.validateTitle,
          onChanged: model.setTitle,
        ),
      ],
    );
  }
}
