import 'package:isar/isar.dart';
import 'package:libertad/data/models/book.dart';

part 'author.g.dart';

@collection
class Author {
  Id id = Isar.autoIncrement;
  @Index()
  String name;
  String bio;
  String profilePicture;
  @Backlink(to: 'author')
  final IsarLinks<Book> books = IsarLinks<Book>();
  @Index()
  late final DateTime createdAt;
  @Index()
  late DateTime updatedAt;

  Author({
    required this.name,
    required this.bio,
    this.profilePicture = '',
  });

  Author copyWith({
    String? name,
    String? bio,
    String? profilePicture,
  }) =>
      Author(
        name: name ?? this.name,
        bio: bio ?? this.bio,
        profilePicture: profilePicture ?? this.profilePicture,
      );
}
