import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/models/category.dart';
import 'package:kelvin_project/app/utils/dialog.dart';
import 'package:kelvin_project/app/utils/functions.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';

class ManageCategoryController extends GetxController {
  final isLoading = false.obs;

  // Error Message
  final errorMessageForm = ''.obs;

  // Controller
  ScrollController scrollHorizontalTable = ScrollController();
  TextEditingController nameTec = TextEditingController();

  List<CategoryModel> listCategory = [];

  // Search Data Category
  Future searchData(String keyword) async {
    isLoading.toggle();
    await FirestoreService.refCategory
        .where('searchKeyword', arrayContains: keyword.toLowerCase())
        .get()
        .then((result) {
      if (result.docs.isEmpty) {
        isLoading.toggle();
        DialogMessage.dialogSearchNotFound('kategori');
        return;
      }

      listCategory.clear();
      fetchCategory(result);
    });
  }

  // Reading Data
  Future<QuerySnapshot> readCateogry() async {
    return await FirestoreService.refCategory.orderBy('createdAt').get();
  }

  // Create Data
  Future createCategory() async {
    if (!validationForm()) {
      errorMessageForm.value = 'Form kategori masih kosong';
      return;
    }

    String name = nameTec.text.trim();
    CategoryModel newCategory = CategoryModel(
      name: name,
      searchKeyword: Functions.generateSearchKeyword(sentence: name),
      createdAt: Timestamp.now(),
    );

    await FirestoreService.refCategory.add(newCategory).then(
      (val) {
        nameTec.clear();
        newCategory.idDocument = val.id;
        listCategory.add(newCategory);
        update();
        Get.back();
      },
    ).catchError(
      (err) {
        Get.back();
        DialogMessage.dialogErrorFromFirebase(err);
      },
    );
  }

  // Update data
  Future updateCategory(String idDocument) async {
    String name = nameTec.text.trim();

    await FirestoreService.refCategory.doc(idDocument).update({
      'name': name,
      'searchKeyword': Functions.generateSearchKeyword(sentence: name)
    }).then((_) {
      listCategory[listCategory
              .indexWhere((element) => element.idDocument == idDocument)]
          .name = name;
      Get.back();
      update();
    }).catchError(
      (err) {
        Get.back();
        DialogMessage.dialogErrorFromFirebase(err);
      },
    );
  }

  // Delete data
  Future deleteCategory(String idDocument) async {
    await FirestoreService.refCategory.doc(idDocument).delete().then((_) {
      listCategory.removeWhere((ctg) => ctg.idDocument == idDocument);
      Get.back();
      update();
    }).catchError(
      (err) {
        Get.back();
        DialogMessage.dialogErrorFromFirebase(err);
      },
    );
  }

  Future refreshData() async {
    listCategory.clear();
    isLoading.toggle();
    final result = await readCateogry();
    fetchCategory(result);
  }

  // Validation form
  bool validationForm() {
    if (nameTec.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Fetching data to list
  void fetchCategory(QuerySnapshot data) {
    for (var doc in data.docs) {
      CategoryModel ctg = CategoryModel(
        name: doc['name'],
        searchKeyword: List.from(doc['searchKeyword']),
        createdAt: doc['createdAt'],
      );
      ctg.idDocument = doc.id;
      listCategory.add(ctg);
    }
    isLoading.toggle();
    update();
  }
}
