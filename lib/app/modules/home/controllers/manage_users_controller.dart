import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/models/users.dart';
import 'package:kelvin_project/app/utils/dialog.dart';
import 'package:kelvin_project/app/utils/functions.dart';
import 'package:kelvin_project/services/firebase/firestore.service.dart';
import 'package:kelvin_project/services/local/encryption.dart';

class ManageUsersController extends GetxController {
  // Loading
  final isLoading = false.obs;

  // List Data
  List<UserModel> listUsers = [];

  // Error Message
  final errorMessageFormAdd = ''.obs;
  final errorMessageFormEdit = ''.obs;
  final errorMessageFormChangePass = ''.obs;

  // Text Editing Controller Add User
  ScrollController scrollHorizontalTable = ScrollController();
  TextEditingController usernameAddTec = TextEditingController();
  TextEditingController emailAddTec = TextEditingController();
  TextEditingController passAddTec = TextEditingController();
  TextEditingController confPassAddTec = TextEditingController();

  // Role User Add
  String? roleUserAdd;

  // Text Editing Controller Update User
  TextEditingController emailEditTec = TextEditingController();
  TextEditingController usernameEditTec = TextEditingController();

  // Role User Update
  String? roleUserEdit;

  // Text Editing Controller Update Password
  TextEditingController passEditTec = TextEditingController();
  TextEditingController confPassEditTec = TextEditingController();

  // Search Data User
  Future searchData(String keyword) async {
    isLoading.toggle();
    await FirestoreService.refUsers
        .where('searchKeyword', arrayContains: keyword.toLowerCase())
        .get()
        .then((result) {
      if (result.docs.isEmpty) {
        isLoading.toggle();
        DialogMessage.dialogSearchNotFound('pengguna');
        return;
      }

      listUsers.clear();
      fetchUsers(result);
    });
  }

  // Read User Data
  Future<QuerySnapshot> readUserData() async {
    return await FirestoreService.refUsers.get();
  }

  // Set User Data To Firestore
  Future createUserData() async {
    if (!validationFormAdd()) {
      errorMessageFormAdd.value = 'Beberapa Form Masih Kosong';
      return;
    }

    String emailAddress = emailAddTec.text.trim();
    String username = usernameAddTec.text.trim();
    String pass = passAddTec.text.trim();

    // Check Email

    if (!GetUtils.isEmail(emailAddress)) {
      errorMessageFormAdd.value = 'Format Email Tidak Sesuai';
      return;
    }

    // Check Pass and Conf pass
    if (passAddTec.text != confPassAddTec.text) {
      errorMessageFormAdd.value = 'Password dan konfirmasi password tidak sama';
      return;
    }

    // Check email is registered or not
    final resultUser = await checkEmail(emailAddress);

    if (resultUser.docs.isNotEmpty) {
      errorMessageFormAdd.value = 'Email telah terdaftar';
      return;
    }

    final encPass = EncryptionService.encryptAES(pass);

    UserModel newUser = UserModel(
      username: username,
      email: emailAddress,
      role: roleUserAdd!,
      password: encPass,
      createdAt: FirestoreService.timeStamp,
      searchKeyword: Functions.generateSearchKeyword(sentence: username),
    );

    await FirestoreService.refUsers.add(newUser).then((val) {
      newUser.idDocument = val.id;
      listUsers.add(newUser);
      Get.back();
      update();
    });
  }

  // Edit User Data
  Future editUserData(UserModel user) async {
    if (!validationFormEdit()) {
      errorMessageFormEdit.value = 'Beberapa Form Masih Kosong';
      return;
    }

    String newUsername = usernameEditTec.text.trim();

    final newDataUser = UserModel(
      username: newUsername,
      email: user.email,
      role: roleUserEdit!,
      password: user.password,
      createdAt: user.createdAt,
    );

    await FirestoreService.refUsers
        .doc(user.idDocument)
        .set(newDataUser)
        .then((value) {
      listUsers[listUsers.indexWhere(
        (element) => element.idDocument == user.idDocument,
      )] = newDataUser;

      update();

      Get.back();
    }).catchError((err) {
      Get.back();
      DialogMessage.dialogErrorFromFirebase(err);
    });
  }

  // Edit Password
  Future changePassword(UserModel user) async {
    if (!validationFormChangePass()) {
      errorMessageFormChangePass.value = 'Beberapa form terlihat kosong';
      return;
    }

    String newPass = passEditTec.text.trim();
    String confPass = confPassEditTec.text.trim();

    if (newPass != confPass) {
      errorMessageFormChangePass.value =
          'Password dan konfirmasi password tidak sama';
      return;
    }

    final resultEnc = EncryptionService.encryptAES(newPass);

    final newDataUser = UserModel(
      username: user.username,
      email: user.email,
      role: user.role,
      password: resultEnc,
      createdAt: user.createdAt,
    );

    await FirestoreService.refUsers
        .doc(user.idDocument)
        .set(newDataUser)
        .then((value) {
      listUsers[listUsers.indexWhere(
        (doc) => doc.idDocument == user.idDocument,
      )] = newDataUser;

      update();

      Get.back();
    }).catchError((err) {
      Get.back();
      DialogMessage.dialogErrorFromFirebase(err);
    });
  }

  // Delete Data User
  Future deleteUser(String idDoc) async {
    await FirestoreService.refUsers.doc(idDoc).delete().then((_) {
      listUsers.removeWhere((user) => user.idDocument == idDoc);
      update();
      Get.back();
    }).catchError((err) {
      Get.back();
      DialogMessage.dialogErrorFromFirebase(err);
    });
  }

  // Check User Data
  Future<QuerySnapshot> checkEmail(String emailAddress) async {
    return await FirestoreService.refUsers
        .where('email', isEqualTo: emailAddress)
        .limit(1)
        .get();
  }

  // Refresh Data
  Future refreshData() async {
    isLoading.toggle();
    listUsers.clear();
    final result = await readUserData();
    fetchUsers(result);
  }

  // Validation Form Add
  bool validationFormAdd() {
    if (usernameAddTec.text.isEmpty) {
      return false;
    }

    if (emailAddTec.text.isEmpty) {
      return false;
    }

    if (passAddTec.text.isEmpty) {
      return false;
    }

    if (confPassAddTec.text.isEmpty) {
      return false;
    }

    if (roleUserAdd!.isEmpty) {
      return false;
    }

    return true;
  }

  // Validation Form Edit
  bool validationFormEdit() {
    if (emailEditTec.text.isEmpty) {
      return false;
    }

    if (usernameEditTec.text.isEmpty) {
      return false;
    }

    if (roleUserEdit!.isEmpty) {
      return false;
    }
    return true;
  }

  // Validation Form Change Password
  bool validationFormChangePass() {
    if (passEditTec.text.isEmpty) {
      return false;
    }

    if (confPassEditTec.text.isEmpty) {
      return false;
    }

    return true;
  }

  // Fetching data to list
  void fetchUsers(QuerySnapshot data) {
    for (var doc in data.docs) {
      UserModel user = UserModel(
        email: doc['email'],
        username: doc['username'],
        role: doc['role'],
        password: doc['password'],
        createdAt: doc['createdAt'],
        searchKeyword: List.from(
          doc['searchKeyword'],
        ),
      );

      user.idDocument = doc.id;
      listUsers.add(user);
    }
    isLoading.toggle();
    update();
  }
}
