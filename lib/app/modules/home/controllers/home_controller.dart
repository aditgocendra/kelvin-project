import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/transaction.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_category_controller.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_product_controller.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_users_controller.dart';
import 'package:kelvin_project/app/routes/app_pages.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';
import 'package:kelvin_project/services/local/shared_pref.dart';

class HomeController extends GetxController {
  // Controller
  final mProductController = Get.find<ManageProductController>();
  final mCtgController = Get.find<ManageCategoryController>();
  final mTransController = Get.find<ManageTransactionController>();
  final mUserController = Get.find<ManageUsersController>();
  TextEditingController searchTec = TextEditingController();

  // Local Storage Shared Pref
  final SharedPrefService pref = SharedPrefService();
  final username = ''.obs;
  final userRole = ''.obs;

  // Logged in
  final isLogin = false.obs;

  // Sidebar Content
  final indexContent = 0.obs;

  // Rightbar
  List<TransactionModel> listLastTransaction = [];
  final timeClock = DateFormat.Hm().format(DateTime.now()).obs;

  Future logout() async {
    await pref.removeCache();
    Get.offNamedUntil(Routes.LOGIN, (route) => false);
  }

  void search() {
    if (searchTec.text.isEmpty) {
      return;
    }

    switch (indexContent.value) {
      case 2:
        mCtgController.searchData(searchTec.text.trim());
        break;
      case 3:
        mTransController.searchData(searchTec.text.trim());
        break;
      case 4:
        mUserController.searchData(searchTec.text.trim());
        break;
      default:
        mProductController.searchData(searchTec.text);
    }
  }

  void setDataTable() {
    switch (indexContent.value) {
      case 2:
        mCtgController.refreshData();
        break;
      case 3:
        mTransController.refreshData();
        break;
      case 4:
        mUserController.refreshData();
        break;
      default:
        mProductController.refreshData();
    }
  }

  void streamLastTransaction() {
    FirestoreService.refTransaction
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) async {
      listLastTransaction.clear();

      // Set Transaction

      if (event.docs.isEmpty) {
        update();
        return;
      }

      for (var doc in event.docs) {
        TransactionModel transaction = TransactionModel(
          totalPay: doc['totalPay'],
          createdAt: doc['createdAt'],
        );

        transaction.idDocument = doc.id;
        listLastTransaction.add(transaction);
      }

      update();
    });
  }

  @override
  void onInit() async {
    final result = await pref.readCache();

    if (result == null) {
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
      return;
    }

    username.value = result[0];
    userRole.value = result[1];
    streamLastTransaction();

    // Clock
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timeClock.value = DateFormat.Hm().format(DateTime.now());
    });

    super.onInit();
  }
}
