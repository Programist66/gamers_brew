import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/features/profile/bloc/profile_event.dart';
import 'package:gamers_brew/features/profile/bloc/profile_state.dart';
import 'package:gamers_brew/features/profile/repository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository; // Используем правильный тип

  ProfileBloc({required ProfileRepository repository}) 
      : _repository = repository, 
        super(ProfileState()) {
    
    on<LoadProfile>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final user = await _repository.getUserProfile();
        emit(state.copyWith(user: user, isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false));
        // Здесь можно добавить обработку ошибки (ErrorState)
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        await _repository.updateProfile(event.name, event.email);
        emit(state.copyWith(
          user: state.user?.copyWith(name: event.name, email: event.email),
          isLoading: false,
        ));
      } catch (e) {
        emit(state.copyWith(isLoading: false));
      }
    });

    on<AddExperience>((event, emit) {
      if (state.user == null) return;
      
      final newXp = state.user!.xp + event.points;
      if (newXp >= state.user!.nextLevelXp) {
        emit(state.copyWith(
          user: state.user!.copyWith(
            level: state.user!.level + 1, 
            xp: newXp - state.user!.nextLevelXp // Остаток опыта переносим
          ),
          showLevelUp: true,
        ));
      } else {
        emit(state.copyWith(user: state.user!.copyWith(xp: newXp)));
      }
    });

    on<DismissLevelUp>((event, emit) => emit(state.copyWith(showLevelUp: false)));
  }
}