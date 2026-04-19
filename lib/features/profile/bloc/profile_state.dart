import 'package:gamers_brew/features/profile/models/user_model.dart';

class ProfileState {
  final UserModel? user;
  final bool isLoading;
  final bool showLevelUp;
  final String? error;

  ProfileState({this.user, this.isLoading = false, this.showLevelUp = false, this.error});

  ProfileState copyWith({UserModel? user, bool? isLoading, bool? showLevelUp}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      showLevelUp: showLevelUp ?? this.showLevelUp,
    );
  }
}