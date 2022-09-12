import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/views/content/dashboard.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_product.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_transaction.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_user.dart';
import 'package:projectka_pos/app/modules/home/views/widgets/rightbar.dart';
import 'package:projectka_pos/app/modules/home/views/widgets/sidebar.dart';
import 'package:projectka_pos/core/constant/sidebar.constant.dart';
import 'package:unicons/unicons.dart';
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
                    () => HeaderContent(
                      title: SidebarConstantData.listMenuDashboard[
                          controller.indexSidebarSelected.value]['title'],
                      screenSizeWidth: screenSize,
                    ),
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
                          content = const ManageTransaction();
                          break;
                        case 3:
                          content = ManageUser();
                          break;
                        default:
                          content = const Dashboard();
                      }
                      return content;
                    },
                  )
                ],
              ),
            ),
          ),
          if (screenSize > 652)
            const Expanded(
              child: Rightbar(),
            ),
        ],
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  String title;
  double screenSizeWidth;

  HeaderContent({
    Key? key,
    required this.title,
    required this.screenSizeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (screenSizeWidth > 550) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'Florist & Gift Solution',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        trailing: SizedBox(
          width: screenSizeWidth / 4.35,
          child: TextField(
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              fillColor: Colors.white60,
              filled: true,
              hintText: 'Pencarian',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              suffixIcon: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(right: 6.0),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    UniconsLine.search_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            fillColor: Colors.white60,
            filled: true,
            hintText: 'Pencarian',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            suffixIcon: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 6.0),
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  UniconsLine.search_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
