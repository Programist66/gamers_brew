import 'package:flutter/material.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        // Добавляем стиль, чтобы видеть выделение
        selectedItemColor: AppColors.primary, 
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Чтобы иконки не "прыгали" при нажатии
        backgroundColor: AppColors.backgroundDark, // Или твой фоновый цвет
        
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Заказы'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    
    // Проверяй пути в соответствии с тем, как они описаны в твоем GoRouter
    if (location == '/' || location.startsWith('/home')) return 0;
    if (location.startsWith('/orders')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home'); // Убедись, что в GoRouter путь именно /home, а не /
        break;
      case 1:
        context.go('/orders');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}