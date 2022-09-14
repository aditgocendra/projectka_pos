import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectka_pos/app/models/transaction.dart';
import 'package:projectka_pos/services/firebase/firestore.service.dart';
import 'package:unicons/unicons.dart';

class DashboardController extends GetxController {
  final isLoadingLastTransaction = false.obs;

  ScrollController scrollHorizontalTable = ScrollController();

  List<Map<String, dynamic>> listHeadDashboard = [
    {
      'title': 'Jumlah Transaksi',
      'icon': UniconsLine.transaction,
      'value': 0,
    },
    {
      'title': 'Jumlah Produk',
      'icon': UniconsLine.box,
      'value': 0,
    },
    {
      'title': 'Jumlah Pengguna',
      'icon': UniconsLine.user_circle,
      'value': 0,
    }
  ];

  List<TransactionModel> listLastTransaction = [];

  // Transaction Data
  void streamAllTransactionData() {
    FirestoreService.refTransaction
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      listHeadDashboard[0]['value'] = 0;
      listLastTransaction.clear();

      if (event.docs.isEmpty) {
        return;
      }

      // Set Transaction
      listHeadDashboard[0]['value'] = event.docs.length;

      for (var doc in event.docs) {
        TransactionModel transactionModel = TransactionModel(
          totalPay: doc['totalPay'],
          createdAt: doc['createdAt'],
        );
        transactionModel.idDocument = doc.id;
        listLastTransaction.add(transactionModel);
      }
      update();
    });
  }

  // Product Data
  void streamAllProductData() {
    FirestoreService.refProduct
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      listHeadDashboard[1]['value'] = 0;

      if (event.docs.isEmpty) {
        return;
      }

      // Set Product
      listHeadDashboard[1]['value'] = event.docs.length;
      update();
    });
  }

  // User Data
  void streamAllUserData() {
    FirestoreService.refUsers
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      listHeadDashboard[2]['value'] = 0;

      if (event.docs.isEmpty) {
        return;
      }

      // Set User
      listHeadDashboard[2]['value'] = event.docs.length;
      update();
    });
  }

  @override
  void onInit() {
    streamAllProductData();
    streamAllTransactionData();
    streamAllUserData();
    super.onInit();
  }
}
