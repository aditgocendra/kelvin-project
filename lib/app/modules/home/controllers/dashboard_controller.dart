import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';
import 'package:unicons/unicons.dart';

class DashboardController extends GetxController {
  List<Map<String, dynamic>> listDashboardMenu = [
    {
      'title': 'Total Produk',
      'icon': UniconsLine.archive_alt,
      'value': 0,
      'last_update': ''
    },
    {
      'title': 'Total Kategori',
      'icon': UniconsLine.clipboard_notes,
      'value': 0,
      'last_update': ''
    },
    {
      'title': 'Total Pengguna',
      'icon': UniconsLine.users_alt,
      'value': 0,
      'last_update': ''
    },
    {
      'title': 'Total Transaksi',
      'icon': UniconsLine.transaction,
      'value': 0,
      'last_update': ''
    }
  ];

  List<ProductModel> listNewProduct = [];
  List<ProductModel> listSoldProduct = [];
  List<ProductModel> listStockProduct = [];

  // Product Data
  void streamAllProductData() {
    FirestoreService.refProduct
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      final product = event.docs[0];

      // Set Product
      listDashboardMenu[0]['value'] = event.docs.length;
      listDashboardMenu[0]['last_update'] =
          DateFormat('d MMM y').format(product['createdAt'].toDate());

      update();
    });
  }

  void streamNewProductData() {
    FirestoreService.refProduct
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots()
        .listen((event) {
      // Set Product
      for (var doc in event.docs) {
        final product = ProductModel(
          productName: doc['productName'],
          price: doc['price'],
          allStock: doc['allStock'],
          idCategory: doc['idCategory'],
          sold: doc['sold'],
          createdAt: doc['createdAt'],
          searchKeyword: List<String>.from(
            doc['searchKeyword'],
          ),
        );
        listNewProduct.add(product);
      }
      update();
    });
  }

  void streamStockProductData() {
    FirestoreService.refProduct
        .orderBy('allStock')
        .limit(5)
        .snapshots()
        .listen((event) {
      // Set Product
      for (var doc in event.docs) {
        final product = ProductModel(
          productName: doc['productName'],
          price: doc['price'],
          allStock: doc['allStock'],
          idCategory: doc['idCategory'],
          sold: doc['sold'],
          createdAt: doc['createdAt'],
          searchKeyword: List<String>.from(
            doc['searchKeyword'],
          ),
        );
        listStockProduct.add(product);
      }
      update();
    });
  }

  void streamSoldkProductData() {
    FirestoreService.refProduct
        .orderBy('sold', descending: true)
        .limit(5)
        .snapshots()
        .listen((event) {
      // Set Product
      for (var doc in event.docs) {
        final product = ProductModel(
          productName: doc['productName'],
          price: doc['price'],
          allStock: doc['allStock'],
          idCategory: doc['idCategory'],
          sold: doc['sold'],
          createdAt: doc['createdAt'],
          searchKeyword: List<String>.from(
            doc['searchKeyword'],
          ),
        );
        listSoldProduct.add(product);
      }
      update();
    });
  }

  // Category Data
  void streamAllCategoryData() {
    FirestoreService.refCategory
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      final category = event.docs[0];
      // Set Category
      listDashboardMenu[1]['value'] = event.docs.length;
      listDashboardMenu[1]['last_update'] =
          DateFormat('d MMM y').format(category['createdAt'].toDate());
      update();
    });
  }

  // User Data
  void streamAllUserData() {
    FirestoreService.refUsers
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      final user = event.docs[0];
      // Set User
      listDashboardMenu[2]['value'] = event.docs.length;
      listDashboardMenu[2]['last_update'] =
          DateFormat('d MMM y').format(user['createdAt'].toDate());
      update();
    });
  }

  // Transaction Data
  void streamAllTransactionData() {
    FirestoreService.refTransaction
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      final transaction = event.docs[0];
      // Set Transaction
      listDashboardMenu[3]['value'] = event.docs.length;
      listDashboardMenu[3]['last_update'] =
          DateFormat('d MMM y').format(transaction['createdAt'].toDate());
      update();
    });
  }

  @override
  void onInit() {
    // Stream Product
    streamAllProductData();
    streamNewProductData();
    streamStockProductData();
    streamSoldkProductData();

    // Stream Category
    streamAllCategoryData();

    // Stream User
    streamAllUserData();

    // Stream Transaction
    streamAllTransactionData();

    super.onInit();
  }
}
