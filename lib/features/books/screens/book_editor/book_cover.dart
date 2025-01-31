import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/author_field_viewmodel.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class BookCover extends ConsumerWidget {
  const BookCover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to [BookEditorViewModel] provider to update the UI with the book's
    // title.
    ref.watch(bookEditorViewModelProvider());

    return AspectRatio(
      aspectRatio: 10 / 16,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          boxShadow: [BoxShadow(offset: Offset(-5, 5))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(bookEditorViewModelProvider().notifier).title,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Consumer(builder: (context, ref, child) {
              final AsyncValue<Author?> author =
                  ref.watch(authorFieldViewModelProvider);
              return Text(
                author.value?.name ?? 'author',
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }),
          ],
        ),
      ),
    );
  }
}
