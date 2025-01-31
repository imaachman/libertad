import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class TitleField extends ConsumerWidget {
  final TextEditingController controller;

  const TitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter book\'s title',
          ),
          validator:
              ref.read(bookEditorViewModelProvider.notifier).validateTitle,
          onChanged: ref.read(bookEditorViewModelProvider.notifier).setTitle,
        ),
      ],
    );
  }
}
