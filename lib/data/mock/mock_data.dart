import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/genre.dart';

class MockData {
  /// Mock books data.
  static final books = [
    Book(
      title: 'To Kill a Mockingbird',
      // author: 'Harper Lee',
      genre: Genre.fiction,
      releaseDate: DateTime(1960, 7, 11),
      summary:
          'A gripping, heart-wrenching tale of racial injustice and childhood innocence in the Deep South.',
      coverImage: '',
      // totalCopies: 10,
      // issuedCopies: 4,
    ),
    Book(
      title: '1984',
      // author: 'George Orwell',
      genre: Genre.dystopian,
      releaseDate: DateTime(1949, 6, 8),
      summary:
          'A haunting depiction of a dystopian future under a totalitarian regime.',
      coverImage: '',
      // totalCopies: 15,
      // issuedCopies: 10,
    ),
    Book(
      title: 'The Great Gatsby',
      // author: 'F. Scott Fitzgerald',
      genre: Genre.classic,
      releaseDate: DateTime(1925, 4, 10),
      summary:
          'A story of the Jazz Age, exploring themes of wealth, love, and the American Dream.',
      coverImage: '',
      // totalCopies: 8,
      // issuedCopies: 3,
    ),
    Book(
      title: 'The Catcher in the Rye',
      // author: 'J.D. Salinger',
      genre: Genre.fiction,
      releaseDate: DateTime(1951, 7, 16),
      summary:
          'The journey of a disenchanted teenager grappling with the loss of innocence and societal norms.',
      coverImage: '',
      // totalCopies: 12,
      // issuedCopies: 7,
    ),
    Book(
      title: 'Pride and Prejudice',
      // author: 'Jane Austen',
      genre: Genre.romance,
      releaseDate: DateTime(1813, 1, 28),
      summary:
          'A classic tale of love and misunderstandings set in the English countryside.',
      coverImage: '',
      // totalCopies: 6,
      // issuedCopies: 2,
    ),
    Book(
      title: 'The Hobbit',
      // author: 'J.R.R. Tolkien',
      genre: Genre.fantasy,
      releaseDate: DateTime(1937, 9, 21),
      summary:
          'A fantastical journey of Bilbo Baggins, who ventures into the unknown to help reclaim a lost kingdom.',
      coverImage: '',
      // totalCopies: 9,
      // issuedCopies: 5,
    ),
    Book(
      title: 'The Alchemist',
      // author: 'Paulo Coelho',
      genre: Genre.adventure,
      releaseDate: DateTime(1988, 1, 1),
      summary: 'A mystical tale of self-discovery and following one\'s dreams.',
      coverImage: '',
      // totalCopies: 11,
      // issuedCopies: 6,
    ),
    Book(
      title: 'The Road',
      // author: 'Cormac McCarthy',
      genre: Genre.postApocalyptic,
      releaseDate: DateTime(2006, 9, 26),
      summary:
          'A bleak yet profound journey of a father and son through a devastated landscape.',
      coverImage: '',
      // totalCopies: 7,
      // issuedCopies: 4,
    ),
    Book(
      title: 'Sapiens: A Brief History of Humankind',
      // author: 'Yuval Noah Harari',
      genre: Genre.nonFiction,
      releaseDate: DateTime(2011, 2, 4),
      summary:
          'A deep dive into the history of humankind, exploring how we shaped the world.',
      coverImage: '',
      // totalCopies: 10,
      // issuedCopies: 8,
    ),
    Book(
      title: 'Harry Potter and the Philosopher\'s Stone',
      // author: 'J.K. Rowling',
      genre: Genre.fantasy,
      releaseDate: DateTime(1997, 6, 26),
      summary: 'The magical story of a young wizard discovering his destiny.',
      coverImage: '',
      // totalCopies: 20,
      // issuedCopies: 18,
    ),
    Book(
      title: 'The Book Thief',
      // author: 'Markus Zusak',
      genre: Genre.historicalFiction,
      releaseDate: DateTime(2005, 3, 14),
      summary: 'A poignant story narrated by Death, set during World War II.',
      coverImage: '',
      // totalCopies: 9,
      // issuedCopies: 5,
    ),
    Book(
      title: 'The Fault in Our Stars',
      // author: 'John Green',
      genre: Genre.romance,
      releaseDate: DateTime(2012, 1, 10),
      summary:
          'A heartbreaking yet uplifting story of two teens with cancer falling in love.',
      coverImage: '',
      // totalCopies: 14,
      // issuedCopies: 9,
    ),
    Book(
      title: 'Dune',
      // author: 'Frank Herbert',
      genre: Genre.scienceFiction,
      releaseDate: DateTime(1965, 8, 1),
      summary:
          'An epic tale of politics, religion, and power in a desert world.',
      coverImage: '',
      // totalCopies: 13,
      // issuedCopies: 10,
    ),
    Book(
      title: 'Becoming',
      // author: 'Michelle Obama',
      genre: Genre.memoir,
      releaseDate: DateTime(2018, 11, 13),
      summary:
          'A powerful and inspiring memoir from the former First Lady of the United States.',
      coverImage: '',
      // totalCopies: 12,
      // issuedCopies: 7,
    ),
    Book(
      title: 'The Midnight Library',
      // author: 'Matt Haig',
      genre: Genre.fantasy,
      releaseDate: DateTime(2020, 8, 13),
      summary:
          'A whimsical exploration of alternate lives through a library between life and death.',
      coverImage: '',
      // totalCopies: 11,
      // issuedCopies: 6,
    ),
  ];

