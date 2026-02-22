import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/features/auth/bloc/auth_bloc.dart';
import 'package:gamers_brew/features/auth/bloc/auth_event.dart';
import 'package:gamers_brew/features/profile/bloc/profile_bloc.dart';
import 'package:gamers_brew/features/profile/bloc/profile_state.dart';
import 'package:gamers_brew/features/profile/models/user_model.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.user == null) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          final user = state.user!;

          return CustomScrollView(
            slivers: [
              _buildHeader(context, user),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: _buildXpBar(user), // Метод из предыдущего ответа
                ),
              ),
              _buildMenuSection(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(user.name, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.white54, fontSize: 14)),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () => context.push('/profile/edit'),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _menuTile(Icons.history, "История заказов", () => context.push('/orders')),
        _menuTile(Icons.payment, "Способы оплаты", () {}),
        _menuTile(Icons.notifications_none, "Уведомления", () {}),
        const Divider(color: Colors.white10, height: 40),
        _menuTile(Icons.logout, "Выйти", () {
  // Показываем диалог подтверждения
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A),
      title: const Text("TERMINATE SESSION?", style: TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
      content: const Text("Весь несохраненный опыт будет потерян.", style: TextStyle(color: Colors.white54)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("ОТМЕНА")),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(Logout());
            Navigator.pop(context);
          }, 
          child: const Text("ВЫЙТИ", style: TextStyle(color: Colors.red))
        ),
      ],
    ),
  );
}, isExit: true),
      ]),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap, {bool isExit = false}) {
    return ListTile(
      leading: Icon(icon, color: isExit ? Colors.red : AppColors.primary),
      title: Text(title, style: TextStyle(color: isExit ? Colors.red : Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: onTap,
    );
  }

  Widget _buildXpBar(UserModel user) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("LVL ${user.level}", style: const TextStyle(fontFamily: 'Orbitron', color: AppColors.primary)),
            Text("${user.xp}/${user.nextLevelXp} XP", style: const TextStyle(fontSize: 12, color: Colors.white54)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: user.progress,
          backgroundColor: Colors.white10,
          color: AppColors.primary,
          minHeight: 6,
        ),
      ],
    );
  }
}