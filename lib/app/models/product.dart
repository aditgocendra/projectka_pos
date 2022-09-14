import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectka_pos/core/utils/string.util.dart';

class ProductModel {
  String productName;
  int price;
  int stock;
  int sold;
  Timestamp createdAt;
  List<String>? searchKeyword;
  String? idDocument;

  ProductModel({
    required this.productName,
    required this.price,
    required this.stock,
    required this.sold,
    required this.createdAt,
    this.searchKeyword,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      productName: data?['productName'],
      price: data?['price'],
      stock: data?['stock'],
      sold: data?['sold'],
      createdAt: data?['createdAt'],
      searchKeyword: data?['searchKeyword'] is Iterable
          ? List.from(data?['searchKeyword'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "productName": productName,
      "price": price,
      "stock": stock,
      "sold": sold,
      "createdAt": createdAt,
      if (searchKeyword != null) "searchKeyword": searchKeyword,
    };
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return StringUtil.rupiahFormat(price);
      case 2:
        return '${stock.toString()} Unit';
      case 3:
        return '${sold.toString()} Unit';
      default:
        return '';
    }
  }
}
