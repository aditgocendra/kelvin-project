import 'package:get/get.dart';

import 'package:kelvin_project/app/modules/home/controllers/manage_category_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ManageCategoryController>(
      () => ManageCategoryController(),
    );
  }
}
