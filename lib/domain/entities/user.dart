import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime lastLogin;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.isAdmin = false,
    required this.createdAt,
    required this.lastLogin,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phoneNumber,
    profileImageUrl,
    isAdmin,
    createdAt,
    lastLogin,
  ];
}
