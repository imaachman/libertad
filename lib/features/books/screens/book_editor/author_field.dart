import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/author_field_viewmodel.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class AuthorField extends ConsumerWidget {
  const AuthorField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the [AuthorFieldViewModel] to get the selected author.
    final AsyncValue<Author?> author = ref.watch(authorFieldViewModelProvider);

    // Listen to the [BookEditorViewModel] to check if an author is selected.
    ref.watch(bookEditorViewModelProvider());
    // Check if an author is selected.
    final bool authorNotSelected =
        !ref.watch(bookEditorViewModelProvider().notifier).isAuthorSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Author',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        TextButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                side: authorNotSelected
                    ? BorderSide(color: Theme.of(context).colorScheme.error)
                    : BorderSide.none,
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.surfaceContainerHighest),
          ),
          onPressed: () => ref
              .read(authorFieldViewModelProvider.notifier)
              .showAuthorsSearchView(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            width: double.infinity,
            height: 56,
            child: Center(
                child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 16),
                Text(
                  author.value?.name ?? 'Select author',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ),
        ),
        if (authorNotSelected) ...[
          SizedBox(height: 4),
          Text(
            'Please select an author',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ]
      ],
    );
  }
}
