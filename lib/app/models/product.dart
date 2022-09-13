import 'package:cloud_firestore/cloud_firestore.dart';

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
        return 'code product';
      case 1:
        return productName;
      case 2:
        return price.toString();
      case 3:
        return stock.toString();
      default:
        return '';
    }
  }
}

final productData = [
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    sold: 10,
    searchKeyword: ['asd'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    sold: 10,
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    sold: 10,
    searchKeyword: ['asd'],
    createdAt: Timestamp.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    sold: 10,
    searchKeyword: ['asd'],
    createdAt: Timestamp.now(),
  )
];
