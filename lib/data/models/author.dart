import 'package:isar/isar.dart';
import 'package:libertad/data/models/book.dart';

part 'author.g.dart';

@collection
class Author {
  Id id = Isar.autoIncrement;
  final String name;
  final String bio;
  @Backlink(to: 'author')
  final IsarLinks<Book> books = IsarLinks<Book>();

  Author({
    required this.name,
    required this.bio,
  });

  Author copyWith({
    String? name,
    String? bio,
  }) =>
      Author(
        name: name ?? this.name,
        bio: bio ?? this.bio,
      );
}
