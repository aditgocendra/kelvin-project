import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/detail_transaction.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/app/models/transaction.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';

class ManageTransactionController extends GetxController {
  // Loading
  final isLoadingGetProduct = false.obs;
  final isLoadingTableData = false.obs;

  // Total Payment
  final totalPay = 0.obs;

  final errorMessageForm = ''.obs;

  // Editing Controller
  TextEditingController codeProductTec = TextEditingController();

  // List Data
  List<Map<String, dynamic>> listProductForm = [];
  List<TransactionModel> listDataTable = [];

  // Dialog Detail Transaction Data
  final codeTrans = ''.obs;
  final totalPayTransDetail = 0.obs;
  List<DetailTransactionModel> listDetailTransDialog = [];

  // Read All Data Transaction
  Future<QuerySnapshot> readAllTransaction() async {
    return await FirestoreService.refTransaction.get();
  }

  // Set Dialog Detail Transaction
  Future setDialogDetailTransaction(TransactionModel transaction) async {
    codeTrans.value = transaction.idDocument!;
    totalPayTransDetail.value = transaction.totalPay;

    listDetailTransDialog.clear();

    final result = await FirestoreService.refSubCollectionDetailTransaction(
      collection: 'transactions',
      idDoc: codeTrans.value,
      subCollectionPath: 'detailTransaction',
    ).get();

    for (var doc in result.docs) {
      DetailTransactionModel detailTransactionModel = DetailTransactionModel(
        productName: doc['productName'],
        price: doc['price'],
        variant: List<String>.from(doc['variant']),
      );

      detailTransactionModel.idDocument = doc.id;
      listDetailTransDialog.add(detailTransactionModel);
    }

    update();
  }

  // Add Form Product
  Future addFormProduct() async {
    String codeProduct = codeProductTec.text.trim();
    errorMessageForm.value = '';
    if (codeProduct.isEmpty) {
      errorMessageForm.value = 'Form Kode Produk Masih Kosong';
      return;
    }

    if (listProductForm.isNotEmpty) {
      final productData = listProductForm
          .where((element) => element['product'].idDocument == codeProduct);
      if (productData.isNotEmpty) {
        errorMessageForm.value = 'Produk telah tersedia';
        return;
      }
    }

    isLoadingGetProduct.toggle();

    final resultProduct =
        await FirestoreService.refProduct.doc(codeProduct).get();

    if (!resultProduct.exists) {
      errorMessageForm.value = 'Produk Tidak Ditemukan';
      isLoadingGetProduct.toggle();
      return;
    }

    // Product Data
    ProductModel product = ProductModel(
      productName: resultProduct.get('productName'),
      price: resultProduct.get('price'),
      allStock: resultProduct.get('allStock'),
      idCategory: resultProduct.get('idCategory'),
      createdAt: resultProduct.get('createdAt'),
    );
    product.idDocument = codeProduct;

    // Get Variant Product
    final resultVariantProduct = await FirestoreService.refSubCollectionProduct(
            idDoc: codeProduct,
            collection: 'products',
            subCollectionPath: 'variant_product')
        .get();

    List<String> variantProduct = [];

    for (var doc in resultVariantProduct.docs) {
      variantProduct.add('${doc['color']} | ${doc['size']}');
    }

    // Add Form Product
    listProductForm.add({
      'product': product,
      'variantSelected': [
        '',
      ],
      'variantProduct': variantProduct,
    });

    updateTotalPay();

    codeProductTec.clear();

    isLoadingGetProduct.toggle();
    update();
  }

