import 'package:get/get.dart';
import 'package:kelvin_project/app/routes/app_pages.dart';
import 'package:kelvin_project/services/local/shared_pref.dart';

class HomeController extends GetxController {
  final SharedPrefService pref = SharedPrefService();
  final username = ''.obs;

  // Logged in
  final isLogin = false.obs;

  // Sidebar Content
  final indexContent = 0.obs;

  void logout() {
    pref.removeCache();
    Get.offAndToNamed(Routes.LOGIN);
  }

  @override
  void onInit() async {
    username.value = await pref.readCache();
    print(username);
    super.onInit();
  }
}
