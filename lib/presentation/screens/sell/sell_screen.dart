import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/settings/settings_state.dart';
import '../../bloc/sell/sell_bloc.dart';
import '../../bloc/sell/sell_event.dart';
import '../../bloc/sell/sell_state.dart';
import 'views/sell_desktop_view.dart';
import 'views/sell_mobile_view.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 0,
    );
    getIt<SellBloc>().add(SellEvent.loadInitialData(storeId: storeId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SellBloc>(),
      child: BlocListener<SellBloc, SellState>(
        listenWhen: (previous, current) => previous.isActionSuccess != current.isActionSuccess || previous.error != current.error,
        listener: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          if (state.isActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.orderCompletedSuccess), backgroundColor: Colors.green),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return settingsState.isMobileView
                ? const SellMobileView()
                : const SellDesktopView();
          },
        ),
      ),
    );
  }
}

