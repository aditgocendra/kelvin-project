import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
import 'package:kelvin_project/app/routes/app_pages.dart';
import 'package:unicons/unicons.dart';

class Rightbar extends StatelessWidget {
  const Rightbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: [
        User(),
        DayTime(),
        LastTransaction(),
      ],
    );
  }
}

class User extends StatelessWidget {
  User({
    Key? key,
  }) : super(key: key);

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(64),
            ),
            child: Image.asset(
              'assets/images/avatar/avatar_male.png',
              fit: BoxFit.cover,
              width: 80,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () {
              return Text(
                homeController.username.value,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton.icon(
            onPressed: () {
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
            },
            icon: const Icon(
              UniconsLine.sign_out_alt,
              size: 16,
            ),
            label: const Text(
              'Keluar',
              style: TextStyle(fontSize: 10),
            ),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              elevation: 0.5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              minimumSize: const Size.fromHeight(40),
            ),
          )
        ],
      ),
    );
  }
}

class DayTime extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DayTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Obx(
            () => Text(
              homeController.timeClock.value,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                height: 1,
              ),
            ),
          ),
          Text(
            DateFormat('EEEE, d MMM y', 'id').format(
              DateTime.now(),
            ),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}

class LastTransaction extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  LastTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                UniconsLine.exchange_alt,
                color: primaryColor,
                size: 20,
              ),
            ),
            // Data Last Transaction
            GetBuilder(
              init: homeController,
              builder: (_) {
                if (homeController.listLastTransaction.isEmpty) {
                  return const Text(
                    'Belum ada satupun transaksi',
                    style: TextStyle(fontSize: 11),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: homeController.listLastTransaction
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          ItemLastTransaction(
                            title: homeController
                                .listLastTransaction[index].idDocument,
                            date: DateFormat('EEEE, d MMM y', 'id').format(
                              value.createdAt.toDate(),
                            ),
                            time: DateFormat.Hm().format(
                              value.createdAt.toDate(),
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ItemLastTransaction extends StatelessWidget {
  final title;
  final time;
  final date;

  const ItemLastTransaction({
    Key? key,
    required this.title,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    if (screenSize > 1630) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 10.5),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black45,
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 11),
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black45,
              ),
            )
          ],
        ),
      );
    }
  }
}
