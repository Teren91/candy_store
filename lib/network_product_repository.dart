import 'package:candy_store/api_service.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:candy_store/product_repository.dart';

class NetworkProductRepository implements ProductRepository{
import 'package:candy_store/product.dart';
import 'package:candy_store/product_repository.dart';

class NetworkProductRepository implements ProductRepository {
  NetworkProductRepository(this._apiService);

  final ApiService _apiService;

  @override
  Future<List<ProductListItem>> fetchProduct() async {
    return _apiService.fetchProducts();
  }

  @override
  ProductListItem? fetchProductById(String id) {
    throw UnimplementedError();
  }

  @override
  void addProduct(ProductListItem product) {
    throw UnimplementedError();
  }

  @override
  void removeProduct(ProductListItem product) {
    throw UnimplementedError();
  }

  @override
  void updateProduct(ProductListItem product) {
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement products
  List<ProductListItem> get products => throw UnimplementedError();
}
  Future<List<Product>> fetchProducts() {
    return _apiService.fetchProducts();
  }
}
