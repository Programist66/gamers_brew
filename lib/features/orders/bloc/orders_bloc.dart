import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/features/orders/bloc/orders_event.dart';
import 'package:gamers_brew/features/orders/bloc/orders_state.dart';
import 'package:gamers_brew/features/orders/repository/orders_repository.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository repository;

  OrdersBloc({required this.repository}) : super(OrdersLoading()) {
    on<LoadOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final orders = await repository.fetchOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(const OrdersError("Не удалось загрузить заказы"));
      }
    });
  }
}