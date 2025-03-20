import 'package:flutter/material.dart';

/// Defines the sorting options for book.
enum BookSort {
  title,
  releaseDate,
  totalCopies,
  issuedCopies,
  dateAdded,
  dateModified;

  /// Provides user-friendly string representation of the enum.
  String get prettify {
    switch (this) {
      case BookSort.title:
        return 'Title';
      case BookSort.releaseDate:
        return 'Release Date';
      case BookSort.totalCopies:
        return 'Total Copies';
      case BookSort.issuedCopies:
        return 'Issued Copies';
      case BookSort.dateAdded:
        return 'Date Added';
      case BookSort.dateModified:
        return 'Date Modified';
    }
  }

  /// Provides relevant icons corresponding to the enum.
  IconData get icon {
    switch (this) {
      case BookSort.title:
        return Icons.title;
      case BookSort.releaseDate:
        return Icons.calendar_today;
      case BookSort.totalCopies:
        return Icons.book;
      case BookSort.issuedCopies:
        return Icons.bookmark;
      case BookSort.dateAdded:
        return Icons.date_range;
      case BookSort.dateModified:
        return Icons.update;
    }
  }
}
