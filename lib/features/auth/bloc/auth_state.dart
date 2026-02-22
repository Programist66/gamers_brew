import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class Unauthenticated extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;
  
  const AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

final class Authenticated extends AuthState {
  final String userId;
  const Authenticated(this.userId);
  @override
  List<Object?> get props => [userId];
}

final class AuthLoginFailure extends AuthState {
  final String error;

  const AuthLoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}