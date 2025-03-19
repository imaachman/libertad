class BorrowerFilters {
  final bool? activeFilter;
  final bool? defaulterFilter;
  final DateTime? oldestMembershipStartDateFilter;
  final DateTime? newestMembershipStartDateFilter;

  const BorrowerFilters({
    this.activeFilter,
    this.defaulterFilter,
    this.oldestMembershipStartDateFilter,
    this.newestMembershipStartDateFilter,
  });
}
