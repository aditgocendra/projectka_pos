import 'package:get/get.dart';

import 'package:projectka_pos/app/modules/home/controllers/manage_user_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageUserController>(
      () => ManageUserController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
