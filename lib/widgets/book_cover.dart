import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';

class BookCover extends StatelessWidget {
  final Book book;
  final TextStyle? titleStyle;
  final TextStyle? authorStyle;

  const BookCover({
    super.key,
    required this.book,
    this.titleStyle,
    this.authorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 16,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          boxShadow: [BoxShadow(offset: Offset(-5, 5))],
        ),
        child: book.coverImage.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: titleStyle ?? Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    book.author.value?.name ?? 'author',
                    style: authorStyle ??
                        Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Image.file(
                File(book.coverImage),
                fit: BoxFit.fitHeight,
              ),
      ),
    );
  }
}
