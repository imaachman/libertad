import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class EditableBookCover extends ConsumerWidget {
  final Book? book;

  const EditableBookCover({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to [BookEditorViewModel] provider to update the UI with the book's
    // title and author.
    ref.watch(bookEditorViewModelProvider(book: book));
    // Access [BookEditorViewModel] to display the uploaded cover image.
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 10 / 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              boxShadow: [BoxShadow(offset: Offset(-5, 5))],
            ),
            child: model.temporaryCoverImage.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Consumer(
                        builder: (context, ref, child) => Text(
                          model.author?.name ?? 'author',
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    File(model.temporaryCoverImage),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox.square(
              dimension: 36,
              child: IconButton(
                onPressed: () {
                  if (model.temporaryCoverImage.isEmpty) {
                    model.selectCoverImage();
                  } else {
                    model.clearCoverImage();
                  }
                },
                icon: Icon(
                  model.temporaryCoverImage.isEmpty
                      ? Icons.file_upload_outlined
                      : Icons.delete_outline,
                  size: 20,
                ),
                color: model.temporaryCoverImage.isEmpty
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSecondary,
                style: ButtonStyle(
                  backgroundColor: model.temporaryCoverImage.isEmpty
                      ? null
                      : WidgetStatePropertyAll(
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(120),
                        ),
                ),
                tooltip: model.temporaryCoverImage.isEmpty
                    ? 'Upload cover'
                    : 'Delete cover',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
