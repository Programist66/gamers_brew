import 'package:gamers_brew/core/network/dio_client.dart';
import 'package:gamers_brew/features/profile/models/user_model.dart';

class ProfileRepository {
  final DioClient _client;
  ProfileRepository(this._client);

  Future<UserModel> getUserProfile() async {
    //final response = await _dio.get('/profile');
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      name: "Ivan Ivanov",
      email: "ivan.ivanov@email.com",
      level: 14,
      xp: 650,
    );
  }

  Future<void> updateProfile(String name, String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}