import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/models/category.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';

class ManageCategoryController extends GetxController {
  final isLoading = false.obs;

  TextEditingController nameTec = TextEditingController();

  List<CategoryModel> listCategory = [];

  // Reading Data
  Future<QuerySnapshot> readCateogry() async {
    return await FirestoreService.refCategory.orderBy('createdAt').get();
  }

  // Write Data
  Future writeCategory() async {
    if (!validationForm()) {
      print('Text field masih kosong');
      return;
    }

    String name = nameTec.text.trim();
    CategoryModel newCategory =
        CategoryModel(name: name, createdAt: Timestamp.now());

    await FirestoreService.refCategory.add(newCategory).then(
      (val) {
        nameTec.clear();
        newCategory.idDocument = val.id;
        listCategory.add(newCategory);
        update();
        Get.back();
      },
    ).catchError(
      (error) => print(error),
    );
  }

  // Update data
  Future updateCategory(String idDocument) async {
    String name = nameTec.text.trim();

    // CategoryModel ctg = CategoryModel(name: name, createdAt: )

    await FirestoreService.refCategory
        .doc(idDocument)
        .update({'name': name}).then((_) {
      listCategory[listCategory
              .indexWhere((element) => element.idDocument == idDocument)]
          .name = name;
      Get.back();
      update();
    }).catchError(
      (error) => print(error),
    );
  }

  // Delete data
  Future deleteCategory(String idDocument) async {
    await FirestoreService.refCategory.doc(idDocument).delete().then((_) {
      listCategory.removeWhere((ctg) => ctg.idDocument == idDocument);
      Get.back();
      update();
    }).catchError(
      (error) => print(error),
    );
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
        createdAt: doc['createdAt'],
      );
      ctg.idDocument = doc.id;
      listCategory.add(ctg);
    }
    isLoading.toggle();
    update();
  }

  @override
  void onInit() async {
    isLoading.toggle();
    final result = await readCateogry();
    fetchCategory(result);

    super.onInit();
  }
}
