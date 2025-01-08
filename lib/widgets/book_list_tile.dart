import 'package:flutter/material.dart';
import 'package:libertad/data/models/book_model.dart';

class BookListTile extends StatelessWidget {
  final BookModel book;
  final int index;

  const BookListTile({super.key, required this.book, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${index + 1}.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // TODO: Add image support.
          // const SizedBox(width: 12),
          // Image.file(File(book.coverImage)),
        ],
      ),
      title: Text(book.title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('by ${book.author}'),
          Row(
            children: [
              Text('Released: ${book.releaseDate.year}'),
              const SizedBox(width: 12),
              Text('Genre: ${book.genre}'),
            ],
          )
        ],
      ),
      subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Text('Issued: ${book.issuedCopies}'),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: Text('Total: ${book.totalCopies}'),
          ),
        ],
      ),
    );
  }
}
