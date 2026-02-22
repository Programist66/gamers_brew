import 'package:equatable/equatable.dart';
import 'package:gamers_brew/core/models/coffee_item.dart';

class CartState extends Equatable {
  final List<CoffeeItem> items;
  final double discountPercent;
  final String? promoError;

  const CartState({
    this.items = const [],
    this.discountPercent = 0.0,
    this.promoError,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.price);
  double get discountAmount => subtotal * discountPercent;
  double get total => subtotal - discountAmount;

  CartState copyWith({
    List<CoffeeItem>? items,
    double? discountPercent,
    String? promoError,
  }) {
    return CartState(
      items: items ?? this.items,
      discountPercent: discountPercent ?? this.discountPercent,
      promoError: promoError,
    );
  }

  @override
  List<Object?> get props => [items, discountPercent, promoError];
}