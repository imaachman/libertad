import 'package:flutter/material.dart';

enum AuthorSort {
  name,
  dateAdded,
  dateModified;

  String get prettify {
    switch (this) {
      case AuthorSort.name:
        return 'Name';
      case AuthorSort.dateAdded:
        return 'Date Added';
      case AuthorSort.dateModified:
        return 'Date Modified';
    }
  }

  IconData get icon {
    switch (this) {
      case AuthorSort.name:
        return Icons.abc;
      case AuthorSort.dateAdded:
        return Icons.date_range;
      case AuthorSort.dateModified:
        return Icons.update;
    }
  }
}
