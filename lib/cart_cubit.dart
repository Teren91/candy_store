import 'package:candy_store/cart_model.dart';
import 'package:candy_store/cart_state.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartModel _cartModel = CartModel();

  CartCubit()
    : super (
      const CartState(
        items: {},
        totalPrice: 0,
        totalItems: 0,
        isProcessing: false
      ),
    ) {
      _cartModel.cartInfoStream.listen(
        (cartInfo) {
          emit ( 
            state.copyWith(
              items: cartInfo.items,
              totalPrice: cartInfo.totalPrice,
              totalItems: cartInfo.totalItems,
            ),
          );
        },
      );
    }

    Future<void> loadCart() async {
      try{
        emit(state.copyWith(isProcessing: true));
        final cartInfo = await _cartModel.cartInfoFuture;

        emit(
          state.copyWith(
            items: cartInfo.items,
            totalPrice: cartInfo.totalPrice,
            totalItems: cartInfo.totalItems,
            isProcessing: true,
          ),
        );
      } on Exception catch(e) {
        emit(state.copyWith(error: e));
      }
    }

    Future<void> addToCart(ProductListItem item) async {
      try {
        emit(state.copyWith(isProcessing: true));
        await _cartModel.addToCart(item);
        emit(state.copyWith(isProcessing: false));
      } on Exception catch (e) {
        emit(state.copyWith(error: e));
      }
    }

    Future<void> removeFromCart(ProductListItem item) async {
      try {
        emit(state.copyWith(isProcessing: true));
        await _cartModel.removeFromCart(item);
        emit(state.copyWith(isProcessing: false));
      } on Exception catch (e) {
        emit(state.copyWith(error: e));
      }
    }

    void clearError() {
      emit(state.copyWith(error: null));
    }

    @override
    Future<void> close() async {
      _cartModel.dispose();
      super.close();
    }
}