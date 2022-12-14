import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/category.dart';
import 'package:kelvin_project/app/models/products.dart';
import 'package:kelvin_project/app/models/stock_product.dart';
import 'package:kelvin_project/app/models/variant_product.dart';
import 'package:kelvin_project/app/utils/dialog.dart';
import 'package:kelvin_project/app/utils/functions.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';

import '../../../../services/local/pdf_services.dart';

class ManageProductController extends GetxController {
  // isLoading
  final isLoading = false.obs;

  // Error Message
  final errFormMessage = ''.obs;

  // Category Data
  List<CategoryModel> categoryData = [];
  CategoryModel? ctgDetailProduct;

  // Controller
  ScrollController scrollHorizontalTable = ScrollController();
  TextEditingController nameProductTec = TextEditingController();
  TextEditingController priceTec = TextEditingController();
  TextEditingController codeProductTec = TextEditingController();
  List<Map<String, dynamic>> listVariantFormCtl = [];

  // Data Product
  List<ProductModel> listProduct = [];

  // Variant Product
  List<VariantProductModel> listVariantProduct = [];

  // Stock Product
  List<StockProductModel> listStockProduct = [];

  // Category id selected
  String? idCategorySelected;

  // Search Data Product
  Future searchData(String keyword) async {
    isLoading.toggle();
    await FirestoreService.refProduct
        .where('searchKeyword', arrayContains: keyword.toLowerCase())
        .get()
        .then((result) {
      if (result.docs.isEmpty) {
        isLoading.toggle();
        DialogMessage.dialogSearchNotFound('produk');

        return;
      }

      listProduct.clear();
      fetchProduct(result);
    });
  }

  // Read Data Product
  Future readProduct() async {
    return await FirestoreService.refProduct.orderBy('createdAt').get();
  }

  // Check Code Product
  Future<bool> checkCodeProduct(String codeProduct) async {
    final result = await FirestoreService.refProduct.doc(codeProduct).get();
    return result.exists;
  }

  // Read Data Variant Product
  Future readVariantProduct(String idDoc) async {
    listVariantProduct.clear();
    final result = await FirestoreService.refSubCollectionProduct(
      idDoc: idDoc,
      collection: 'products',
      subCollectionPath: 'variant_product',
    ).get();

    for (var doc in result.docs) {
      listVariantProduct.add(
        VariantProductModel(
          color: doc['color'],
          size: doc['size'],
          stock: doc['stock'],
        ),
      );
    }

    update();
  }

  Future readStockProduct(String idDoc) async {
    listStockProduct.clear();
    final result = await FirestoreService.refSubCollectionStockProduct(
      idDoc: idDoc,
      collection: 'products',
      subCollectionPath: 'stock',
    ).get();

    for (var doc in result.docs) {
      listStockProduct.add(
        StockProductModel(
          stock: doc['stock'],
          createdAt: doc['createdAt'],
        ),
      );
    }

    update();
  }

  // Create Data Product
  Future setProduct() async {
    errFormMessage.value = '';

    int allStock = 0;

    if (!validationFormProduct()) {
      errFormMessage.value = 'Beberapa form produk masih kosong';

      return;
    }

    // Validation form variant product
    for (var i = 0; i < listVariantFormCtl.length; i++) {
      if (listVariantFormCtl[i]['colorCtl'].text.isEmpty) {
        errFormMessage.value = 'Beberapa form produk variant masih kosong';
        return false;
      }

      if (listVariantFormCtl[i]['stockCtl'].text.isEmpty) {
        errFormMessage.value = 'Beberapa form produk variant masih kosong';
        return false;
      }
      allStock += int.parse(listVariantFormCtl[i]['stockCtl'].text);
    }

    final codeProduct = codeProductTec.text.trim();

    // Validation Code Product
    final result = codeProduct.substring(1);
    try {
      // check 3 code after last
      int.parse(result);
    } catch (e) {
      errFormMessage.value = 'Format kode produk salah';
      return;
    }

    if (!codeProduct.substring(0, 1).contains(RegExp(r'[A-Z]'))) {
      errFormMessage.value = 'Format kode produk salah';
      return;
    }

    final nameProduct = nameProductTec.text.trim();
    final price = priceTec.text.trim();

    final newProduct = ProductModel(
      productName: nameProduct,
      price: int.parse(price),
      // allStock: allStock,
      sold: 0,
      idCategory: idCategorySelected!,
      createdAt: FirestoreService.timeStamp,
      searchKeyword: Functions.generateSearchKeyword(sentence: nameProduct),
    );

    await FirestoreService.refProduct
        .doc(codeProduct)
        .set(newProduct)
        .then((value) async {
      newProduct.idDocument = codeProduct;

      final product = listProduct
          .where((element) => element.idDocument == codeProduct)
          .toList();

      if (product.isEmpty) {
        // Add new data
        listProduct.add(newProduct);
      } else {
        // Update data
        listProduct[listProduct.indexWhere(
            (element) => element.idDocument == codeProduct)] = newProduct;
        // Delete old data variant
        await deleteVariantProduct(codeProduct);
      }

      // Create Stock Product
      await setStockProduct(allStock, codeProduct);

      // Create variant product
      await createVariantProduct(codeProduct);
    }).catchError(
      (err) {
        Get.back();
        DialogMessage.dialogErrorFromFirebase(err);
      },
    );
  }

