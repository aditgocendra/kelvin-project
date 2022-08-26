import 'package:get/get.dart';

class HomeController extends GetxController {
  // Logged in
  final isLogin = false.obs;

  // Sidebar Content
  final indexContent = 0.obs;

  // Product Screen
  final countVariantForm = 1.obs;

  // Transaction Screen

  final countProductTransactionForm = 0.obs;
  List<dynamic> listProductVariantTransactionForm = [1.obs];

  void addProductForm() {
    countProductTransactionForm.value++;
    listProductVariantTransactionForm.add(1.obs);
  }

  void removeProductForm(int index) {
    if (countProductTransactionForm.value <= 1) {
      return;
    }
    countProductTransactionForm.value--;
    listProductVariantTransactionForm.removeAt(index);
  }

  void logout() {
    isLogin.toggle();
  }
}
