import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelvin_project/app/utils/constant.dart';
import 'package:kelvin_project/app/utils/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/logo/KLABELS_Logo_Front_Color_16-9.png',
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller.emailCtl,
                      style: const TextStyle(fontSize: 14),
                      cursorColor: primaryColor,
                      decoration: GlobalStyles.formInputDecoration('Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller.passCtl,
                      style: const TextStyle(fontSize: 14),
                      cursorColor: primaryColor,
                      obscureText: true,
                      decoration:
                          GlobalStyles.formInputDecoration('Kata Sandi'),
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.errorMessageForm.value,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return LoadingAnimationWidget.dotsTriangle(
                            color: primaryColor, size: 50);
                      }

                      return ElevatedButton(
                        onPressed: () {
                          controller.login();
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
