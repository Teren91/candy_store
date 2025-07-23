import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/cart_list_item_view.dart';
import 'package:candy_store/cart_view_model_provider.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  //final List<CartListItem> items;
  final Function(CartListItem) onRemoveFromCart;
  final Function(CartListItem) onAddToCart;
  final ValueNotifier<Map<String, CartListItem>> items;
  final CartViewModelProvider cartViewModel;

  const CartPage({
    super.key,
    required this.items,
    required this.onRemoveFromCart,
    required this.onAddToCart,
    required this.cartViewModel,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartViewModelProvider _cartViewModel;
  @override
  void initState() {
    super.initState();
    _cartViewModel = CartViewModelProvider.read(context);
    _cartViewModel.addListener(_onCartViewModelStateChanged);
  }

  @override
  void dispose() {
    _cartViewModel.dispose();
    super.dispose();
  }

  void _onCartViewModelStateChanged() {
    if (_cartViewModel.state.error != null) {
      _cartViewModel.cleanError();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to perform this action'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListenableBuilder(
          listenable: _cartViewModel,
          builder: (context, child) {
            if (_cartViewModel.state.isProcessing) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final values = widget.items.value.values.toList();
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: values.length,
                    itemBuilder: (context, index) {
                      final item = values[index];
                      return CartListItemView(
                        item: item,
                        onRemoveFromCart: widget.onRemoveFromCart,
                        onAddToCart: widget.onAddToCart,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.cartViewModel.totalPrice} €',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
