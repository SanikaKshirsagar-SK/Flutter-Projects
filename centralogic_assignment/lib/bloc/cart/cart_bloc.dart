import 'package:centralogic_assignment/models/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      List<CartItem> updatedCart = List.from(state.cartItems);
      int existingIndex =
          updatedCart.indexWhere((item) => item.product.id == event.product.id);

      if (existingIndex != -1) {
        updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
          quantity: updatedCart[existingIndex].quantity + 1,
        );
      } else {
        updatedCart.add(CartItem(product: event.product, quantity: 1));
      }
      emit(state.copyWith(cartItems: updatedCart));
    });

    on<RemoveFromCart>((event, emit) {
      List<CartItem> updatedCart = List.from(state.cartItems);
      int existingIndex =
          updatedCart.indexWhere((item) => item.product.id == event.product.id);

      if (existingIndex != -1) {
        if (updatedCart[existingIndex].quantity > 1) {
          updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
            quantity: updatedCart[existingIndex].quantity - 1,
          );
        } else {
          updatedCart.removeAt(existingIndex);
        }
      }

      emit(state.copyWith(cartItems: updatedCart));
    });

    on<ClearCart>((event, emit) {
      emit(const CartState(cartItems: []));
    });
  }
}
