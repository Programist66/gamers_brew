import 'package:dio/dio.dart';
import '../config/app_config.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
            receiveTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
            contentType: 'application/json',
          ),
        ) {
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}