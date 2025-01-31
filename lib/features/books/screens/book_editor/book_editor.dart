import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/features/books/screens/book_editor/add_book_button.dart';
import 'package:libertad/features/books/screens/book_editor/genre_field.dart';
import 'package:libertad/features/books/screens/book_editor/release_date_field.dart';
import 'package:libertad/features/books/screens/book_editor/total_copies_field.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: 'title');
  }

  @override
  void dispose() {
    titleController.dispose();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 32),
                      SummaryField(),
                      SizedBox(height: 32),
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
                      SizedBox(height: 16),
                      TotalCopiesField(),
                      SizedBox(height: 32),
                      Center(child: AddBookButton(formKey: formKey)),
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
