import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_product.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_transaction.dart';
import 'package:projectka_pos/core/constant/color.constant.dart';

class DialogUtil {
  // Add Product
  static void showDialogAddProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogFormProduct(
        titleForm: 'Tambah Produk',
      ),
    );
  }

  static void showDialogAddTransaction(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogFormTransaction(),
    );
  }

  static dialogErrorFromFirebase(int errCode) {
    return Get.defaultDialog(
      contentPadding: const EdgeInsets.all(32),
      title: 'Kesalahan ${errCode.hashCode.toString()}',
      middleText: 'Terjadi kesalahan tak terduga, silahkan coba kembali nanti',
      textConfirm: 'Ok',
      buttonColor: ColorConstant.primaryColor,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  static dialogSearchNotFound(String collection) {
    return Get.defaultDialog(
      contentPadding: const EdgeInsets.all(32),
      title: 'Pencarian',
      middleText: 'Tidak ditemukan data $collection dengan keyword tersebut.',
      textConfirm: 'Ok',
      buttonColor: ColorConstant.primaryColor,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
