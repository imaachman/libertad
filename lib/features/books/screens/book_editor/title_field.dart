import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;

  const TitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter book\'s title',
          ),
        ),
      ],
    );
  }
}
