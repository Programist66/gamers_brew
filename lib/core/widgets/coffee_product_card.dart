import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/models/coffee_item.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/features/cart/bloc/cart_bloc.dart';
import 'package:gamers_brew/features/cart/bloc/cart_event.dart';

class CoffeeProductCard extends StatelessWidget {
  final CoffeeItem product;

  const CoffeeProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: const Color.fromARGB(255, 35, 35, 35),
         borderRadius: BorderRadius.circular(12),
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3, 
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (ctx, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                   return Container(color: Colors.grey[800], child: const Center(child: Icon(Icons.image, size: 20, color: Colors.white24)));
                },
                errorBuilder: (ctx, err, stack) => Container(color: Colors.grey[800], child: const Icon(Icons.broken_image, size: 20)),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Название - шрифт уменьшен с 21 до 14
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      // Описание - шрифт уменьшен с 16 до 11
                      Text(
                        product.description,
                        style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Цена и Кнопка
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Цена - шрифт уменьшен с 18 до 13
                      Text(
                        '${product.price.toInt()} ₽', // toInt() чтобы убрать .0 если цена целая
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Кнопка добавления
                      Container(
                        width: 28, // Фиксированный маленький размер кнопки
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary, // Используем твой AppColors
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IconButton(
                          // Иконка уменьшена с 35 до 18
                          icon: const Icon(Icons.add, color: Colors.white, size: 18),
                          onPressed: () {
                             context.read<CartBloc>().add(AddToCart(product));
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}