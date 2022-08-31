import 'package:flutter/material.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_product.dart';
import 'package:projectka_pos/app/modules/home/views/content/manage_transaction.dart';

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
}
