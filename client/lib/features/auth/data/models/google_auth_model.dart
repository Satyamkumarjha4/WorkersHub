class GoogleAuthModel {
  final String name;
  final String email;
  final String avatar;
  final Role? role;

  const GoogleAuthModel({
    required this.name,
    required this.email,
    required this.avatar,
    this.role,
  });
}

enum Role { client, worker }
