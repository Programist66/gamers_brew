import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/features/profile/bloc/profile_bloc.dart';
import 'package:gamers_brew/features/profile/bloc/profile_event.dart';
import 'package:gamers_brew/features/profile/bloc/profile_state.dart';
import 'package:go_router/go_router.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Ключ для управления формой
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileBloc>().state.user;
    _nameController = TextEditingController(text: user?.name ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Метод для валидации Email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (!state.isLoading && state.error == null) {
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            title: const Text(
              "РЕДАКТИРОВАТЬ",
              style: TextStyle(fontFamily: 'Orbitron', fontSize: 18),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _formKey, // Привязываем ключ
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildValidatedField(
                    label: "ИМЯ ИГРОКА",
                    controller: _nameController,
                    hint: "Введите никнейм",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Имя не может быть пустым";
                      }
                      if (value.length < 3) {
                        return "Минимум 3 символа";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildValidatedField(
                    label: "EMAIL",
                    controller: _emailController,
                    hint: "example@mail.com",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email обязателен";
                      }
                      if (!_isValidEmail(value)) {
                        return "Введите корректный email";
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  _buildSaveButton(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValidatedField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 10,
            fontFamily: 'Orbitron',
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator, // Назначаем валидатор
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          cursorColor: const Color(0xFF00E676),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            filled: true,
            fillColor: Colors.white.withAlpha(5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.shadow),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(ProfileState state) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          shadowColor: AppColors.shadow,
        ),
        onPressed: state.isLoading
            ? null
            : () {
                // Запускаем проверку всех валидаторов в форме
                if (_formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                    UpdateProfile(
                      _nameController.text.trim(),
                      _emailController.text.trim(),
                    ),
                  );
                }
              },
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : const Text(
                "СОХРАНИТЬ ИЗМЕНЕНИЯ",
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

