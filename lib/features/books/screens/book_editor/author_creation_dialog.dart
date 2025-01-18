import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';

class AuthorCreationDialog extends ConsumerStatefulWidget {
  final String query;

  const AuthorCreationDialog({super.key, required this.query});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthorCreationDialogState();
}

class _AuthorCreationDialogState extends ConsumerState<AuthorCreationDialog> {
  late final TextEditingController nameController;
  late final TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.query);
    bioController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add New Author',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: TextButton.icon(
                    icon: Icon(Icons.file_upload_outlined),
                    label: Text('Upload picture'),
                    onPressed: () {
                      // TODO: Image upload functionality.
                    },
                  ),
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 16),
            BioField(controller: bioController),
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
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        bioController.text.isEmpty) {
                      return;
                    }
                    Navigator.pop<Author>(
                      context,
                      Author(
                        name: nameController.text,
                        bio: bioController.text,
                        books: [],
                      ),
                    );
                  },
                  child: Text(
                    'Create Author',
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
    );
  }
}

class BioField extends StatelessWidget {
  final TextEditingController controller;

  const BioField({super.key, required this.controller});

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
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter author\'s bio',
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
        ),
      ],
    );
  }
}
