import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/models/coffee_item.dart';
import 'package:gamers_brew/features/cart/bloc/cart_event.dart';
import 'package:gamers_brew/features/cart/bloc/cart_state.dart';
import 'package:gamers_brew/features/cart/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required this.repository}) : super(const CartState()) {
    on<AddToCart>((event, emit) {
      emit(state.copyWith(items: List.from(state.items)..add(event.item)));
    });

    on<RemoveFromCart>((event, emit) {
      final newItems = List<CoffeeItem>.from(state.items);
      newItems.removeWhere((i) => i.id == event.itemId);
      emit(state.copyWith(items: newItems));
    });

    on<ApplyPromoCode>((event, emit) async {
      final discount = await repository.validatePromoCode(event.code);
      if (discount > 0) {
        emit(state.copyWith(discountPercent: discount, promoError: null));
      } else {
        emit(state.copyWith(promoError: 'Неверный промокод', discountPercent: 0.0));
      }
    });
  }
}