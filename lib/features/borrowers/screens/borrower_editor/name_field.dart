import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_editor_viewmodel.dart';

class NameField extends ConsumerWidget {
  final Borrower? borrower;

  const NameField({super.key, this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BorrowerEditorViewModel model =
        ref.watch(borrowerEditorViewModelProvider(borrower: borrower).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter borrower\'s name',
          ),
          initialValue: model.name,
          validator: model.validateName,
          onChanged: model.setName,
        ),
      ],
    );
  }
}
