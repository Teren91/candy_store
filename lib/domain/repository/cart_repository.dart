import 'package:candy_store/domain/model/cart_info.dart';
import 'package:candy_store/presentation/widget/cart_list_item.dart';
import 'package:candy_store/product_list_item.dart';

abstract interface class CartRepository {
  Stream<CartInfo> get cartInfoStream;
  Future<CartInfo> get cartInfoFuture;
  Future<void> addToCart(ProductListItem item);
  Future<void> removeFromCart(CartListItem item);
}
