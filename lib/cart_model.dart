import 'dart:async';

import 'package:candy_store/cart_info.dart';
import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/product_list_item.dart';

class CartModel {
  final CartInfo _cartInfo = CartInfo(
    items: {},
    totalPrice: 0,
    totalItems: 0,
  );

  CartInfo get cartInfo => _cartInfo;

  final StreamController<CartInfo> _cartInfoController =
      StreamController<CartInfo>();

  Stream<CartInfo> get cartInfoStream => _cartInfoController.stream;
  Future<CartInfo> get cartInfoFuture async => _cartInfo;

  Future<void> addToCart(ProductListItem item) async {
    await Future.delayed(const Duration(seconds: 2));
    _cartInfo.items[item.id] = CartListItem(
      product: item,
      quantity: 1,
    );
    _cartInfo.totalPrice += item.price;
    _cartInfo.totalItems += 1;
    _cartInfoController.add(_cartInfo);
  }

  Future<void> removeFromCart(ProductListItem item) async {
    await Future.delayed(const Duration(seconds: 2));
    _cartInfo.items.remove(item.id);
    _cartInfo.totalPrice -= item.price;
    _cartInfo.totalItems -= 1;
    _cartInfoController.add(_cartInfo);
  }

  void dispose() {
    _cartInfoController.close();
  }
}
