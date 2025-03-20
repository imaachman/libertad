import 'package:flutter/material.dart';

/// Dialog that shows all the files in the app directory.
class AppDirectoryDialog extends StatelessWidget {
  final List<String> files;

  const AppDirectoryDialog({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Files',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.separated(
          itemCount: files.length,
          itemBuilder: (context, index) => Text(
            files[index],
            style: Theme.of(context).textTheme.labelLarge,
          ),
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Close'))
      ],
    );
  }
}
