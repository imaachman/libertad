import 'package:flutter/material.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/navigation/routes.dart';

class IssuedCopyTile extends StatelessWidget {
  final BookCopy copy;
  final int index;
  final bool minimal;

  const IssuedCopyTile({
    super.key,
    required this.copy,
    required this.index,
    this.minimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.bookCopy, arguments: copy),
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
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Copy ${copy.id}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    copy.book.value!.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  if (!minimal) ...[
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'borrowed by ',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          TextSpan(
                            text: copy.currentBorrower.value!.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: copy.returnDate!.isBefore(DateTime.now())
                      ? Theme.of(context)
                          .colorScheme
                          .tertiaryContainer
                          .withAlpha(180)
                      : Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withAlpha(180),
                ),
                child: Center(
                  child: Text(
                    copy.returnDate!.prettifySmart,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
