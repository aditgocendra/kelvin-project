import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelvin_project/app/models/category.dart';
import 'package:kelvin_project/app/models/detail_transaction.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/app/models/stock_product.dart';
import 'package:kelvin_project/app/models/transaction.dart';
import 'package:kelvin_project/app/models/users.dart';
import 'package:kelvin_project/app/models/variant_product.dart';

abstract class FirestoreService {
  static var timeStamp = Timestamp.now();

  // Reference Collection Path Data
  static final refCategory = FirebaseFirestore.instance
      .collection('category')
      .withConverter(
          fromFirestore: CategoryModel.fromFirestore,
          toFirestore: (CategoryModel ctgModel, options) =>
              ctgModel.toFirestore());

  static final refProduct = FirebaseFirestore.instance
      .collection('products')
      .withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel productModel, options) =>
              productModel.toFirestore());

  static final refTransaction = FirebaseFirestore.instance
      .collection('transactions')
      .withConverter<TransactionModel>(
          fromFirestore: (snapshot, _) =>
              TransactionModel.fromJson(snapshot.data()!),
          toFirestore: (ctg, _) => ctg.toJson());

  static final refUsers = FirebaseFirestore.instance
      .collection('users')
      .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFirestore());

  // Reference Sub Collection
  static CollectionReference refSubCollectionStockProduct({
    required String idDoc,
    required String collection,
    required String subCollectionPath,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(idDoc)
        .collection(subCollectionPath)
        .withConverter<StockProductModel>(
            fromFirestore: StockProductModel.fromFirestore,
            toFirestore: (StockProductModel stockProductModel, options) =>
                stockProductModel.toFirestore());
  }

  // Reference Sub Collection
  static CollectionReference refSubCollectionProduct({
    required String idDoc,
    required String collection,
    required String subCollectionPath,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(idDoc)
        .collection(subCollectionPath)
        .withConverter<VariantProductModel>(
            fromFirestore: (snapshot, _) =>
                VariantProductModel.fromJson(snapshot.data()!),
            toFirestore: (ctg, _) => ctg.toJson());
  }

  static CollectionReference<DetailTransactionModel>
      refSubCollectionDetailTransaction({
    required String idDoc,
    required String collection,
    required String subCollectionPath,
  }) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(idDoc)
        .collection(subCollectionPath)
        .withConverter(
            fromFirestore: DetailTransactionModel.fromFirestore,
            toFirestore:
                (DetailTransactionModel detailTransactionModel, options) =>
                    detailTransactionModel.toFirestore());
  }
}
