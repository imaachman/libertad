enum ImageFolder {
  bookCovers,
  authorProfilePictures,
  borrowerProfilePictures;

  String get prettify {
    switch (this) {
      case ImageFolder.bookCovers:
        return 'Book Covers';
      case ImageFolder.authorProfilePictures:
        return 'Author Profile Pictures';
      case ImageFolder.borrowerProfilePictures:
        return 'Borrower Profile Pictures';
    }
  }
}
