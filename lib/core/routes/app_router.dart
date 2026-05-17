import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/auth/auth_state.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/register/register_screen.dart';
import '../../presentation/screens/products/products_screen.dart';
import '../../presentation/screens/transactions/transactions_screen.dart';
import '../../presentation/screens/partners/partners_screen.dart';
import '../../presentation/screens/cashbook/cashbook_screen.dart';
import '../../presentation/screens/reports/reports_screen.dart';
import '../../presentation/widgets/layout/main_layout.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isOnLogin = state.matchedLocation == AppRoutes.login;
      final isOnRegister = state.matchedLocation == AppRoutes.register;

      return authState.maybeWhen(
        authenticated: (_) {
          if (isOnLogin || isOnRegister) return AppRoutes.home;
          return null;
        },
        unauthenticated: () {
          if (!isOnLogin && !isOnRegister) return AppRoutes.login;
          return null;
        },
        orElse: () => null,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.products,
            builder: (context, state) => const ProductsScreen(),
          ),
          GoRoute(
            path: AppRoutes.transactions,
            builder: (context, state) => const TransactionsScreen(),
          ),
          GoRoute(
            path: AppRoutes.partners,
            builder: (context, state) => const PartnersScreen(),
          ),
          GoRoute(
            path: AppRoutes.cashbook,
            builder: (context, state) => const CashbookScreen(),
          ),
          GoRoute(
            path: AppRoutes.reports,
            builder: (context, state) => const ReportsScreen(),
          ),
        ],
      ),
    ],
  );
}

/// Converts a Stream into a Listenable for GoRouter's refreshListenable.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
