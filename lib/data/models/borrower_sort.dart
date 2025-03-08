import 'package:flutter/material.dart';

enum BorrowerSort {
  name,
  membershipStartDate,
  dateAdded,
  dateModified;

  String get prettify {
    switch (this) {
      case BorrowerSort.name:
        return 'Name';
      case BorrowerSort.membershipStartDate:
        return 'Membership Start Date';
      case BorrowerSort.dateAdded:
        return 'Date Added';
      case BorrowerSort.dateModified:
        return 'Date Modified';
    }
  }

  IconData get icon {
    switch (this) {
      case BorrowerSort.name:
        return Icons.abc;
      case BorrowerSort.membershipStartDate:
        return Icons.calendar_today;
      case BorrowerSort.dateAdded:
        return Icons.date_range;
      case BorrowerSort.dateModified:
        return Icons.update;
    }
  }
}
