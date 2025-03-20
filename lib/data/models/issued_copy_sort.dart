import 'package:flutter/material.dart';

/// Defines the sorting options for issued book copy.
enum IssuedCopySort {
  issueDate,
  returnDate;

  /// Provides user-friendly string representation of the enum.
  String get prettify {
    switch (this) {
      case IssuedCopySort.issueDate:
        return 'Issue Date';
      case IssuedCopySort.returnDate:
        return 'Return Date';
    }
  }

  /// Provides relevant icons corresponding to the enum.
  IconData get icon {
    switch (this) {
      case IssuedCopySort.issueDate:
        return Icons.date_range;
      case IssuedCopySort.returnDate:
        return Icons.handshake_rounded;
    }
  }
}
