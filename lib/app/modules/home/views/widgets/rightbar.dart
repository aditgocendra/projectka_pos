import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_product_controller.dart';
import 'package:projectka_pos/app/modules/home/controllers/manage_transaction_controller.dart';
import 'package:projectka_pos/app/routes/app_pages.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';
import 'package:projectka_pos/core/constant/rightbar.constant.dart';
import 'package:projectka_pos/core/utils/dialog.util.dart';

class Rightbar extends StatelessWidget {
  final mProductController = Get.find<ManageProductController>();
  final mTransController = Get.find<ManageTransactionController>();
  Rightbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          controller: ScrollController(),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24, right: 24, top: 24),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/avatar/ava_female.png',
                      width: 64,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (constraints.maxWidth > 128)
                      const Text(
                        'Tria Hutagalung',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (constraints.maxWidth > 128)
                      ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            contentPadding: const EdgeInsets.all(16),
                            title: 'Keluar Aplikasi',
                            middleText:
                                'Apakah kamu yakin ingin keluar aplikasi ?',
                            textConfirm: 'Ya',
                            textCancel: 'Tidak',
                            buttonColor: ColorConstant.primaryColor,
                            confirmTextColor: Colors.white,
                            cancelTextColor: ColorConstant.primaryColor,
                            onConfirm: () {
                              Get.back();
                              Get.toNamed(Routes.LOGIN);
                            },
                            onCancel: () => Get.back(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          elevation: 0.5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          minimumSize: const Size.fromHeight(40),
                        ),
                        child: const Text(
                          'Keluar',
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 24, right: 24),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Aksi Cepat',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: RightbarConstant.actionList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (constraints.maxWidth > 172) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorConstant.backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    DialogUtil.showDialogAddProduct(context);
                                    break;
                                  case 1:
                                    DialogUtil.showDialogAddTransaction(
                                      context,
                                    );
                                    break;
                                  case 2:
                                    mProductController.generateProductDataPdf();
                                    break;
                                  case 3:
                                    DialogUtil.showDialogPdfReport(context);
                                    break;
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(
                                RightbarConstant.actionList[index]['title'],
                                style: const TextStyle(fontSize: 11),
                              ),
                              trailing: Icon(
                                RightbarConstant.actionList[index]['icon'],
                                size: 20,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorConstant.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            RightbarConstant.actionList[index]['icon'],
                            size: 20,
                            color: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
