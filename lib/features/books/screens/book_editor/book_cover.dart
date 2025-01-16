import 'package:flutter/material.dart';

class BookCover extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController authorController;

  const BookCover({
    super.key,
    required this.titleController,
    required this.authorController,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(rebuild);
    widget.authorController.addListener(rebuild);
  }

  @override
  void dispose() {
    widget.titleController.removeListener(rebuild);
    widget.authorController.removeListener(rebuild);
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
            Text(
              widget.authorController.text,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
