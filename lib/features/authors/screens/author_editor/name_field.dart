import 'package:flutter/material.dart';

/// Text field to enter author's name.
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
