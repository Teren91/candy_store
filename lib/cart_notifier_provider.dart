import 'package:candy_store/cart_view_model_provider.dart';
import 'package:flutter/material.dart';

class CartProvider extends InheritedWidget {
  final CartViewModelProvider cartViewModel;

  const CartProvider({
    super.key,
    required this.cartViewModel,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant CartProvider oldWidget) {
    return cartViewModel != oldWidget.cartViewModel;
  }

  static CartViewModelProvider of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<CartProvider>()!
        .cartViewModel;

    return provider;
  }
  
}
