// lib/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    String? profileImageUrl,
    bool isAdmin = false,
    required DateTime createdAt,
    required DateTime lastLogin,
  }) : super(
         id: id,
         name: name,
         email: email,
         phoneNumber: phoneNumber,
         profileImageUrl: profileImageUrl,
         isAdmin: isAdmin,
         createdAt: createdAt,
         lastLogin: lastLogin,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profileImageUrl: json['profile_image_url'],
      isAdmin: json['is_admin'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      lastLogin: DateTime.parse(json['last_login']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'profile_image_url': profileImageUrl,
      'is_admin': isAdmin,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin.toIso8601String(),
    };
  }
}
