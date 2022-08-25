import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:kelvin_project/app/globals/styles.dart';
import 'package:kelvin_project/app/modules/home/controllers/home_controller.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 500,
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo/KLABELS_Logo_Front_Color_16-9.png',
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.isLogin.toggle();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    elevation: 0.5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
