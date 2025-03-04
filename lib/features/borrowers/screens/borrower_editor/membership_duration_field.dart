import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_editor_viewmodel.dart';

class MembershipDurationField extends ConsumerWidget {
  final Borrower? borrower;

  const MembershipDurationField({super.key, this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: 120,
          child: TextFormField(
            initialValue: ref
                .watch(borrowerEditorViewModelProvider(borrower: borrower)
                    .notifier)
                .membershipDuration
                .toString(),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              errorMaxLines: 3,
              suffixText: 'months',
              suffixStyle: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: ref
                .read(borrowerEditorViewModelProvider(borrower: borrower)
                    .notifier)
                .validateMembershipDuration,
            onChanged: ref
                .read(borrowerEditorViewModelProvider(borrower: borrower)
                    .notifier)
                .setMembershipDuration,
          ),
        ),
      ],
    );
  }
}
