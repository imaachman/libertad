import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows defining the total copies range to filter the books by.
class TotalCopiesFilterTile extends ConsumerWidget {
  /// Controllers for min and max total copies input fields.
  final TextEditingController minController;
  final TextEditingController maxController;

  const TotalCopiesFilterTile({
    super.key,
    required this.minController,
    required this.maxController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    // Set the initial values of the text fields. We add the empty check to
    // avoid setting the values redundantly.
    if (minController.text.isEmpty) {
      minController.text = model.minCopiesFilter?.toString() ?? '';
    }
    if (maxController.text.isEmpty) {
      maxController.text = model.maxCopiesFilter?.toString() ?? '';
    }

    return FilterTile(
      name: 'Total Copies',
      expanded: model.minCopiesFilter != null || model.maxCopiesFilter != null,
      field: Row(
        children: [
          SizedBox(
            width: 96,
            child: TextFormField(
              controller: minController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                errorMaxLines: 2,
                prefixIcon: Icon(
                  Icons.my_library_books_rounded,
                  size: 20,
                ),
                hintText: 'min.',
              ),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: model.minCopiesFilterValidator,
              onChanged: model.setMinCopiesFilter,
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 96,
            child: TextFormField(
              controller: maxController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                errorMaxLines: 2,
                prefixIcon: Icon(
                  Icons.my_library_books_rounded,
                  size: 20,
                ),
                hintText: 'max.',
              ),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: model.maxCopiesFilterValidator,
              onChanged: model.setMaxCopiesFilter,
            ),
          ),
        ],
      ),
      clearFilter: () =>
          model.clearTotalCopiesFilter(minController, maxController),
    );
  }
}
