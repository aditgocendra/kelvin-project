import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';
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
        const DayTime(),
        const LastTransaction(),
      ],
    );
  }
}

class User extends StatelessWidget {
  User({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

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
          const Text(
            'Aditya Gocendra',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
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
                  controller.logout();
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
  const DayTime({
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
        children: const [
          Text(
            '22:32',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              height: 1,
            ),
          ),
          Text(
            'Senin, 27 Mar 2022',
            style: TextStyle(
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
  const LastTransaction({
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ItemLastTransaction(
                  title: '3 Seconds Bundle',
                  date: 'Senin, 23 Jan 2022',
                  time: '11:32',
                ),
                ItemLastTransaction(
                  title: 'Bandana Swecsh',
                  date: 'Rabu, 20 Feb 2022',
                  time: '10:49',
                ),
                ItemLastTransaction(
                  title: 'PDH Teknokrat',
                  date: 'Sabtu, 06 Okt 2022',
                  time: '10:49',
                ),
                ItemLastTransaction(
                  title: 'Cutting Laser',
                  date: 'Minggu, 08 Des 2022',
                  time: '08:49',
                ),
                ItemLastTransaction(
                  title: 'Distro Original',
                  date: 'Minggu, 08 Des 2022',
                  time: '13:49',
                ),
                ItemLastTransaction(
                  title: 'Daster Original',
                  date: 'Minggu, 08 Des 2022',
                  time: '22:49',
                ),
              ],
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

    if (screenSize > 1460) {
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
