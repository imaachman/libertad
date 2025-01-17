import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/author_field_viewmodel.dart';

class BookCover extends StatefulWidget {
  final TextEditingController titleController;

  const BookCover({
    super.key,
    required this.titleController,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(rebuild);
  }

  @override
  void dispose() {
    widget.titleController.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
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
              widget.titleController.text,
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
