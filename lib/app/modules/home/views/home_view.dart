import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/views/content/dashboard.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_product.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_transaction.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_user.dart';
import 'package:projectka_pos/app/modules/home/views/widgets/head_content.dart';
import 'package:projectka_pos/app/modules/home/views/widgets/rightbar.dart';
import 'package:projectka_pos/app/modules/home/views/widgets/sidebar.dart';
import 'package:projectka_pos/core/constant/sidebar.constant.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: ListView(
                controller: ScrollController(),
                children: [
                  Obx(
                    () {
                      String hintText;

                      switch (controller.indexSidebarSelected.value) {
                        case 2:
                          hintText = 'Cari Transaksi';
                          break;
                        case 3:
                          hintText = 'Cari Pengguna';
                          break;
                        default:
                          hintText = 'Cari Produk';
                      }
                      return HeaderContent(
                        title: SidebarConstantData.listMenuDashboard[
                            controller.indexSidebarSelected.value]['title'],
                        screenSizeWidth: screenSize,
                        hintText: hintText,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Content
                  Obx(
                    () {
                      Widget content;
                      switch (controller.indexSidebarSelected.value) {
                        case 1:
                          content = ManageProduct();
                          break;
                        case 2:
                          content = ManageTransaction();
                          break;
                        case 3:
                          content = ManageUser();
                          break;
                        default:
                          content = Dashboard();
                      }
                      return content;
                    },
                  )
                ],
              ),
            ),
          ),
          if (screenSize > 652)
            Expanded(
              child: Rightbar(),
            ),
        ],
      ),
    );
  }
}