  // Create Trasaction
  Future createTransaction() async {
    if (listProductForm.isEmpty) {
      errorMessageForm.value = 'Belum Ada Satupun Produk';
      return;
    }

    if (!validationForm()) {
      errorMessageForm.value = 'Beberapa Form Variant Produk Masih Kosong';
      return;
    }

    String codeTransaction = generateCodeTransaction();

    TransactionModel transaction = TransactionModel(
      totalPay: totalPay.value,
      createdAt: Timestamp.now(),
    );

    await FirestoreService.refTransaction
        .doc(codeTransaction)
        .set(transaction)
        .then((value) async {
      transaction.idDocument = codeTransaction;
      listDataTable.add(transaction);

      for (var i = 0; i < listProductForm.length; i++) {
        ProductModel productModel = listProductForm[i]['product'];
        List<String> variantSelect = listProductForm[i]['variantSelected'];
        await setDetailTransaction(
          codeTransaction,
          productModel,
          variantSelect,
        );
      }
    }).catchError(
      (err) => print(err),
    );
  }

  // Set Detail Transaction
  Future setDetailTransaction(
    String codeTransaction,
    ProductModel product,
    List<String> variant,
  ) async {
    DetailTransactionModel detailTrans = DetailTransactionModel(
      productName: product.productName,
      price: product.price,
      variant: variant,
    );

    await FirestoreService.refSubCollectionDetailTransaction(
      collection: 'transactions',
      idDoc: codeTransaction,
      subCollectionPath: 'detailTransaction',
    ).doc(product.idDocument).set(detailTrans).then((value) {
      resetFormProduct();
      update();
      Get.back();
    }).catchError((err) => print(err));
  }

  // Delete Transaction
  Future deleteTransaction(String docId) async {
    final result = await FirestoreService.refSubCollectionDetailTransaction(
            idDoc: docId,
            collection: 'transactions',
            subCollectionPath: 'detailTransaction')
        .get();

    for (var doc in result.docs) {
      await doc.reference.delete();
    }

    await FirestoreService.refTransaction.doc(docId).delete().then((value) {
      listDataTable.removeWhere((trans) => trans.idDocument == docId);
      update();
      Get.back();
    }).catchError((err) => print(err));
  }

  // Validation Form Variant Product
  bool validationForm() {
    for (var i = 0; i < listProductForm.length; i++) {
      for (var j = 0; j < listProductForm[i]['variantSelected'].length; j++) {
        if (listProductForm[i]['variantSelected'][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  // Generate Code Transaction
  String generateCodeTransaction() {
    DateTime dateTimeNow = DateTime.now();
    String date = DateFormat.yMd().format(dateTimeNow).replaceAll('/', '-');
    String time = DateFormat.Hms().format(dateTimeNow).replaceAll(':', '-');

    return 'TR-KL-$date-$time';
  }

  // Update Total Payment
  void updateTotalPay() {
    if (listProductForm.isEmpty) {
      totalPay.value = 0;
      return;
    }

    double price = 0;

    for (var i = 0; i < listProductForm.length; i++) {
      price += listProductForm[i]['product'].price *
          listProductForm[i]['variantSelected'].length;
    }

    totalPay.value = price.toInt();
  }

  // Add Field Variant
  void addFieldVariant(int indexProduct) {
    final variantSelected = listProductForm[indexProduct]['variantSelected'];

    variantSelected.add('');
    listProductForm[indexProduct]['variantSelected'] = variantSelected;
    updateTotalPay();

    update();
  }

  // Remove Field Variant
  void removeFieldVariant(int indexProduct) {
    final variantSelected = listProductForm[indexProduct]['variantSelected'];
    if (variantSelected.length <= 1) {
      return;
    }
    variantSelected.removeLast();
    listProductForm[indexProduct]['variantSelected'] = variantSelected;
    updateTotalPay();

    update();
  }

  // Reset Form Product
  void resetFormProduct() {
    listProductForm.clear();
    codeProductTec.clear();
  }

  // Fetch Transaction
  void fetchTransaction(QuerySnapshot data) {
    for (var doc in data.docs) {
      TransactionModel transactionModel = TransactionModel(
        totalPay: doc['totalPay'],
        createdAt: doc['createdAt'],
      );
      transactionModel.idDocument = doc.id;
      listDataTable.add(transactionModel);
    }
    isLoadingTableData.toggle();
    update();
  }

  @override
  void onInit() async {
    isLoadingTableData.toggle();
    final result = await readAllTransaction();
    fetchTransaction(result);
    super.onInit();
  }
}
