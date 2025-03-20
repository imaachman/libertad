import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_editor_viewmodel.dart';

/// Profile picture widget that allows the user to delete the profile picture or
/// upload a new one.
class EditableProfilePicture extends ConsumerWidget {
  final Borrower? borrower;

  const EditableProfilePicture({super.key, required this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to [BorrowerEditorViewModel] provider to update the UI.
    ref.watch(borrowerEditorViewModelProvider(borrower: borrower));
    // Access [BorrowerEditorViewModel] to display the uploaded profile picture.
    final BorrowerEditorViewModel model =
        ref.watch(borrowerEditorViewModelProvider(borrower: borrower).notifier);

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 4),
            ),
            child: model.temporaryProfilePicture.isEmpty
                ? Icon(
                    Icons.person,
                    size: 64,
                  )
                : Image.file(
                    File(model.temporaryProfilePicture),
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        SizedBox(height: 8),
        model.temporaryProfilePicture.isEmpty
            ? TextButton(
                onPressed: () => model.selectProfilePicture(),
                child: Text(
                  'Upload Picture',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            : TextButton(
                onPressed: () => model.clearProfilePicture(),
                child: Text(
                  'Clear Picture',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }
}
