import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/book_cover.dart';

class BookListTile extends StatelessWidget {
  final Book book;
  final int index;

  const BookListTile({super.key, required this.book, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.book, arguments: book),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              '${index + 1}.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: BookCover(book: book),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'by ${book.author.value?.name}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [
                      Text(
                        'Released: ${book.releaseDate.year}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Genre: ${book.genre.name}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Text(
                      'Issued: ${book.issuedCopies.length}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    child: Text(
                      'Total: ${book.totalCopies.length}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
