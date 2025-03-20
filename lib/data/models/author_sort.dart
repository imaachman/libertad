import 'package:flutter/material.dart';

/// Defines the sorting options for author.
enum AuthorSort {
  name,
  dateAdded,
  dateModified;

  /// Provides user-friendly string representation of the enum.
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

  /// Provides relevant icons corresponding to the enum.
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
