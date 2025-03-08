enum BorrowerSort {
  name,
  membershipStartDate,
  dateCreated,
  dateModified;

  String get prettify {
    switch (this) {
      case BorrowerSort.name:
        return 'Name';
      case BorrowerSort.membershipStartDate:
        return 'Membership Start Date';
      case BorrowerSort.dateCreated:
        return 'Date Created';
      case BorrowerSort.dateModified:
        return 'Date Modified';
    }
  }
}
