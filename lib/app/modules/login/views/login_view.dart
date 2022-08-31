import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/routes/app_pages.dart';
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
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    decoration: GlobalStyles.formInputDecoration('Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    cursorColor: ColorConstant.primaryColor,
                    obscureText: true,
                    decoration: GlobalStyles.formInputDecoration('Kata Sandi'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.HOME);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstant.primaryColor,
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
    ));
  }
}
