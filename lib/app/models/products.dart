import 'package:cloud_firestore/cloud_firestore.dart';

// Note : All stock is obtained from the sum of all product variants
class ProductModel {
  String productName;
  String idCategory;
  int price;
  int allStock;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  ProductModel({
    required this.productName,
    required this.price,
    required this.allStock,
    required this.idCategory,
    required this.createdAt,
    required this.searchKeyword,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      productName: data?['productName'],
      idCategory: data?['idCategory'],
      price: data?['price'],
      allStock: data?['allStock'],
      createdAt: data?['createdAt'],
      searchKeyword: data?['searchKeyword'] is Iterable
          ? List.from(data?['searchKeyword'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "productName": productName,
      "idCategory": idCategory,
      "price": price,
      "allStock": allStock,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }

  // ProductModel.fromJson(Map<String, Object?> json)
  //     : this(
  //         productName: json['name']! as String,
  //         idCategory: json['idCategory']! as String,
  //         price: json['price']! as int,
  //         allStock: json['allStock']! as int,
  //         createdAt: json['createdAt']! as Timestamp,

  //       );

  // Map<String, Object?> toJson() {
  //   return {
  //     'productName': productName,
  //     'price': price,
  //     'allStock': allStock,
  //     'idCategory': idCategory,
  //     'createdAt': createdAt,
  //   };
  // }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return idCategory;
      case 2:
        return price.toString();
      case 3:
        return allStock.toString();
      default:
        return '';
    }
  }
}

final productData = [
  ProductModel(
    productName: '3 Seconds Bundle',
    price: 50000,
    allStock: 80,
    idCategory: 'Bundaran',
    searchKeyword: ['3', 'Seconds'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'Tersesiuds',
    price: 50000,
    allStock: 80,
    idCategory: 'Baju Tidur',
    searchKeyword: ['3', 'Seconds'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'Black Market',
    price: 50000,
    allStock: 80,
    idCategory: 'Baju Main',
    searchKeyword: ['3', 'Seconds'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'Ntah Apa ini',
    price: 50000,
    allStock: 80,
    idCategory: 'Apa tah apa',
    searchKeyword: ['3', 'Seconds'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'Ntah Apa ini',
    price: 50000,
    allStock: 80,
    idCategory: 'Ntah',
    searchKeyword: ['3', 'Seconds'],
    createdAt: Timestamp.now(),
  )
];