  /// Mock authors data.
  static final List<Author> authors = [
    Author(
      name: 'Harper Lee',
      bio:
          'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird".',
      // books: ['To Kill a Mockingbird'],
    ),
    Author(
      name: 'George Orwell',
      bio:
          'George Orwell was an English novelist and essayist, known for his works exploring themes of social injustice and totalitarianism.',
      // books: ['1984'],
    ),
    Author(
      name: 'F. Scott Fitzgerald',
      bio:
          'F. Scott Fitzgerald was an American novelist, widely regarded as one of the greatest American writers of the 20th century.',
      // books: ['The Great Gatsby'],
    ),
    Author(
      name: 'J.D. Salinger',
      bio:
          'J.D. Salinger was an American writer known for his critically acclaimed novel "The Catcher in the Rye".',
      // books: ['The Catcher in the Rye'],
    ),
    Author(
      name: 'Jane Austen',
      bio:
          'Jane Austen was an English novelist known for her six major novels, including "Pride and Prejudice".',
      // books: ['Pride and Prejudice'],
    ),
    Author(
      name: 'J.R.R. Tolkien',
      bio:
          'J.R.R. Tolkien was an English writer, poet, and academic, best known for his high-fantasy works including "The Hobbit".',
      // books: ['The Hobbit'],
    ),
    Author(
      name: 'Paulo Coelho',
      bio:
          'Paulo Coelho is a Brazilian lyricist and novelist, best known for his international bestseller "The Alchemist".',
      // books: ['The Alchemist'],
    ),
    Author(
      name: 'Cormac McCarthy',
      bio:
          'Cormac McCarthy was an American novelist and playwright, known for his sparse writing style and powerful stories.',
      // books: ['The Road'],
    ),
    Author(
      name: 'Yuval Noah Harari',
      bio:
          'Yuval Noah Harari is an Israeli historian and professor, best known for his groundbreaking work "Sapiens".',
      // books: ['Sapiens: A Brief History of Humankind'],
    ),
    Author(
      name: 'J.K. Rowling',
      bio:
          'J.K. Rowling is a British author, best known for creating the magical world of Harry Potter.',
      // books: ['Harry Potter and the Philosopher\'s Stone'],
    ),
    Author(
      name: 'Markus Zusak',
      bio:
          'Markus Zusak is an Australian author, best known for his international bestseller "The Book Thief".',
      // books: ['The Book Thief'],
    ),
    Author(
      name: 'John Green',
      bio:
          'John Green is an American author, widely acclaimed for his young adult novels, including "The Fault in Our Stars".',
      // books: ['The Fault in Our Stars'],
    ),
    Author(
      name: 'Frank Herbert',
      bio:
          'Frank Herbert was an American science fiction author, best known for his epic novel "Dune".',
      // books: ['Dune'],
    ),
    Author(
      name: 'Michelle Obama',
      bio:
          'Michelle Obama is an American attorney, author, and former First Lady of the United States.',
      // books: ['Becoming'],
    ),
    Author(
      name: 'Matt Haig',
      bio:
          'Matt Haig is a British author and journalist, known for his works of fiction and non-fiction, including "The Midnight Library".',
      // books: ['The Midnight Library'],
    ),
  ];

  /// Mock borrowers data.
  static final List<Borrower> borrowers = [
    Borrower(
      name: 'Michael Johnson',
      contact: '4155551023',
      membershipStartDate: DateTime(2024, 9, 12),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Sophia Martinez',
      contact: '2135557845',
      membershipStartDate: DateTime(2023, 1, 10),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Liam O\'Connor',
      contact: '6465556734',
      membershipStartDate: DateTime(2024, 6, 1),
      membershipDuration: 18,
    ),
    Borrower(
      name: 'Aiko Tanaka',
      contact: '5105558942',
      membershipStartDate: DateTime(2024, 11, 15),
      membershipDuration: 6,
    ),
    Borrower(
      name: 'Carlos Mendes',
      contact: '3055553281',
      membershipStartDate: DateTime(2022, 6, 20),
      membershipDuration: 6,
    ),
    Borrower(
      name: 'Emma Becker',
      contact: '7205556493',
      membershipStartDate: DateTime(2025, 1, 5),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Javier Rodríguez',
      contact: '7025559956',
      membershipStartDate: DateTime(2023, 5, 8),
      membershipDuration: 6,
    ),
    Borrower(
      name: 'Fatima Hassan',
      contact: '3125554378',
      membershipStartDate: DateTime(2024, 7, 22),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Ethan Williams',
      contact: '8185552094',
      membershipStartDate: DateTime(2024, 8, 15),
      membershipDuration: 10,
    ),
    Borrower(
      name: 'Isla MacKenzie',
      contact: '4155557782',
      membershipStartDate: DateTime(2023, 4, 10),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Abdul Rahman',
      contact: '6465551123',
      membershipStartDate: DateTime(2024, 2, 14),
      membershipDuration: 24,
    ),
    Borrower(
      name: 'Samantha Cohen',
      contact: '2025553654',
      membershipStartDate: DateTime(2024, 10, 1),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Dmitri Ivanov',
      contact: '2125558410',
      membershipStartDate: DateTime(2020, 3, 5),
      membershipDuration: 12,
    ),
    Borrower(
      name: 'Linda Berg',
      contact: '4145556279',
      membershipStartDate: DateTime(2025, 2, 1),
      membershipDuration: 18,
    ),
    Borrower(
      name: 'Marco Rossi',
      contact: '3105559981',
      membershipStartDate: DateTime(2023, 6, 17),
      membershipDuration: 6,
    ),
  ];
}
