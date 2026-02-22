import 'package:gamers_brew/core/network/dio_client.dart';
import 'package:gamers_brew/features/auth/bloc/auth_bloc.dart';
import 'package:gamers_brew/features/auth/repository/auth_repository.dart';
import 'package:gamers_brew/features/cart/bloc/cart_bloc.dart';
import 'package:gamers_brew/features/cart/repository/cart_repository.dart';
import 'package:gamers_brew/features/home/bloc/home_bloc.dart';
import 'package:gamers_brew/features/home/bloc/product_bloc.dart';
import 'package:gamers_brew/features/home/repository/coffee_repository.dart';
import 'package:gamers_brew/features/orders/bloc/orders_bloc.dart';
import 'package:gamers_brew/features/orders/repository/orders_repository.dart';
import 'package:gamers_brew/features/profile/bloc/profile_bloc.dart';
import 'package:gamers_brew/features/profile/repository/profile_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Core
  sl.registerLazySingleton(() => DioClient());

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl()));
  sl.registerLazySingleton(() => CoffeeRepository(sl()));
  sl.registerLazySingleton(() => CartRepository());  
  sl.registerLazySingleton(() => OrdersRepository(sl()));
  sl.registerLazySingleton(() => ProfileRepository(sl()));

  //Bloc
  sl.registerLazySingleton(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => HomeBloc(coffeeRepository: sl()));
  sl.registerFactory(() => ProductBloc(coffeeRepository: sl()));  
  sl.registerFactory(() => OrdersBloc(repository: sl()));
  sl.registerFactory(() => ProfileBloc(repository: sl()));
  sl.registerLazySingleton(() => CartBloc(repository: sl()));
}