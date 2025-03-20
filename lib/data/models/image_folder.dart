/// Defines the different folders where app's user-generated images are stored.
enum ImageFolder {
  bookCovers,
  authorProfilePictures,
  borrowerProfilePictures;

  /// Provides user-friendly string representation of the enum.
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
