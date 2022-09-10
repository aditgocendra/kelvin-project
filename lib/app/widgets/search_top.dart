import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:unicons/unicons.dart';

class SearchWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String hintText;

        switch (homeController.indexContent.value) {
          case 2:
            hintText = 'Cari Kategori';
            break;
          case 3:
            hintText = 'Cari Transaksi';
            break;
          case 4:
            hintText = 'Cari Pengguna';
            break;
          default:
            hintText = 'Cari Produk';
        }

        return TextField(
          style: const TextStyle(fontSize: 12),
          controller: homeController.searchTec,
          onTap: () {
            // Change Content View
            if (homeController.indexContent.value < 2) {
              homeController.indexContent.value = 1;
              return;
            }

            homeController.indexContent.value =
                homeController.indexContent.value;
          },
          onChanged: (value) {
            if (value.isEmpty) {
              homeController.resetDataTable();
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            suffixIcon: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 6.0),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: () {
                  homeController.search();
                },
                child: const Icon(
                  UniconsLine.search_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
