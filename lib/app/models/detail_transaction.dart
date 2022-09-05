import 'package:cloud_firestore/cloud_firestore.dart';

class DetailTransactionModel {
  String productName;
  int price;
  List<String>? variant;
  String? idDocument;

  DetailTransactionModel({
    required this.productName,
    required this.price,
    this.variant,
  });

  factory DetailTransactionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DetailTransactionModel(
      productName: data?['productName'],
      price: data?['price'],
      variant:
          data?['variant'] is Iterable ? List.from(data?['variant']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "productName": productName,
      "price": price,
      if (variant != null) "variant": variant,
    };
  }
}
