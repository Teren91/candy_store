import 'package:candy_store/cart_view_model.dart';
import 'package:flutter/material.dart';

class CartViewModelProvider extends InheritedWidget {
  final CartViewModel cartViewModel;

  const CartViewModelProvider ({
    super.key,
    required this.cartViewModel,
    required super.child,
    });
  
  static CartViewModel of (BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<CartViewModelProvider>();
    if (provider == null) {
      throw Exception('CartViewModelProvider not found');
    }
    return provider.cartViewModel;
  }

  static CartViewModel read(BuildContext context) {
    final provider = context.getInheritedWidgetOfExactType<CartViewModelProvider>();
    if (provider == null) {
      throw Exception('CartViewModelProvider not found');
    }
    return (provider).cartViewModel;
  }

  @override
  bool updateShouldNotify(CartViewModelProvider oldWidget){
    return cartViewModel != oldWidget.cartViewModel;
  }
 
}
