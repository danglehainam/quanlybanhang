import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import 'core/constants/app_colors.dart';

import 'core/di/dependency_injection.dart';
import 'core/routes/app_router.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';

import 'presentation/bloc/settings/settings_bloc.dart';
import 'presentation/bloc/settings/settings_state.dart';

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
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp.router(
                  title: 'Quản Lý Bán Hàng',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(settingsState.languageCode),
                theme: ThemeData(
                  colorSchemeSeed: AppColors.primary,
                  useMaterial3: true,
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: AppColors.background,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    centerTitle: true,
                    surfaceTintColor: Colors.transparent,
                  ),
                  cardTheme: const CardThemeData(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    color: Colors.white,
                  ),
                  dividerTheme: const DividerThemeData(
                    color: AppColors.divider,
                    space: 1,
                    thickness: 1,
                  ),
                ),
                routerConfig: appRouter.router,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
