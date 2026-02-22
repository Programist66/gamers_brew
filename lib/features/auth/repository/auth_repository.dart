import 'package:gamers_brew/core/network/dio_client.dart';

class AuthRepository {
  final DioClient _client;

  AuthRepository(this._client);

  Future<bool> login(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1)); 
    if (login == 'admin' && password == 'admin') {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}