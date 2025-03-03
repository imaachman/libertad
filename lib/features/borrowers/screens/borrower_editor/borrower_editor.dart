import 'package:flutter/material.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/borrower_add_update_button.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/contact_field.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/editable_profile_picture.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/membership_duration_field.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/membership_start_date_field.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/name_field.dart';
import 'package:libertad/widgets/row_column_switch.dart';

class BorrowerEditor extends StatelessWidget {
  final Borrower? borrower;

  BorrowerEditor({super.key, this.borrower});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.60,
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
                  final double gap = 20;

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
                            child: EditableProfilePicture(borrower: borrower),
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
                                NameField(borrower: borrower),
                                SizedBox(height: 16),
                                ContactField(borrower: borrower),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 32),
                      // SummaryField(book: book),
                      // SizedBox(height: 32),
                      RowColumnSwitch(
                        columnWhen: buildColumn,
                        crossAxisAlignment: buildColumn
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:
                                buildColumn ? maxWidth : (maxWidth - gap) / 2,
                            child: MembershipStartDateField(borrower: borrower),
                          ),
                          SizedBox(
                            width: buildColumn ? null : gap,
                            height: buildColumn ? gap : null,
                          ),
                          SizedBox(
                            width:
                                buildColumn ? maxWidth : (maxWidth - gap) / 2,
                            child: MembershipDurationField(borrower: borrower),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Center(
                        child: BorrowerAddUpdateButton(
                          formKey: formKey,
                          borrower: borrower,
                        ),
                      ),
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
