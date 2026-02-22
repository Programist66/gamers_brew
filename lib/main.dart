import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gamers_brew/core/di/service_locator.dart';
import 'package:gamers_brew/core/router/app_router.dart';
import 'package:gamers_brew/core/theme/app_theme.dart';
import 'package:gamers_brew/features/auth/bloc/auth_bloc.dart';
import 'package:gamers_brew/features/cart/bloc/cart_bloc.dart';
import 'package:gamers_brew/features/home/bloc/home_bloc.dart';
import 'package:gamers_brew/features/home/bloc/home_event.dart';
import 'package:gamers_brew/features/home/bloc/product_bloc.dart';
import 'package:gamers_brew/features/home/bloc/product_event.dart';
import 'package:gamers_brew/features/orders/bloc/orders_bloc.dart';
import 'package:gamers_brew/features/orders/bloc/orders_event.dart';
import 'package:gamers_brew/features/profile/bloc/profile_bloc.dart';
import 'package:gamers_brew/features/profile/bloc/profile_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "dotenv");
  await initDI();

  runApp(const GamerCoffeeApp());
}

class GamerCoffeeApp extends StatelessWidget {
  const GamerCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<CartBloc>()),
        BlocProvider(create: (_) => sl<HomeBloc>()..add(LoadHomeData())),
        BlocProvider(create: (_) => sl<ProductBloc>()..add(LoadProductData())),
        BlocProvider(create: (_) => sl<OrdersBloc>()..add(LoadOrders())),
        BlocProvider(create: (_) => sl<ProfileBloc>()..add(LoadProfile()))
      ],
      child: MaterialApp.router(
        title: 'Gamer Coffee',
        theme: AppTheme.darkTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
