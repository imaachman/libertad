import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/author_field_viewmodel.dart';

class AuthorField extends ConsumerWidget {
  const AuthorField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Author?> author = ref.watch(authorFieldViewModelProvider);

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
            shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
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
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
