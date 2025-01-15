import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/widgets/row_column_switch.dart';

class BookEditor extends ConsumerStatefulWidget {
  const BookEditor({super.key});

  @override
  ConsumerState<BookEditor> createState() => _BookEditorState();
}

class _BookEditorState extends ConsumerState<BookEditor> {
  late final TextEditingController titleController;
  late final TextEditingController authorController;
  late final TextEditingController summaryController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: 'title');
    authorController = TextEditingController(text: 'author');
    summaryController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.80,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    final double maxWidth = constraints.maxWidth;
                    // Whether to build a column or a row. Depends on screen
                    // size.
                    final bool buildColumn = maxWidth < kSmallPhone / 3;
                    // Gap between book cover and text fields.
                    final double gap = 16;

                    return RowColumnSwitch(
                      columnWhen: buildColumn,
                      crossAxisAlignment: buildColumn
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: buildColumn ? (maxWidth / 2) : (maxWidth / 3),
                          child: BookCover(
                            titleController: titleController,
                            authorController: authorController,
                          ),
                        ),
                        SizedBox(
                          width: buildColumn ? null : gap,
                          height: buildColumn ? gap : null,
                        ),
                        SizedBox(
                          width:
                              buildColumn ? maxWidth : (maxWidth / 1.5 - gap),
                          child: Column(
                            children: [
                              TitleField(controller: titleController),
                              SizedBox(height: 16),
                              AuthorField(controller: authorController),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                  SizedBox(height: 16),
                  SummaryField(controller: summaryController),
                  // SizedBox(height: 16),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter genre',
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  // OutlinedButton(
                  //   child: Text('Select release date'),
                  //   onPressed: () {
                  //     showDatePicker(
                  //       context: context,
                  //       firstDate: DateTime(1600),
                  //       lastDate: DateTime.now(),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 16),
                  // SizedBox(
                  //   width: 200,
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Text('Total copies:'),
                  //             TextField(
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Text('Issued copies:'),
                  //             TextField(
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.authorController.text,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleField extends StatelessWidget {
  final TextEditingController controller;

  const TitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter book\'s title',
          ),
        ),
      ],
    );
  }
}

class AuthorField extends StatelessWidget {
  final TextEditingController controller;

  const AuthorField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter book\'s author',
          ),
        ),
      ],
    );
  }
}

class SummaryField extends StatelessWidget {
  final TextEditingController controller;

  const SummaryField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter book\'s summary',
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
        ),
      ],
    );
  }
}
