import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/models/coffee_item.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/features/cart/bloc/cart_bloc.dart';
import 'package:gamers_brew/features/cart/bloc/cart_event.dart';
import 'package:gamers_brew/features/cart/bloc/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('КОРЗИНА', style: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Тут пока пусто, пойдем за кофе?', style: TextStyle(color: Colors.white54)));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return _CartItemTile(item: item);
                  },
                ),
              ),
              _buildFooter(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context, CartState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withAlpha(200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Поле промокода
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    hintText: 'Промокод',
                    errorText: state.promoError,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => context.read<CartBloc>().add(ApplyPromoCode(_promoController.text)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary.withAlpha(50)),
                child: const Text('OK', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Подытог
          _summaryRow('Подытог', '${state.subtotal.toStringAsFixed(0)}₽'),
          if (state.discountPercent > 0)
            _summaryRow('Скидка (${(state.discountPercent * 100).toInt()}%)', '-${state.discountAmount.toStringAsFixed(0)}₽', isDiscount: true),
          const Divider(height: 32, color: Colors.white10),
          _summaryRow('ИТОГО', '${state.total.toStringAsFixed(0)}₽', isTotal: true),
          const SizedBox(height: 24),
          // Кнопка оплаты
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () { /* Переход к оплате */ },
              child: const Text('ОФОРМИТЬ ЗАКАЗ', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? Colors.white : Colors.white60, fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(color: isDiscount ? AppColors.primary : Colors.white, fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CoffeeItem item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(item.imageUrl, width: 70, height: 70, fit: BoxFit.cover)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('${item.price}₽', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.read<CartBloc>().add(RemoveFromCart(item.id)),
            icon: const Icon(Icons.delete_outline, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}