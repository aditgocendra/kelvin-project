class ProductModel {
  String? idProduct;
  String productName;
  String idCategory;
  int price;
  int allStock;
  DateTime createdAt;

  ProductModel({
    required this.productName,
    required this.price,
    required this.allStock,
    required this.idCategory,
    required this.createdAt,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return idCategory;
      case 2:
        return price.toString();
      case 3:
        return allStock.toString();
      default:
        return '';
    }
  }
}

final productData = [
  ProductModel(
    productName: '3 Seconds Bundle',
    price: 50000,
    allStock: 80,
    idCategory: 'Bundaran',
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'Tersesiuds',
    price: 50000,
    allStock: 80,
    idCategory: 'Baju Tidur',
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'Black Market',
    price: 50000,
    allStock: 80,
    idCategory: 'Baju Main',
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'Ntah Apa ini',
    price: 50000,
    allStock: 80,
    idCategory: 'Apa tah apa',
    createdAt: DateTime.now(),
  ),
  ProductModel(
    productName: 'Ntah Apa ini',
    price: 50000,
    allStock: 80,
    idCategory: 'Ntah',
    createdAt: DateTime.now(),
  )
];
