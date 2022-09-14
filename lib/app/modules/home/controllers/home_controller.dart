import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_product_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_user_controller.dart';

class HomeController extends GetxController {
  // Sidebar
  final isSidebarExpanded = true.obs;
  final indexSidebarSelected = 0.obs;

  // Controller
  final mProductController = Get.find<ManageProductController>();
  final mTransController = Get.find<ManageTransactionController>();
  final mUserController = Get.find<ManageUserController>();
  TextEditingController searchTec = TextEditingController();

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
}
