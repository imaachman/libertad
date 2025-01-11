class AuthorModel {
  final String id;
  final String name;
  final String bio;
  final List<String> books;

  AuthorModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.books,
  });
}
