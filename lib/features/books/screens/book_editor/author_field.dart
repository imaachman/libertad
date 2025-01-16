import 'package:flutter/material.dart';

class AuthorField extends StatelessWidget {
  final TextEditingController controller;

  const AuthorField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Author',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        SearchAnchor.bar(
          barElevation: WidgetStatePropertyAll(0),
          barShape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          barLeading: Icon(Icons.person),
          barHintText: 'Select author',
          suggestionsBuilder: (context, searchController) {
            return [Text('data')];
          },
        ),
      ],
    );
  }
}
