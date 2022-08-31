class ProductModel {
  String? idProduct;
  String productName;
  int price;
  int stock;
  DateTime createdAt;

  ProductModel({
    required this.productName,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

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
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'productName',
    price: 50000,
    stock: 50,
    createdAt: DateTime.now(),
  )
];
