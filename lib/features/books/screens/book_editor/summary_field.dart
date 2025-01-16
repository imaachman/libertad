import 'package:flutter/material.dart';

class SummaryField extends StatelessWidget {
  final TextEditingController controller;

  const SummaryField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter book\'s summary',
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
        ),
      ],
    );
  }
}
