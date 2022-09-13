import 'package:get/get.dart';

import 'package:projectka_pos/app/modules/home/controllers/dashboard_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_product_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_user_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<ManageTransactionController>(
      () => ManageTransactionController(),
    );
    Get.lazyPut<ManageProductController>(
      () => ManageProductController(),
    );
    Get.lazyPut<ManageUserController>(
      () => ManageUserController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
