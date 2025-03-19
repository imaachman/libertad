import 'author.dart';
import 'genre.dart';
import 'issue_status.dart';

class BookFilters {
  final Genre? genreFilter;
  final Author? authorFilter;
  final DateTime? oldestReleaseDateFilter;
  final DateTime? newestReleaseDateFilter;
  final IssueStatus? issueStatusFilter;
  final int? minCopiesFilter;
  final int? maxCopiesFilter;

  const BookFilters({
    this.genreFilter,
    this.authorFilter,
    this.oldestReleaseDateFilter,
    this.newestReleaseDateFilter,
    this.issueStatusFilter,
    this.minCopiesFilter,
    this.maxCopiesFilter,
  });
}
