import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import 'core/di/dependency_injection.dart';
import 'core/routes/app_router.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';

import 'presentation/bloc/settings/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AuthEvent.checkRememberedUser()),
        ),
        BlocProvider(
          create: (_) => getIt<SettingsBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = AppRouter(context.read<AuthBloc>());
          return MaterialApp.router(
            title: 'Quản Lý Bán Hàng',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('vi'),
            theme: ThemeData(
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.light,
            ),
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
