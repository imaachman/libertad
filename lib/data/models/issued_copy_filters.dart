import 'book.dart';
import 'borrower.dart';

/// Contains all the filter options for the issued book copy.
class IssuedCopyFilters {
  final Book? bookFilter;
  final Borrower? borrowerFilter;
  final bool? overdueFilter;
  final DateTime? oldestIssueDateFilter;
  final DateTime? newestIssueDateFilter;
  final DateTime? oldestReturnDateFilter;
  final DateTime? newestReturnDateFilter;

  const IssuedCopyFilters({
    this.bookFilter,
    this.borrowerFilter,
    this.overdueFilter,
    this.oldestIssueDateFilter,
    this.newestIssueDateFilter,
    this.oldestReturnDateFilter,
    this.newestReturnDateFilter,
  });
}
