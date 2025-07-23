import 'package:candy_store/cart_event.dart';
import 'package:candy_store/cart_info.dart';
import 'package:candy_store/cart_model.dart';
import 'package:candy_store/cart_state.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState> {
  final CartModel _cartModel = CartModel();

  CartBloc()
    : super (
      const CartState(
        items: {},
        totalPrice: 0,
        totalItems: 0,
        isProcessing: false
      ),
    ) {
        on<Load>(_onLoad);
        on<AddItem>(_onAddItem);
        on<RemoveItem>(_onRemoveItem);
        on<ClearError>(_onClearError);
        }
     

    Future<void> _onLoad(Load event, Emitter emit) async {
      try{
        emit(state.copyWith(isProcessing: true));
        final cartInfo = await _cartModel.cartInfoFuture;

        emit(
          state.copyWith(
            items: cartInfo.items,
            totalPrice: cartInfo.totalPrice,
            totalItems: cartInfo.totalItems,
          ),
        );
        emit(state.copyWith(isProcessing: false));
        await emit.onEach(
          _cartModel.cartInfoStream, 
          onData: (CartInfo cartInfo) {
            emit(
              state.copyWith(
                items: cartInfo.items,
                totalPrice: cartInfo.totalPrice,
                totalItems: cartInfo.totalItems,
              )
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            emit(
              state.copyWith(error: Exception('Failed to load cart info')));
          },
        );

      } on Exception catch(e) {
        emit(state.copyWith(error: e));
      }
    }

    Future<void> _onAddItem(AddItem event, Emitter emit) async {
      try {
        emit(state.copyWith(isProcessing: true));
        final cartInfo = await _cartModel.cartInfoFuture;

        emit(
          state.copyWith(
            items: cartInfo.items,
            totalPrice: cartInfo.totalPrice,
            totalItems: cartInfo.totalItems,
          ),
        );
        emit(state.copyWith(isProcessing: false));
        await emit.forEach(
          _cartModel.cartInfoStream, 
          onData: (CartInfo cartInfo) {
            emit(
              state.copyWith(
                items: cartInfo.items,
                totalPrice: cartInfo.totalPrice,
                totalItems: cartInfo.totalItems,
              )
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            emit(
              state.copyWith(error: Exception('Failed to add item to cart'))
            );
          },
        );
      } on Exception catch (e) {
        emit(state.copyWith(error: e));
      }
    }

    Future<void> _onRemoveItem(RemoveItem event, Emitter emit) async {
      try {
        emit(state.copyWith(isProcessing: true));
        final cartInfo = await _cartModel.cartInfoFuture;

        emit(
          state.copyWith(
            items: cartInfo.items,
            totalPrice: cartInfo.totalPrice,
            totalItems: cartInfo.totalItems,
          ),
        );
        emit(state.copyWith(isProcessing: false));
        await emit.forEach(
          _cartModel.cartInfoStream, 
          onData: (CartInfo cartInfo) {
            emit(
              state.copyWith(
                items: cartInfo.items,
                totalPrice: cartInfo.totalPrice,
                totalItems: cartInfo.totalItems,
              )
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            emit(
              state.copyWith(error: Exception('Failed to add item to cart'))
            );
          },
        );
      } on Exception catch (e) {
        emit(state.copyWith(error: e));
      }
    }

    void _onClearError(ClearError event, Emitter emit) {
      emit(state.copyWith(error: null));
    }

    @override
    Future<void> close() async {
      _cartModel.dispose();
      super.close();
    }
}