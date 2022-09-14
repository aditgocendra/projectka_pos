import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/models/product.dart';
import 'package:projectka_pos/core/utils/dialog.util.dart';
import 'package:projectka_pos/core/utils/functions.dart';
import 'package:projectka_pos/services/firebase/firestore.service.dart';
import 'package:projectka_pos/services/local/pdf_services.dart';

class ManageProductController extends GetxController {
  // isLoading
  final isLoading = false.obs;

  // Error Message
  final errFormMessage = ''.obs;

  // Controller
  ScrollController scrollHorizontalTable = ScrollController();
  TextEditingController nameProductTec = TextEditingController();
  TextEditingController priceTec = TextEditingController();
  TextEditingController codeProductTec = TextEditingController();
  TextEditingController stockProductTec = TextEditingController();

  // Data Product
  List<ProductModel> listProduct = [];

  // Search Data Product
  Future searchData(String keyword) async {
    isLoading.toggle();
    await FirestoreService.refProduct
        .where('searchKeyword', arrayContains: keyword.toLowerCase())
        .get()
        .then((result) {
      if (result.docs.isEmpty) {
        isLoading.toggle();
        DialogUtil.dialogSearchNotFound('produk');

        return;
      }

      listProduct.clear();
      fetchProduct(result);
    });
  }

  // Read Data Product
  Future readProduct() async {
    return await FirestoreService.refProduct.orderBy('createdAt').get();
  }

  // Check Code Product
  Future<bool> checkCodeProduct(String codeProduct) async {
    final result = await FirestoreService.refProduct.doc(codeProduct).get();
    return result.exists;
  }

  // Create Data Product
  Future setProduct() async {
    if (!validationFormProduct()) {
      errFormMessage.value = 'Beberapa form produk masih kosong';
      return;
    }

    final codeProduct = codeProductTec.text.trim();
    final nameProduct = nameProductTec.text.trim();
    final price = priceTec.text.trim();
    final stock = stockProductTec.text.trim();

    final newProduct = ProductModel(
      productName: nameProduct,
      price: int.parse(price),
      stock: int.parse(stock),
      sold: 0,
      createdAt: FirestoreService.timeStamp,
      searchKeyword: Functions.generateSearchKeyword(sentence: nameProduct),
    );

    await FirestoreService.refProduct
        .doc(codeProduct)
        .set(newProduct)
        .then((value) async {
      newProduct.idDocument = codeProduct;

      final product = listProduct
          .where((element) => element.idDocument == codeProduct)
          .toList();

      if (product.isEmpty) {
        // Add new data
        listProduct.add(newProduct);
      } else {
        // Update data
        listProduct[listProduct.indexWhere(
            (element) => element.idDocument == codeProduct)] = newProduct;
      }
      Get.back();
      update();
    }).catchError(
      (err) {
        Get.back();
        DialogUtil.dialogErrorFromFirebase(err);
      },
    );
  }

  // Delete Product Data
  Future deleteDataProduct(String idDoc) async {
    // Delete Product
    await FirestoreService.refProduct.doc(idDoc).delete().then((value) {
      listProduct.removeWhere((product) => product.idDocument == idDoc);
      update();
      Get.back();
    }).catchError(
      (err) {
        Get.back();
        DialogUtil.dialogErrorFromFirebase(err);
      },
    );
  }

  // Refresh Data
  Future refreshData() async {
    isLoading.toggle();
    listProduct.clear();
    final result = await readProduct();
    fetchProduct(result);
  }

  // Generate Data Product PDF
  Future generateProductDataPdf() async {
    List<ProductModel> dataProduct = [];

    final result = await FirestoreService.refProduct.get();

    if (result.docs.isEmpty) {
      return;
    }

    for (var doc in result.docs) {
      ProductModel product = ProductModel(
        productName: doc['productName'],
        price: doc['price'],
        stock: doc['stock'],
        sold: doc['sold'],
        createdAt: doc['createdAt'],
      );
      product.idDocument = doc.id;
      dataProduct.add(product);
    }

    PdfServices.buildPdf(true, dataProduct, '');
  }

  // Validation Form Product
  bool validationFormProduct() {
    if (nameProductTec.text.isEmpty) {
      return false;
    }

    if (priceTec.text.isEmpty) {
      return false;
    }

    if (codeProductTec.text.isEmpty) {
      return false;
    }

    if (stockProductTec.text.isEmpty) {
      return false;
    }

    return true;
  }

  // Reset Editing Controller
  void resetEditingCtl() {
    nameProductTec.clear();
    priceTec.clear();
    codeProductTec.clear();
    stockProductTec.clear();
    errFormMessage.value = '';
  }

  // Fetch Product Data To List Data Product
  void fetchProduct(QuerySnapshot data) {
    for (var doc in data.docs) {
      ProductModel product = ProductModel(
        productName: doc['productName'],
        price: doc['price'],
        stock: doc['stock'],
        sold: doc['sold'],
        createdAt: doc['createdAt'],
        searchKeyword: List<String>.from(doc['searchKeyword']),
      );
      product.idDocument = doc.id;
      listProduct.add(product);
    }
    isLoading.toggle();
    update();
  }
}
