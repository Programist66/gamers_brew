class UserModel {
  final String name;
  final String email;
  final int level;
  final int xp;
  final int nextLevelXp;

  UserModel({
    required this.name, 
    required this.email, 
    this.level = 1, 
    this.xp = 0, 
    this.nextLevelXp = 1000
  });

  double get progress => xp / nextLevelXp;

  UserModel copyWith({String? name, String? email, int? level, int? xp}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      level: level ?? this.level,
      xp: xp ?? this.xp,
    );
  }
}