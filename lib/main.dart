import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);
  final isLogin = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Projectka POS",
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin ? AppPages.INITIAL : Routes.LOGIN,
      getPages: AppPages.routes,
      theme: ThemeData(
        backgroundColor: ColorConstant.backgroundColor,
        canvasColor: ColorConstant.canvasColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black87,
              ),
        ),
      ),
    );
  }
}
