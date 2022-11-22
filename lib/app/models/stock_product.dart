import 'package:cloud_firestore/cloud_firestore.dart';

class StockProductModel {
  int stock;
  Timestamp createdAt;
  String? idProduct;

  StockProductModel({
    required this.stock,
    required this.createdAt,
  });

  factory StockProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StockProductModel(
      stock: data?['stock'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "stock": stock,
      "createdAt": createdAt,
    };
  }
}
