import 'package:equatable/equatable.dart';
import 'package:gamers_brew/features/orders/model/order_model.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  const OrdersLoaded(this.orders);
  @override
  List<Object?> get props => [orders];
}

final class OrdersError extends OrdersState {
  final String message;
  const OrdersError(this.message);
}