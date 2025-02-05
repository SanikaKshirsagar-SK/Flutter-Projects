import 'package:centralogic_assignment/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;

  const CartState({this.cartItems = const []});

  @override
  List<Object> get props => [cartItems];
  double getSubtotal() {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  double getShippingCharges() {
    return cartItems.isNotEmpty ? 5.0 : 0.0;
  }

  double getTotal() {
    return getSubtotal() + getShippingCharges();
  }

  CartState copyWith({List<CartItem>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}
