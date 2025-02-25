import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/authors/viewmodels/author_editor_viewmodel.dart';

class AuthorEditorDialog extends ConsumerStatefulWidget {
  final Author? author;
  final String query;

  const AuthorEditorDialog({super.key, this.author, this.query = ''});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthorEditorDialogState();
}

class _AuthorEditorDialogState extends ConsumerState<AuthorEditorDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.watch(authorEditorViewModelProvider(widget.author));
    final AuthorEditorViewModel model =
        ref.watch(authorEditorViewModelProvider(widget.author).notifier);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.author == null ? 'Add New Author' : 'Edit Author',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 1,
                child: model.temporaryProfilePicture.isEmpty
                    ? Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: TextButton.icon(
                            icon: Icon(Icons.file_upload_outlined),
                            label: Text('Upload picture'),
                            onPressed: () => model.selectProfilePicture(),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned.fill(
                            child: Image.file(
                              File(model.temporaryProfilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox.square(
                                dimension: 36,
                                child: IconButton(
                                  onPressed: model.clearProfilePicture,
                                  icon: Icon(Icons.delete_outline, size: 20),
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withAlpha(120),
                                    ),
                                  ),
                                  tooltip: 'Delete cover',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              NameField(
                initialValue: model.author?.name ?? widget.query,
                onChanged: model.setName,
              ),
              const SizedBox(height: 16),
              BioField(
                initialValue: model.bio,
                onChanged: model.setBio,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () => model.updateAuthor(context, formKey),
                    child: Text(
                      widget.author == null ? 'Create Author' : 'Update Author',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NameField extends StatelessWidget {
  final String initialValue;
  final void Function(String value)? onChanged;

  const NameField({super.key, required this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Enter name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name cannot be empty';
        return null;
      },
      onChanged: onChanged,
    );
  }
}

class BioField extends StatelessWidget {
  final String initialValue;
  final void Function(String value)? onChanged;

  const BioField({super.key, required this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter author\'s bio',
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter author\'s bio';
            }
            return null;
          },
          onChanged: onChanged,
        ),
      ],
    );
  }
}
