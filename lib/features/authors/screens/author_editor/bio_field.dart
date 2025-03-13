import 'package:flutter/material.dart';

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
