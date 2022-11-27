import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// Note : All stock is obtained from the sum of all product variants
class ProductModel {
  String productName;
  String idCategory;
  int price;

  int sold;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  ProductModel({
    required this.productName,
    required this.price,
    required this.idCategory,
    required this.sold,
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
      sold: data?['sold'],
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
      "sold": sold,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return NumberFormat.currency(
          locale: 'id',
          symbol: 'Rp. ',
          decimalDigits: 0,
        ).format(price);
      // case 2:
      //   return '$allStock Unit';
      default:
        return '';
    }
  }
}

class ProductReportModel {
  String productName;
  String idCategory;
  int price;
  int stock;
  int sold;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  ProductReportModel({
    required this.productName,
    required this.price,
    required this.stock,
    required this.idCategory,
    required this.sold,
    required this.createdAt,
    required this.searchKeyword,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return DateFormat('dd/mm/y', 'id').format(createdAt.toDate());
      case 1:
        return productName;
      case 2:
        return NumberFormat.currency(
          locale: 'id',
          symbol: 'Rp. ',
          decimalDigits: 0,
        ).format(price);
      case 3:
        return '$stock Unit';

      default:
        return '';
    }
  }
}

// final productData = [
//   ProductModel(
//     productName: '3 Seconds Bundle',
//     price: 50000,
//     allStock: 80,
//     sold: 0,
//     idCategory: 'Bundaran',
//     searchKeyword: ['3', 'Seconds'],
//     createdAt: Timestamp.now(),
//   ),
//   ProductModel(
//     productName: 'Tersesiuds',
//     price: 50000,
//     allStock: 80,
//     sold: 0,
//     idCategory: 'Baju Tidur',
//     searchKeyword: ['3', 'Seconds'],
//     createdAt: Timestamp.now(),
//   ),
//   ProductModel(
//     productName: 'Black Market',
//     price: 50000,
//     allStock: 80,
//     sold: 0,
//     idCategory: 'Baju Main',
//     searchKeyword: ['3', 'Seconds'],
//     createdAt: Timestamp.now(),
//   ),
//   ProductModel(
//     productName: 'Ntah Apa ini',
//     price: 50000,
//     allStock: 80,
//     sold: 0,
//     idCategory: 'Apa tah apa',
//     searchKeyword: ['3', 'Seconds'],
//     createdAt: Timestamp.now(),
//   ),
//   ProductModel(
//     productName: 'Ntah Apa ini',
//     price: 50000,
//     allStock: 80,
//     sold: 0,
//     idCategory: 'Ntah',
//     searchKeyword: ['3', 'Seconds'],
//     createdAt: Timestamp.now(),
//   )
// ];
