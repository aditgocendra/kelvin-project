import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/utils/constant.dart';

class DialogMessage {
  static dialogErrorFromFirebase(int errCode) {
    return Get.defaultDialog(
      contentPadding: const EdgeInsets.all(32),
      title: 'Kesalahan ${errCode.hashCode.toString()}',
      middleText: 'Terjadi kesalahan tak terduga, silahkan coba kembali nanti',
      textConfirm: 'Ok',
      buttonColor: primaryColor,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  static dialogSearchNotFound(String collection) {
    return Get.defaultDialog(
      contentPadding: const EdgeInsets.all(32),
      title: 'Pencarian',
      middleText: 'Tidak ditemukan data $collection dengan keyword tersebut.',
      textConfirm: 'Ok',
      buttonColor: primaryColor,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
