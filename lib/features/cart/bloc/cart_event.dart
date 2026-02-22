import 'package:equatable/equatable.dart';
import 'package:gamers_brew/core/models/coffee_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final CoffeeItem item;
  const AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final String itemId;
  const RemoveFromCart(this.itemId);
}

class ApplyPromoCode extends CartEvent {
  final String code;
  const ApplyPromoCode(this.code);
  @override
  List<Object?> get props => [code];
}