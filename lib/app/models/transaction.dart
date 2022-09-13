import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  int totalPay;
  Timestamp createdAt;
  String? idDocument;

  TransactionModel({
    required this.totalPay,
    required this.createdAt,
  });

  TransactionModel.fromJson(Map<String, Object?> json)
      : this(
          totalPay: json['totalPay']! as int,
          createdAt: json['createdAt']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'totalPay': totalPay,
      'createdAt': createdAt,
    };
  }
}
