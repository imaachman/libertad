import 'package:isar/isar.dart';

part 'author.g.dart';

@collection
class Author {
  final Id id = Isar.autoIncrement;
  final String name;
  final String bio;
  final List<String> books;

  Author({
    required this.name,
    required this.bio,
    required this.books,
  });
}
