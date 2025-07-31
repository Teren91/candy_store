import 'package:candy_store/product_list_item.dart';

abstract interface class ProductRepositoryInterface {
  Future<List<ProductListItem>> fetchProduct();
  ProductListItem? fetchProductById(String id);
  void addProduct(ProductListItem product);
  void removeProduct(ProductListItem product);
  void updateProduct(ProductListItem product);
}

class ProductRepository implements ProductRepositoryInterface {
  final List<ProductListItem> _products = [
    ProductListItem(id: '1', name: 'Candy', description: 'A sweet treat', price: 1, imageUrl: 'https://example.com/candy.jpg'),
    ProductListItem(id: '2', name: 'Chocolate', description: 'A dark treat', price: 2, imageUrl: 'https://example.com/chocolate.jpg'),
    ProductListItem(id: '3', name: 'Gummy Bears', description: 'A sweet treat', price: 3, imageUrl: 'https://example.com/gummy-bears.jpg'),
  ];

  List<ProductListItem> get products => _products;

  @override
  ProductListItem? fetchProductById(String id) {
    return _products.firstWhere((product) => product.id == id, orElse: () => throw Exception('Product not found'));
  }

  @override
  Future<List<ProductListItem>> fetchProduct() async {
    return _products;
  }

  @override
  void addProduct(ProductListItem product) {
    _products.add(product);
  }

  @override
  void removeProduct(ProductListItem product) {
    _products.remove(product);
  }

  @override
  void updateProduct(ProductListItem product) {
    final index = _products.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }
}
