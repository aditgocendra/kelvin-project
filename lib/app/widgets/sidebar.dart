import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';

class Sidebar extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    return Drawer(
      elevation: 1,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Image.asset(
                screenSize > 1060
                    ? 'assets/images/logo/KLABELS_Logo_Front_Color_16-9.png'
                    : 'assets/images/logo/KLABELS_Logo_Front_Color.png',
                width: screenSize > 1060 ? 200 : 70,
              ),
            ),
            Column(
              children: listNavItem
                  .asMap()
                  .map(
                    (index, navItem) {
                      return MapEntry(
                        index,
                        NavItemSidebar(
                          title: listNavItem[index]['title'],
                          icon: listNavItem[index]['icon'],
                          index: index,
                          screenSize: screenSize,
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItemSidebar extends StatelessWidget {
  String title;
  IconData icon;
  int index;
  double screenSize;
  final homeController = Get.find<HomeController>();

  NavItemSidebar({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeController.userRole.value == 'Admin' && index == 3) {
      return Container();
    }

    if (homeController.userRole.value == 'Kasir' && index == 1) {
      return Container();
    }

    if (homeController.userRole.value == 'Kasir' && index == 2) {
      return Container();
    }

    if (homeController.userRole.value == 'Kasir' && index == 4) {
      return Container();
    }

    if (screenSize > 1060) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Obx(
          () {
            return ListTile(
              onTap: () {
                if (index + 1 == listNavItem.length) {
                  Get.defaultDialog(
                    contentPadding: const EdgeInsets.all(16),
                    title: 'Keluar Aplikasi',
                    middleText: 'Apakah kamu yakin ingin keluar aplikasi ?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    buttonColor: primaryColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: primaryColor,
                    onConfirm: () {
                      Get.back();
                      homeController.logout();
                    },
                    onCancel: () => Get.back(),
                  );
                  return;
                }

                homeController.indexContent.value = index;
                homeController.setDataTable();
              },
              leading: Icon(
                icon,
                size: 20,
                color: homeController.indexContent.value == index
                    ? primaryColor
                    : Colors.black87,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: homeController.indexContent.value == index
                      ? primaryColor
                      : Colors.black87,
                ),
              ),
            );
          },
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (index + 1 == listNavItem.length) {
                  Get.defaultDialog(
                    contentPadding: const EdgeInsets.all(16),
                    title: 'Keluar Aplikasi',
                    middleText: 'Apakah kamu yakin ingin keluar aplikasi ?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    buttonColor: primaryColor,
                    confirmTextColor: Colors.white,
                    cancelTextColor: primaryColor,
                    onConfirm: () {
                      Get.back();
                      homeController.logout();
                    },
                    onCancel: () => Get.back(),
                  );
                  return;
                }

                homeController.indexContent.value = index;
                homeController.setDataTable();
              },
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: homeController.indexContent.value == index
                        ? primaryColor
                        : Colors.black87,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: homeController.indexContent.value == index
                          ? primaryColor
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
