import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/features/orders/bloc/orders_bloc.dart';
import 'package:gamers_brew/features/orders/bloc/orders_event.dart';
import 'package:gamers_brew/features/orders/bloc/orders_state.dart';
import 'package:gamers_brew/features/orders/model/order_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ИСТОРИЯ ЗАКАЗОВ', style: TextStyle(fontFamily: 'Orbitron')),
        centerTitle: true,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (state is OrdersError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
          }
          if (state is OrdersLoaded) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<OrdersBloc>().add(LoadOrders());
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(), 
                itemCount: state.orders.length,
                itemBuilder: (context, index) => _OrderCard(order: state.orders[index]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ЗАКАЗ #${order.id}', 
                style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              _StatusBadge(status: order.status),
            ],
          ),
          const Divider(height: 24, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  order.itemsSummary.join(', '),
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              Text('${order.totalAmount}₽', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case OrderStatus.cooking:
        color = Colors.orange;
        text = 'ГОТОВИТСЯ';
        break;
      case OrderStatus.ready:
        color = AppColors.primary;
        text = 'ГОТОВ';
        break;
      case OrderStatus.completed:
        color = Colors.green;
        text = 'ЗАВЕРШЕН';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withAlpha(128)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}