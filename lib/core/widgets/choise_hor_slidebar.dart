import 'package:flutter/material.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';

class HorSliderBar extends StatelessWidget {
  final List<String> items;
  final String activeCategory; // Теперь получаем это из Блока
  final void Function(String) onCategoryChanged;

  const HorSliderBar({
    super.key,
    required this.items,
    required this.activeCategory, // Обязательный параметр
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final category = items[index];
          final isSelected = category == activeCategory;

          return GestureDetector(
            onTap: () => onCategoryChanged(category),
            child: Container(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 8, right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.deselect,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.shadow, blurRadius: 10)]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}