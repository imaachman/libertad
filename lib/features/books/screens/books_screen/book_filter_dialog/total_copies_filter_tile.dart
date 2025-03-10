import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class TotalCopiesFilterTile extends ConsumerStatefulWidget {
  const TotalCopiesFilterTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TotalCopiesFilterTileState();
}

class _TotalCopiesFilterTileState extends ConsumerState<TotalCopiesFilterTile> {
  late final TextEditingController minController;
  late final TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController();
    maxController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    // Set the initial values of the text fields. We add the empty check to
    // avoid setting the values redundantly.
    if (minController.text.isEmpty) {
      minController.text = model.totalCopiesFilterMinMax.key?.toString() ?? '';
    }
    if (maxController.text.isEmpty) {
      maxController.text =
          model.totalCopiesFilterMinMax.value?.toString() ?? '';
    }

    return FilterTile(
      name: 'Total Copies',
      expanded: model.totalCopiesFilterMinMax.key != null ||
          model.totalCopiesFilterMinMax.value != null,
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
              validator: model.totalCopiesFilterMinValidator,
              onChanged: model.setTotalCopiesFilterMin,
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
              validator: model.totalCopiesFilterMaxValidator,
              onChanged: model.setTotalCopiesFilterMax,
            ),
          ),
        ],
      ),
      clearFilter: () =>
          model.clearTotalCopiesFilter(minController, maxController),
    );
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}
