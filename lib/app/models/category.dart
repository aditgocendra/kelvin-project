import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  CategoryModel({
    required this.name,
    required this.createdAt,
    this.searchKeyword,
  });

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CategoryModel(
      name: data?['name'],
      createdAt: data?['createdAt'],
      searchKeyword: data?['searchKeyword'] is Iterable
          ? List.from(data?['searchKeyword'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }

  String ctgAsString() {
    return name;
  }

  bool isEqual(CategoryModel model) {
    return idDocument == model.idDocument;
  }
}
