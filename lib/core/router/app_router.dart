import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/di/service_locator.dart';
import 'package:gamers_brew/features/auth/bloc/auth_bloc.dart';
import 'package:gamers_brew/features/auth/bloc/auth_state.dart';
import 'package:gamers_brew/features/auth/view/auth_page.dart';
import 'package:gamers_brew/features/cart/view/cart_page.dart';
import 'package:gamers_brew/features/home/view/home_page.dart';
import 'package:gamers_brew/features/main_shell.dart';
import 'package:gamers_brew/features/orders/view/orders_page.dart';
import 'package:gamers_brew/features/profile/view/profile_edit_page.dart';
import 'package:gamers_brew/features/profile/view/profile_page.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/auth',
  refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),

  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final bool loggingIn = state.matchedLocation == '/auth';
    if (authState is Unauthenticated) {
      return loggingIn ? null : '/auth';
    }
    if (authState is Authenticated && loggingIn) {
      return '/home';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const ProfileEditPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
