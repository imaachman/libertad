import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/authors/screens/author_details_screen/author_details_screen.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/copy_details_screen.dart';
import 'package:libertad/features/books/screens/book_details_screen/book_details_screen.dart';
import 'package:libertad/features/borrowers/screens/borrower_details_screen/borrower_details_screen.dart';
import 'package:libertad/features/home/screens/home_screen.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/splash_screen.dart';

class RouteGenerator {
  static Route? generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case Routes.book:
        return MaterialPageRoute(
            builder: (context) =>
                BookDetailsPage(book: settings.arguments as Book));
      case Routes.author:
        return MaterialPageRoute(
            builder: (context) =>
                AuthorDetailsPage(author: settings.arguments as Author));
      case Routes.borrower:
        return MaterialPageRoute(
            builder: (context) =>
                BorrowerDetailsPage(borrower: settings.arguments as Borrower));
      case Routes.bookCopy:
        return MaterialPageRoute(
            builder: (context) =>
                CopyDetailsPage(copy: settings.arguments as BookCopy));
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
