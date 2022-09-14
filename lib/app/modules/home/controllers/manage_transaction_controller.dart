import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projectka_pos/app/models/detail_transaction.dart';
import 'package:projectka_pos/app/models/product.dart';
import 'package:projectka_pos/app/models/transaction.dart';
import 'package:projectka_pos/core/utils/dialog.util.dart';
import 'package:projectka_pos/services/firebase/firestore.service.dart';
import 'package:projectka_pos/services/local/pdf_services.dart';

class ManageTransactionController extends GetxController {
  // Loading
  final isLoadingGetProduct = false.obs;
  final isLoadingTableData = false.obs;
  final isLoadingReportPdf = false.obs;

  // Range Picker Pdf Report
  List<DateTime?> initRangeDatePicker = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 10)),
  ];

  List<DateTime?> datePickRangeTrans = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 10)),
  ];

  // Controller
  ScrollController scrollHorizontalCtl = ScrollController();
  TextEditingController codeProductTec = TextEditingController();

  // Total Payment
  final totalPay = 0.obs;

  // Error message form
  final errorMessageForm = ''.obs;
  final errorMessageReport = ''.obs;

  //Transaction
  List<Map<String, dynamic>> listProductForm = [];
  List<TransactionModel> listDataTable = [];

  // Dialog Detail Transaction Data
  final codeTrans = ''.obs;
  final totalPayTransDetail = 0.obs;
  List<DetailTransactionModel> listDetailTransDialog = [];

  // Search Data Product
  Future searchData(String keyword) async {
    isLoadingTableData.toggle();

    await FirestoreService.refTransaction
        .doc(keyword)
        .get()
        .then((result) async {
      if (!result.exists) {
        isLoadingTableData.toggle();
        DialogUtil.dialogSearchNotFound('transaksi');
        return;
      }

      listDataTable.clear();
      TransactionModel transactionModel = TransactionModel(
        totalPay: result['totalPay'],
        createdAt: result['createdAt'],
      );

      transactionModel.idDocument = result.id;
      listDataTable.add(transactionModel);
      isLoadingTableData.toggle();
      update();
    });
  }

  // Read All Data Transaction
  Future<QuerySnapshot> readAllTransaction() async {
    return await FirestoreService.refTransaction.get();
  }

  // Create Transaction
  Future createTransaction() async {
    if (listProductForm.isEmpty) {
      errorMessageForm.value = 'Belum Ada Satupun Produk';
      return;
    }

    // Check Product Stock Available Or Not
    final stockIsAvailable = await checkStockProduct();

    if (!stockIsAvailable) {
      return;
    }

    String codeTransaction = generateCodeTransaction();

    TransactionModel transaction = TransactionModel(
      totalPay: totalPay.value,
      createdAt: FirestoreService.timeStamp,
    );

    await FirestoreService.refTransaction
        .doc(codeTransaction)
        .set(transaction)
        .then((value) async {
      transaction.idDocument = codeTransaction;
      listDataTable.add(transaction);

      for (var i = 0; i < listProductForm.length; i++) {
        ProductModel productModel = listProductForm[i]['product'];
        int totalProductBuy = listProductForm[i]['totalBuy'];

        DetailTransactionModel detailTransaction = DetailTransactionModel(
          productName: productModel.productName,
          price: productModel.price,
          totalBuy: totalProductBuy,
        );

        await createDetailTransaction(
          detailTransaction,
          codeTransaction,
          productModel.idDocument!,
        );

        productModel.sold = productModel.sold + totalProductBuy;
        productModel.stock = productModel.stock - totalProductBuy;
        await updateProduct(productModel);
      }
    }).catchError((err) => DialogUtil.dialogErrorFromFirebase(err));

    update();
    Get.back();
  }

  Future updateProduct(ProductModel productModel) async {
    // Update Sold Product
    await FirestoreService.refProduct
        .doc(productModel.idDocument)
        .set(productModel);
  }

  // Check Stock Product
  Future<bool> checkStockProduct() async {
    for (var i = 0; i < listProductForm.length; i++) {
      final result = await FirestoreService.refProduct
          .doc(listProductForm[i]['product'].idDocument)
          .get();

      final stock = result.data()!.stock;

      if (stock < listProductForm[i]['totalBuy']) {
        errorMessageForm.value =
            'Stok Produk ${listProductForm[i]['product'].productName} Kurang Dari Jumlah Pembelian';
        return false;
      }
    }
    return true;
  }

  // Create Detail transaction
  Future createDetailTransaction(
    DetailTransactionModel dt,
    String idDoc,
    String productId,
  ) async {
    await FirestoreService.refSubCollectionDetailTransaction(
            idDoc: idDoc,
            collection: 'transactions',
            subCollectionPath: 'detail_transactions')
        .doc(productId)
        .set(dt);
  }

  // Delete Transaction
  Future deleteTransaction(String docId) async {
    final result = await FirestoreService.refSubCollectionDetailTransaction(
            idDoc: docId,
            collection: 'transactions',
            subCollectionPath: 'detail_transactions')
        .get();

    for (var doc in result.docs) {
      await doc.reference.delete();
    }

    await FirestoreService.refTransaction.doc(docId).delete().then((value) {
      listDataTable.removeWhere((trans) => trans.idDocument == docId);
      update();
      Get.back();
    }).catchError((err) {
      Get.back();
      DialogUtil.dialogErrorFromFirebase(err);
    });
  }

  // Set Dialog Detail Transaction
  Future setDialogDetailTransaction(TransactionModel transaction) async {
    codeTrans.value = transaction.idDocument!;
    totalPayTransDetail.value = transaction.totalPay;

    listDetailTransDialog.clear();

    final result = await FirestoreService.refSubCollectionDetailTransaction(
      collection: 'transactions',
      idDoc: codeTrans.value,
      subCollectionPath: 'detail_transactions',
    ).get();

    for (var doc in result.docs) {
      DetailTransactionModel detailTransactionModel = DetailTransactionModel(
        productName: doc['productName'],
        price: doc['price'],
        totalBuy: doc['totalBuy'],
      );

      detailTransactionModel.idDocument = doc.id;
      listDetailTransDialog.add(detailTransactionModel);
    }

    update();
  }

  // Add Product Form
  Future addProductForm() async {
    String codeProduct = codeProductTec.text.trim();
    if (codeProduct.isEmpty) {
      errorMessageForm.value = 'Field kode produk kosong';
      return;
    }

    if (listProductForm.isNotEmpty) {
      final productData = listProductForm
          .where((element) => element['product'].idDocument == codeProduct);
      if (productData.isNotEmpty) {
        errorMessageForm.value = 'Produk telah tersedia';
        return;
      }
    }

    final resultProduct =
        await FirestoreService.refProduct.doc(codeProduct).get();

    if (!resultProduct.exists) {
      errorMessageForm.value = 'Produk tidak ditemukan';
      return;
    }

    // Product Data
    ProductModel product = ProductModel(
      productName: resultProduct.get('productName'),
      price: resultProduct.get('price'),
      stock: resultProduct.get('stock'),
      sold: resultProduct.get('sold'),
      searchKeyword: List<String>.from(resultProduct.get('searchKeyword')),
      createdAt: resultProduct.get('createdAt'),
    );
    product.idDocument = codeProduct;

    // Add Form Product
    listProductForm.add({'product': product, 'totalBuy': 1});
    updateTotalPay();
    update();
  }

  // Refresh Data
  Future refreshData() async {
    isLoadingTableData.toggle();
    listDataTable.clear();
    final result = await readAllTransaction();
    fetchTransaction(result);
  }

  // Generate PDF Transaction
  Future generatePdfTransaction() async {
    if (datePickRangeTrans.isEmpty || datePickRangeTrans.length <= 1) {
      errorMessageReport.value = 'Rentang tanggal belum dipilih';
      return;
    }
    isLoadingReportPdf.toggle();

    // Get Transaction Data
    await FirestoreService.refTransaction
        .orderBy('createdAt')
        .where('createdAt', isGreaterThanOrEqualTo: datePickRangeTrans[0])
        .where('createdAt', isLessThanOrEqualTo: datePickRangeTrans[1])
        .get()
        .then((result) async {
      if (result.docs.isEmpty) {
        isLoadingReportPdf.toggle();
        errorMessageReport.value =
            'Tidak ada transaksi di rentang tanggal tersebut';
        return;
      }
      List<TransactionReport> listReportTransaction = [];

      for (var docTrans in result.docs) {
        TransactionReport transReport;

        // Detail Transaction
        final result = await FirestoreService.refSubCollectionDetailTransaction(
          idDoc: docTrans.id,
          collection: 'transactions',
          subCollectionPath: 'detail_transactions',
        ).get();

        List<DetailTransactionModel> listDetailTrans = [];

        for (var docDetailTrans in result.docs) {
          DetailTransactionModel detailTrans = DetailTransactionModel(
            productName: docDetailTrans['productName'],
            price: docDetailTrans['price'],
            totalBuy: docDetailTrans['totalBuy'],
          );

          detailTrans.idDocument = docDetailTrans.id;
          listDetailTrans.add(detailTrans);
        }

        transReport = TransactionReport(
          codeTransaction: docTrans.id,
          detailTrans: listDetailTrans,
          dateTransaction: docTrans['createdAt'],
          totalPay: docTrans['totalPay'],
        );

        listReportTransaction.add(transReport);
      }

      String fromToDate =
          '${DateFormat.yMd().format(datePickRangeTrans[0]!)} - ${DateFormat.yMd().format(datePickRangeTrans[1]!)}';

      await PdfServices.buildPdf(false, listReportTransaction, fromToDate);
      isLoadingReportPdf.toggle();
      Get.back();
    }).catchError((err) {
      isLoadingReportPdf.toggle();
      Get.back();
      DialogUtil.dialogErrorFromFirebase(err);
    });
  }

  // Generate Code Transaction
  String generateCodeTransaction() {
    DateTime dateTimeNow = DateTime.now();
    String date = DateFormat.yMd().format(dateTimeNow).replaceAll('/', '-');
    String time = DateFormat.Hms().format(dateTimeNow).replaceAll(':', '-');

    return 'TR-PJ-$date-$time';
  }

  // Update Total Payment
  void updateTotalPay() {
    if (listProductForm.isEmpty) {
      totalPay.value = 0;
      return;
    }

    double price = 0;

    for (var i = 0; i < listProductForm.length; i++) {
      price +=
          listProductForm[i]['product'].price * listProductForm[i]['totalBuy'];
    }

    totalPay.value = price.toInt();
  }

  // Remove Value || Form
  void removeValueProductForm(int index) {
    if (listProductForm[index]['totalBuy'] > 1) {
      listProductForm[index]['totalBuy'] -= 1;
    } else {
      listProductForm.removeAt(index);
    }
    updateTotalPay();
    update();
  }

  // Reset Form Product
  void resetFormProduct() {
    errorMessageForm.value = '';
    listProductForm.clear();
    codeProductTec.clear();
  }

  // Fetch Transaction
  void fetchTransaction(QuerySnapshot data) {
    for (var doc in data.docs) {
      TransactionModel transactionModel = TransactionModel(
        totalPay: doc['totalPay'],
        createdAt: doc['createdAt'],
      );
      transactionModel.idDocument = doc.id;
      listDataTable.add(transactionModel);
    }
    isLoadingTableData.toggle();
    update();
  }
}
