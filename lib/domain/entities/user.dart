// lib/domain/entities/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.isAdmin = false,
    required this.createdAt,
    required this.lastLogin,
  });
}
