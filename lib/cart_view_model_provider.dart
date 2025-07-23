import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/cart_model.dart';
import 'package:candy_store/cart_state.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:flutter/material.dart';

class CartViewModelProvider extends ChangeNotifier {
  final CartModel _cartModel = CartModel();

  CartViewModelProvider() {
    _cartModel.cartInfoStream.listen((cartInfo) {
      _state = _state.copyWith(
        items: cartInfo.items,
        totalPrice: cartInfo.totalPrice,
        totalItems: cartInfo.totalItems,
        isProcessing: false,
        error: null,
      );
      notifyListeners();
    });
  }

  CartState _state = const CartState(
    items: {},
    totalPrice: 0,
    totalItems: 0,
    isProcessing: false,
    error: null,
  );

  CartState get state => _state;

  Future<void> addToCart(ProductListItem item) async {
    try {
      _state = _state.copyWith(isProcessing: true);
      notifyListeners();
      await _cartModel.addToCart(item);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (e) {
      _state = _state.copyWith(error: e);
    }
      notifyListeners();
  }

  Future<void> removeFromCart(CartListItem item) async {
    try {
      _state = _state.copyWith(isProcessing: true);
      notifyListeners();
      await _cartModel.removeFromCart(item.product);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (e) {
      _state = _state.copyWith(error: e);
    }
      notifyListeners();
  }

  void cleanError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }

  @override
  void dispose() {
    _cartModel.dispose();
    super.dispose();
  }  
}
