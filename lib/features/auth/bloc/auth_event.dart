import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class LoginButtonPressed extends AuthEvent {
  final String login;
  final String password;

  const LoginButtonPressed({required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}

final class LoginFieldChanged extends AuthEvent {
  final String login;
  final String password;

  const LoginFieldChanged({required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}

final class Logout extends AuthEvent{}