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
}
