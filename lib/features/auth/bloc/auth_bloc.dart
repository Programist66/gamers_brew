import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/features/auth/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        if (await authRepository.login(event.login, event.password)){
          emit(AuthSuccess());
        } else {
          emit(AuthLoginFailure(error: "Invalid login or password"));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
    on<LoginFieldChanged>((event, emit) {
      emit(AuthInitial());
    });
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.logout();
        emit(Unauthenticated());
      } catch (e) {
        emit(Unauthenticated());
      }
    });
  }
}