import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelvin_project/app/modules/home/views/screens/dashboard.dart';
import 'package:kelvin_project/app/modules/home/views/screens/manage_category.dart';
import 'package:kelvin_project/app/modules/home/views/screens/manage_product.dart';
import 'package:kelvin_project/app/modules/home/views/screens/manage_transaction.dart';
import 'package:kelvin_project/app/modules/home/views/screens/manage_users.dart';
import 'package:kelvin_project/app/modules/home/views/screens/search_product.dart';
import 'package:kelvin_project/app/widgets/rightbar.dart';
import 'package:kelvin_project/app/widgets/search_top.dart';
import 'package:kelvin_project/app/widgets/sidebar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminPanel(),
    );
  }
}

class AdminPanel extends StatelessWidget {
  final controller = Get.find<HomeController>();
  AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          const Expanded(
            child: Sidebar(),
          ),
          // Content
          Expanded(
            flex: 5,
            child: ListView(
              controller: ScrollController(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchWidget(),
                ),
                Obx(
                  () {
                    Widget content;
                    switch (controller.indexContent.value) {
                      case 1:
                        content = ManageProduct();
                        break;
                      case 2:
                        content = ManageCategory();
                        break;
                      case 3:
                        content = ManageTransaction();
                        break;
                      case 4:
                        content = ManageUsers();
                        break;
                      case 5:
                        content = const SearchProduct();
                        break;
                      default:
                        content = const Dashboard();
                    }
                    return content;
                  },
                )
              ],
            ),
          ),
          // Rightbar
          if (screenSize > 1060)
            const Expanded(
              child: Rightbar(),
            ),
        ],
      ),
    );
  }
}
