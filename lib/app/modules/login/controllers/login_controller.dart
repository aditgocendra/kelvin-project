import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/routes/app_pages.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';
import 'package:kelvin_project/services/local/encryption.dart';
import 'package:kelvin_project/services/local/shared_pref.dart';

class LoginController extends GetxController {
  // Shared Preferences
  final prefService = SharedPrefService();

  // Loading
  final isLoading = false.obs;

  // Error Message
  final errorMessageForm = ''.obs;

  // Editing Controller
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();

  // Login
  Future login() async {
    // Validation Form
    if (!validationForm()) {
      errorMessageForm.value = 'Beberapa form terlihat kosong';
      return;
    }

    String emailInput = emailCtl.text.trim();
    String passInput = passCtl.text.trim();

    // Check Email Format
    if (!GetUtils.isEmail(emailInput)) {
      errorMessageForm.value = 'Format email salah';
      return;
    }

    // Get user account
    isLoading.toggle();
    final resultUser = await getUserAccount(emailInput);

    // Check user account available or not
    if (resultUser.docs.isEmpty) {
      errorMessageForm.value = 'Pengguna tidak ditemukan';
      isLoading.toggle();
      return;
    }

    // Decryption password from firebase
    final userData = resultUser.docs[0];
    final passDec = EncryptionService.decryptAES(userData['password']);

    // Check Password Same or not pass from firebase
    if (passInput != passDec) {
      errorMessageForm.value = 'Password salah';
      isLoading.toggle();
      return;
    }

    // Set Preferences Data
    prefService.createCache(userData['username']);

    // Login Success
    Get.offAndToNamed(Routes.HOME);
  }

  // GetUser Account
  Future<QuerySnapshot> getUserAccount(String emailAddress) async {
    return await FirestoreService.refUsers
        .where('email', isEqualTo: emailAddress)
        .limit(1)
        .get();
  }

  // Validation Form
  bool validationForm() {
    if (emailCtl.text.isEmpty) {
      return false;
    }

    if (passCtl.text.isEmpty) {
      return false;
    }

    return true;
  }
}
