import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String role;
  String password;
  Timestamp createdAt;
  String? idDocument;

  UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.password,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          email: json['email']! as String,
          role: json['role']! as String,
          password: json['password']! as String,
          createdAt: json['createdAt']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role,
      'password': password,
      'createdAt': createdAt,
    };
  }
}
