import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/cart_model.dart';
import 'package:candy_store/cart_state.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final CartModel _cartModel = CartModel();

  CartViewModel() {
    _cartModel.cartInfoStream.listen((cartInfo) {
      _items.clear();
      _totalPrice = cartInfo.totalPrice;
      _totalItems = cartInfo.totalItems;
      cartInfo.items.forEach((key, value) {
        _items[key] = value;
      });
      notifyListeners();
    });
  }

  CartState _state = CartState(
    items: {},
    totalPrice: 0,
    totalItems: 0,
    isProcessing: false,
    error: null,
  );

  CartState get state => _state;

  final Map<String, CartListItem> _items = {};
  double _totalPrice = 0;
  int _totalItems = 0;

  List<CartListItem> get items => _items.values.toList();
  double get totalPrice => _totalPrice;
  int get totalItems => _totalItems;

  void addToCart(ProductListItem item) {
    try {
      _state = _state.copyWith(isProcessing: true);
      _cartModel.addToCart(item);
      notifyListeners();
    } on Exception catch (e) {
      _state = _state.copyWith(error: e);
      notifyListeners();
    }
  }

  void removeFromCart(CartListItem item) {
    try {
      _state = _state.copyWith(isProcessing: true);
      _cartModel.removeFromCart(item.product);
      notifyListeners();
    } on Exception catch (e) {
      _state = _state.copyWith(error: e);
      notifyListeners();
    }
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
