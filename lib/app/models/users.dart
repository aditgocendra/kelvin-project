import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String role;
  String password;
  List<String>? searchKeyword;
  Timestamp createdAt;
  String? idDocument;

  UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.password,
    this.searchKeyword,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      username: data?['username'],
      email: data?['email'],
      role: data?['role'],
      password: data?['password'],
      createdAt: data?['createdAt'],
      searchKeyword: data?['searchKeyword'] is Iterable
          ? List.from(data?['searchKeyword'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "email": email,
      "role": role,
      "password": password,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }
}
