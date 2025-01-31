import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/features/books/screens/book_editor/add_book_button.dart';
import 'package:libertad/features/books/screens/book_editor/genre_field.dart';
import 'package:libertad/features/books/screens/book_editor/release_date_field.dart';
import 'package:libertad/widgets/row_column_switch.dart';

import 'author_field.dart';
import 'book_cover.dart';
import 'summary_field.dart';
import 'title_field.dart';

class BookEditor extends ConsumerStatefulWidget {
  const BookEditor({super.key});

  @override
  ConsumerState<BookEditor> createState() => _BookEditorState();
}

class _BookEditorState extends ConsumerState<BookEditor> {
  late final TextEditingController titleController;
  late final TextEditingController summaryController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: 'title');
    summaryController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
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
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double maxWidth = constraints.maxWidth;
                  // Whether to build a column or a row. Depends on screen
                  // size.
                  final bool buildColumn = maxWidth < kSmallPhone / 3;
                  // Gap between book cover and text fields.
                  final double gap = 16;

                  return Column(
                    children: [
                      RowColumnSwitch(
                        columnWhen: buildColumn,
                        crossAxisAlignment: buildColumn
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width:
                                buildColumn ? (maxWidth / 2) : (maxWidth / 3),
                            child: BookCover(
                              titleController: titleController,
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
                                AuthorField(),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      SummaryField(controller: summaryController),
                      SizedBox(height: 16),
                      RowColumnSwitch(
                        columnWhen: buildColumn,
                        crossAxisAlignment: buildColumn
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:
                                buildColumn ? maxWidth : (maxWidth - gap) / 2,
                            child: GenreField(),
                          ),
                          SizedBox(
                            width: buildColumn ? null : gap,
                            height: buildColumn ? gap : null,
                          ),
                          SizedBox(
                            width:
                                buildColumn ? maxWidth : (maxWidth - gap) / 2,
                            child: ReleaseDateField(),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      AddBookButton(formKey: formKey),

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
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
