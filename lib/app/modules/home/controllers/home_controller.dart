import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_product_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_user_controller.dart';
import 'package:projectka_pos/app/routes/app_pages.dart';
import 'package:projectka_pos/services/local/shared_pref.dart';

class HomeController extends GetxController {
  // Sidebar
  final isSidebarExpanded = true.obs;
  final indexSidebarSelected = 0.obs;

  // Local Storage Shared Pref
  final SharedPrefService pref = SharedPrefService();
  final username = ''.obs;
  final userRole = ''.obs;

  // Controller
  final mProductController = Get.find<ManageProductController>();
  final mTransController = Get.find<ManageTransactionController>();
  final mUserController = Get.find<ManageUserController>();
  TextEditingController searchTec = TextEditingController();

  Future logout() async {
    await pref.removeCache();
    Get.offNamedUntil(Routes.LOGIN, (route) => false);
  }

  void search() {
    if (searchTec.text.isEmpty) {
      return;
    }

    switch (indexSidebarSelected.value) {
      case 2:
        mTransController.searchData(searchTec.text.trim());
        break;
      case 3:
        mUserController.searchData(searchTec.text.trim());
        break;
      default:
        mProductController.searchData(searchTec.text);
    }
  }

  void setDataTable() {
    switch (indexSidebarSelected.value) {
      case 2:
        mTransController.refreshData();
        break;
      case 3:
        mUserController.refreshData();
        break;
      default:
        mProductController.refreshData();
    }
  }

  @override
  void onInit() async {
    final result = await pref.readCache();

    if (result[0] == null) {
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
      return;
    }

    username.value = result[0];
    userRole.value = result[1];

    super.onInit();
  }
}
