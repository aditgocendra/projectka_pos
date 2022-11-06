import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/home_controller.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/constant/sidebar.constant.dart';
import 'package:unicons/unicons.dart';

class Sidebar extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final menuDashboard = SidebarConstantData.listMenuDashboard;
  Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 768) {
      controller.isSidebarExpanded.value = true;
    } else {
      controller.isSidebarExpanded.value = false;
    }

    return Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: controller.isSidebarExpanded.value ? 220 : 80,
        ),
        child: Drawer(
          elevation: 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuDashboard.length,
                  itemBuilder: (context, index) => WidgetMenu(
                    title: menuDashboard[index]['title'],
                    icon: menuDashboard[index]['icon'],
                    index: index,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    controller.isSidebarExpanded.toggle();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      controller.isSidebarExpanded.value
                          ? UniconsLine.angle_left
                          : UniconsLine.angle_right,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: 'Keluar Aplikasi',
                      middleText: 'Apakah kamu yakin ingin keluar aplikasi ?',
                      textConfirm: 'Ya',
                      textCancel: 'Tidak',
                      buttonColor: ColorConstant.primaryColor,
                      confirmTextColor: Colors.white,
                      cancelTextColor: ColorConstant.primaryColor,
                      onConfirm: () {
                        Get.back();
                        controller.logout();
                      },
                      onCancel: () => Get.back(),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      UniconsLine.sign_out_alt,
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetMenu extends StatelessWidget {
  String title;
  IconData icon;
  int index;
  final homeController = Get.find<HomeController>();

  WidgetMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeController.userRole.value == 'Kasir' && index == 1) {
      return Container();
    }

    if (homeController.userRole.value == 'Admin' && index == 2) {
      return Container();
    }
    if (homeController.userRole.value == 'Kasir' && index == 3) {
      return Container();
    }
    return Obx(
      () {
        return Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: index == homeController.indexSidebarSelected.value
                ? Colors.white60
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
            () {
              Widget widget;

              if (homeController.isSidebarExpanded.value) {
                widget = ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    homeController.indexSidebarSelected.value = index;
                    homeController.setDataTable();
                  },
                  leading: Icon(
                    icon,
                    size: 20,
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              } else {
                widget = InkWell(
                  onTap: () {
                    homeController.indexSidebarSelected.value = index;
                    homeController.setDataTable();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 18,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          title,
                          style: const TextStyle(fontSize: 8.5),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return widget;
            },
          ),
        );
      },
    );
  }
}
