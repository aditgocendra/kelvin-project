import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:unicons/unicons.dart';

class SearchWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();
  SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Cari Produk',
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
              controller.indexContent.value = 5;
            },
            child: const Icon(
              UniconsLine.search_alt,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