  // Create Stock Product
  Future setStockProduct(int stockProduct, String idProduct) async {
    StockProductModel stockProductModel = StockProductModel(
      stock: stockProduct,
      createdAt: Timestamp.fromDate(DateTime(
        DateTime.now().year,
        DateTime.now().month,
      )),
    );

    final result = await FirestoreService.refSubCollectionStockProduct(
      idDoc: idProduct,
      collection: 'products',
      subCollectionPath: 'stock',
    ).orderBy('createdAt', descending: true).limit(1).get();

    if (result.docs.isEmpty) {
      await FirestoreService.refSubCollectionStockProduct(
              idDoc: idProduct,
              collection: 'products',
              subCollectionPath: 'stock')
          .add(stockProductModel);
    } else {
      final timestamp = result.docs[0]['createdAt'];

      if (DateFormat.yMMM('id').format(timestamp.toDate()) ==
          DateFormat.yMMM('id').format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
          ))) {
        await FirestoreService.refSubCollectionStockProduct(
          idDoc: idProduct,
          collection: 'products',
          subCollectionPath: 'stock',
        ).doc(result.docs[0].id).set(
              stockProductModel,
            );
      } else {
        await FirestoreService.refSubCollectionStockProduct(
                idDoc: idProduct,
                collection: 'products',
                subCollectionPath: 'stock')
            .add(stockProductModel);
      }
    }
  }

  // Create Data Variant Product
  Future createVariantProduct(String idDoc) async {
    for (var i = 0; i < listVariantFormCtl.length; i++) {
      final productVariant = VariantProductModel(
        color: listVariantFormCtl[i]['colorCtl'].text,
        size: listVariantFormCtl[i]['sizeSelected'],
        stock: int.parse(listVariantFormCtl[i]['stockCtl'].text),
      );

      await FirestoreService.refSubCollectionProduct(
        idDoc: idDoc,
        collection: 'products',
        subCollectionPath: 'variant_product',
      ).add(productVariant);

      if (i + 1 == listVariantFormCtl.length) {
        resetEditingCtl();
        Get.back();
        update();
        return;
      }
    }
  }

  // Delete Product Data
  Future deleteDataProduct(String idDoc) async {
    // Delete Variant Product
    await deleteVariantProduct(idDoc);

    // Delete Stock Product
    await deleteStockProduct(idDoc);

    // Delete Product
    await FirestoreService.refProduct.doc(idDoc).delete().then((value) {
      listProduct.removeWhere((product) => product.idDocument == idDoc);
      update();
      Get.back();
    }).catchError(
      (err) {
        Get.back();
        DialogMessage.dialogErrorFromFirebase(err);
      },
    );
  }

  // Delete Variant Product
  Future deleteVariantProduct(String idDoc) async {
    final result = await FirestoreService.refSubCollectionProduct(
            idDoc: idDoc,
            collection: 'products',
            subCollectionPath: 'variant_product')
        .get();

    for (var doc in result.docs) {
      await doc.reference.delete();
    }
  }

  // Delete Variant Product
  Future deleteStockProduct(String idDoc) async {
    final result = await FirestoreService.refSubCollectionStockProduct(
      idDoc: idDoc,
      collection: 'products',
      subCollectionPath: 'stock',
    ).get();

    for (var doc in result.docs) {
      await doc.reference.delete();
    }
  }

  // Get Category Product
  Future getCategoryProduct(idDoc) async {
    final result = await FirestoreService.refCategory.doc(idDoc).get();
    ctgDetailProduct = result.data();
    update();
  }

  // Refresh Data
  Future refreshData() async {
    listProduct.clear();
    isLoading.toggle();
    final result = await readProduct();
    fetchProduct(result);
  }

  Future generateReportPDF(Timestamp timestamp) async {
    List<ProductReportModel> listProductReport = [];

    final data = await FirestoreService.refProduct.orderBy('createdAt').get();

    for (var doc in data.docs) {
      // Check Stock Product

      final result = await FirestoreService.refSubCollectionStockProduct(
        idDoc: doc.id,
        collection: 'products',
        subCollectionPath: 'stock',
      ).get();

      if (result.docs.isEmpty) {
        continue;
      }

      for (var element in result.docs) {
        if (DateFormat.yMMM('id').format(element['createdAt'].toDate()) ==
            DateFormat.yMMM('id').format(timestamp.toDate())) {
          ProductReportModel product = ProductReportModel(
            productName: doc['productName'],
            price: doc['price'],
            stock: element['stock'],
            idCategory: doc['idCategory'],
            sold: doc['sold'],
            createdAt: doc['createdAt'],
            searchKeyword: List<String>.from(doc['searchKeyword']),
          );
          product.idDocument = doc.id;
          listProductReport.add(product);
        }
      }
    }
    PdfService.buildPdf(
      true,
      listProductReport,
      listProductReport,
      DateFormat.yMMM('id').format(
        timestamp.toDate(),
      ),
    );
  }

  // Validation Form Product
  bool validationFormProduct() {
    if (nameProductTec.text.isEmpty) {
      return false;
    }

    if (priceTec.text.isEmpty) {
      return false;
    }

    if (codeProductTec.text.isEmpty) {
      return false;
    }

    if (idCategorySelected == null) {
      return false;
    }
    return true;
  }

  // Add Form Variant
  void addFormVariant() {
    // listVariantProduct.add(defaultVariantProduct);
    listVariantFormCtl.add({
      'colorCtl': TextEditingController(),
      'stockCtl': TextEditingController(),
      'sizeSelected': 'S',
    });
  }

  // Remove Form Variant
  void removeFormVariant(int index) {
    listVariantFormCtl.removeAt(index);
    update();
  }

  // Fetch Product Data To List Data Product
  void fetchProduct(QuerySnapshot data) {
    for (var doc in data.docs) {
      ProductModel product = ProductModel(
        productName: doc['productName'],
        price: doc['price'],
        // allStock: doc['allStock'],
        idCategory: doc['idCategory'],
        sold: doc['sold'],
        createdAt: doc['createdAt'],
        searchKeyword: List<String>.from(doc['searchKeyword']),
      );
      product.idDocument = doc.id;
      listProduct.add(product);
    }
    isLoading.toggle();
    update();
  }

  // Reset Editing Controller
  void resetEditingCtl() {
    nameProductTec.clear();
    priceTec.clear();
    codeProductTec.clear();
    listVariantFormCtl.clear();
    errFormMessage.value = '';
    addFormVariant();
  }

  // Stream Category
  void streamCategory() {
    FirestoreService.refCategory
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      categoryData.clear();
      if (event.docs.isEmpty) {
        return;
      }

      for (var doc in event.docs) {
        final ctg = CategoryModel(
          name: doc['name'],
          searchKeyword: List.from(doc['searchKeyword']),
          createdAt: doc['createdAt'],
        );
        ctg.idDocument = doc.id;
        categoryData.add(ctg);
      }

      update();
    });
  }

  @override
  void onInit() async {
    addFormVariant();
    // Set data category
    streamCategory();

    super.onInit();
  }
}
