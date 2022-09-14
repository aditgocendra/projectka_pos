import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/utils/styles.dart';
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
              border: Border.all(color: ColorConstant.primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_test.png',
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: controller.emailCtl,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: controller.passCtl,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
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
                          color: ColorConstant.primaryColor, size: 50);
                    }

                    return ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
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
    ));
  }
}
