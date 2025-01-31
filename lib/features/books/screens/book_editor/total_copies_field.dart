import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class TotalCopiesField extends ConsumerWidget {
  const TotalCopiesField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Copies',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: ref
                .watch(bookEditorViewModelProvider().notifier)
                .totalCopies
                .toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              errorMaxLines: 2,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: ref
                .read(bookEditorViewModelProvider().notifier)
                .validateTotalCopies,
            onChanged:
                ref.read(bookEditorViewModelProvider().notifier).setTotalCopies,
          ),
        ),
      ],
    );
  }
}
