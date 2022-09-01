import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  Timestamp createdAt;
  String? idDocument;

  CategoryModel({
    required this.name,
    required this.createdAt,
  });

  CategoryModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          createdAt: json['createdAt']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'createdAt': createdAt,
    };
  }
}
