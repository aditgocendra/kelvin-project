import 'package:get/get.dart';

class HomeController extends GetxController {
  // Logged in
  final isLogin = false.obs;

  // Sidebar Content
  final indexContent = 0.obs;

  void logout() {
    isLogin.toggle();
  }

  @override
  void onInit() {
    print('init home');
    super.onInit();
  }
}
