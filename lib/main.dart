import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/firebase_options.dart';
import 'package:projectka_pos/services/local/shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = await SharedPrefService().readCache();

  initializeDateFormatting();
  runApp(
    App(
      user: user,
    ),
  );
}

class App extends StatelessWidget {
  dynamic user;
  App({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Projectka POS",
      debugShowCheckedModeBanner: false,
      initialRoute: user[0] == null ? Routes.LOGIN : AppPages.INITIAL,
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
