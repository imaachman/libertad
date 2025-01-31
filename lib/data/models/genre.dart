enum Genre {
  fiction,
  nonFiction,
  scienceFiction,
  historicalFiction,
  classic,
  romance,
  fantasy,
  adventure,
  dystopian,
  postApocalyptic,
  memoir;

  String get name {
    switch (this) {
      case Genre.fiction:
        return 'Fiction';
      case Genre.nonFiction:
        return 'Non-Fiction';
      case Genre.scienceFiction:
        return 'Science Fiction';
      case Genre.historicalFiction:
        return 'Historical Fiction';
      case Genre.classic:
        return 'Classic';
      case Genre.romance:
        return 'Romance';
      case Genre.fantasy:
        return 'Fantasy';
      case Genre.adventure:
        return 'Adventure';
      case Genre.dystopian:
        return 'Dystopian';
      case Genre.postApocalyptic:
        return 'Post-Apocalyptic';
      case Genre.memoir:
        return 'Memoir';
    }
  }
}
