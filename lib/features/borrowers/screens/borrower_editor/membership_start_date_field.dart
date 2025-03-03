import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_editor_viewmodel.dart';

class MembershipStartDateField extends ConsumerWidget {
  final Borrower? borrower;

  const MembershipStartDateField({super.key, this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to [BorrowerEditorViewModel] provider to update the membership
    // start date in the UI.
    ref.watch(borrowerEditorViewModelProvider(borrower: borrower));
    // Access [BorrowerEditorViewModel] to get the release date.
    final BorrowerEditorViewModel model =
        ref.watch(borrowerEditorViewModelProvider(borrower: borrower).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Joining Date',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.membershipStartDate.prettify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => model.selectMembershipStartDate(context),
        ),
      ],
    );
  }
}
