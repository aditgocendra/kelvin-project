import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/models/detail_transaction.dart';
import 'package:kelvin_project/app/models/transaction.dart';
import 'package:kelvin_project/app/routes/app_pages.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';
import 'package:kelvin_project/services/local/shared_pref.dart';

class HomeController extends GetxController {
  final SharedPrefService pref = SharedPrefService();
  final username = ''.obs;

  // Logged in
  final isLogin = false.obs;

  // Sidebar Content
  final indexContent = 0.obs;

  // Rightbar
  List<TransactionModel> listLastTransaction = [];
  final timeClock = DateFormat.Hm().format(DateTime.now()).obs;

  void logout() {
    pref.removeCache();
    Get.offAndToNamed(Routes.LOGIN);
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

  Future<QuerySnapshot> getDetailTransaction(String idDoc) async {
    return await FirestoreService.refSubCollectionDetailTransaction(
      idDoc: idDoc,
      collection: 'transactions',
      subCollectionPath: 'detailTransaction',
    ).limit(1).get();
  }

  @override
  void onInit() async {
    final result = await pref.readCache();
    username.value = result;

    streamLastTransaction();

    // Clock
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timeClock.value = DateFormat.Hm().format(DateTime.now());
    });

    super.onInit();
  }
}
