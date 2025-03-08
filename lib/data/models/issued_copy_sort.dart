import 'package:flutter/material.dart';

enum IssuedCopySort {
  issueDate,
  returnDate;

  String get prettify {
    switch (this) {
      case IssuedCopySort.issueDate:
        return 'Issue Date';
      case IssuedCopySort.returnDate:
        return 'Return Date';
    }
  }

  IconData get icon {
    switch (this) {
      case IssuedCopySort.issueDate:
        return Icons.date_range;
      case IssuedCopySort.returnDate:
        return Icons.handshake_rounded;
    }
  }
}
