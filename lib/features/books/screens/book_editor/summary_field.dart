import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class SummaryField extends ConsumerWidget {
  const SummaryField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          validator:
              ref.read(bookEditorViewModelProvider().notifier).validateSummary,
          onChanged:
              ref.read(bookEditorViewModelProvider().notifier).setSummary,
        ),
      ],
    );
  }
}
