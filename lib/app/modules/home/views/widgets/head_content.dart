import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/home_controller.dart';
import 'package:unicons/unicons.dart';

class HeaderContent extends StatelessWidget {
  String title;
  String hintText;
  double screenSizeWidth;
  final homeController = Get.find<HomeController>();

  HeaderContent({
    Key? key,
    required this.title,
    required this.screenSizeWidth,
    required this.hintText,
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
            controller: homeController.searchTec,
            style: const TextStyle(fontSize: 12),
            onTap: () {
              // Change Content View
              if (homeController.indexSidebarSelected.value < 2) {
                homeController.indexSidebarSelected.value = 1;
                return;
              }

              homeController.indexSidebarSelected.value =
                  homeController.indexSidebarSelected.value;
            },
            onChanged: (value) {
              if (value.isEmpty) {
                homeController.setDataTable();
              }
            },
            decoration: InputDecoration(
              fillColor: Colors.white60,
              filled: true,
              hintText: hintText,
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
                  onTap: () {
                    homeController.search();
                  },
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
          controller: homeController.searchTec,
          onTap: () {
            // Change Content View
            if (homeController.indexSidebarSelected.value < 2) {
              homeController.indexSidebarSelected.value = 1;
              return;
            }

            homeController.indexSidebarSelected.value =
                homeController.indexSidebarSelected.value;
          },
          onChanged: (value) {
            if (value.isEmpty) {
              homeController.setDataTable();
            }
          },
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            fillColor: Colors.white60,
            filled: true,
            hintText: hintText,
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
                onTap: () {
                  homeController.search();
                },
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
