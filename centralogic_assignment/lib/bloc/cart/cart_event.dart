import 'package:centralogic_assignment/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;

  AddToCart(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

class UpdateCartQuantity extends CartEvent {
  final Product product;
  final int quantity;

  UpdateCartQuantity(this.product, this.quantity);
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}
