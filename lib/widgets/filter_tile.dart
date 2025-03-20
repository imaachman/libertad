import 'package:flutter/material.dart';

/// Expansion tile that contains a filter field and a button to clear the
/// filter.
class FilterTile extends StatelessWidget {
  final String name;
  final Widget field;
  final VoidCallback clearFilter;
  final bool expanded;

  const FilterTile({
    super.key,
    required this.name,
    required this.field,
    required this.clearFilter,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: expanded,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Filter by ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            TextSpan(
              text: name,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              field,
              IconButton(
                onPressed: clearFilter,
                icon: Icon(Icons.clear, size: 20),
                tooltip: 'Clear filter',
              ),
            ],
          ),
        )
      ],
    );
  }
}
