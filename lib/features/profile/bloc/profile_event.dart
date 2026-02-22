abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name, email;
  UpdateProfile(this.name, this.email);
}

class AddExperience extends ProfileEvent {
  final int points;
  AddExperience(this.points);
}

class DismissLevelUp extends ProfileEvent {}
