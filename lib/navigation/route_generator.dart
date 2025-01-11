import 'package:flutter/material.dart';
import 'package:libertad/features/books/screens/book_details_screen.dart';
import 'package:libertad/features/home/home_screen.dart';
import 'package:libertad/navigation/routes.dart';

class RouteGenerator {
  static Route? generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case Routes.book:
        return MaterialPageRoute(builder: (context) => const BookDetailsPage());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
