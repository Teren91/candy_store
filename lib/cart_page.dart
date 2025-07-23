import 'package:candy_store/cart_bloc.dart';
import 'package:candy_store/cart_event.dart';
import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/cart_list_item_view.dart';
import 'package:candy_store/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  final Function(CartListItem) onRemoveFromCart;
  final Function(CartListItem) onAddToCart;
  final ValueNotifier<Map<String, CartListItem>> items;

  const CartPage({
    super.key,
    required this.items,
    required this.onRemoveFromCart,
    required this.onAddToCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartBloc _cartBloc;
  @override
  void initState() {
    super.initState();
    _cartBloc = context.read<CartBloc>();
    _cartBloc.add(const Load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state){
            if(state.error != null) {
              _cartBloc.add(const ClearError());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to perform this action'),),
              );
            }
          },
          builder: (context, state) {
            if (state.isProcessing!) {
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
                          '${_cartBloc.state.totalPrice} €',
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
