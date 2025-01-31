import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class SummaryField extends ConsumerWidget {
  final TextEditingController controller;

  const SummaryField({super.key, required this.controller});

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
          controller: controller,
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
