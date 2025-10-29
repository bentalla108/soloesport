import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
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
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      isAdmin: json['isAdmin'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      lastLogin: (json['lastLogin'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'isAdmin': isAdmin,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
