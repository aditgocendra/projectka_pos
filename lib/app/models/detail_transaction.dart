class DetailTransactionModel {
  String productName;
  int price;
  int totalBuy;
  String? idDocument;

  DetailTransactionModel({
    required this.productName,
    required this.price,
    required this.totalBuy,
  });

  DetailTransactionModel.fromJson(Map<String, Object?> json)
      : this(
          productName: json['productName']! as String,
          price: json['price']! as int,
          totalBuy: json['totalBuy']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'price': price,
      'totalBuy': totalBuy,
    };
  }
}
