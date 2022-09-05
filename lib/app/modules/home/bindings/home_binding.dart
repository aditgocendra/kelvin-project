import 'package:get/get.dart';

import 'package:kelvin_project/app/modules/home/controllers/manage_category_controller.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_product_controller.dart';
import 'package:kelvin_project/app/modules/home/controllers/manage_transaction_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageTransactionController>(
      () => ManageTransactionController(),
    );
    Get.lazyPut<ManageProductController>(
      () => ManageProductController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ManageCategoryController>(
      () => ManageCategoryController(),
    );
  }
}
