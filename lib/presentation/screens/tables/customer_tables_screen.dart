import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_loading_widget.dart';
import 'bloc/customer_tables_bloc.dart';
import 'bloc/customer_tables_event.dart';
import 'bloc/customer_tables_state.dart';
import 'views/customer_tables_desktop_view.dart';
import 'views/customer_tables_mobile_view.dart';

class CustomerTablesScreen extends StatelessWidget {
  const CustomerTablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<CustomerTablesBloc>();
        context.read<AuthBloc>().state.maybeWhen(
              authenticated: (user) {
                bloc.add(CustomerTablesEvent.loadTables(storeId: user.storeId));
              },
              orElse: () {},
            );
        return bloc;
      },
      child: const _CustomerTablesContent(),
    );
  }
}

class _CustomerTablesContent extends StatelessWidget {
  const _CustomerTablesContent();

  @override
  Widget build(BuildContext context) {
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return BlocBuilder<CustomerTablesBloc, CustomerTablesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const AppLoadingWidget(),
          error: (message) => AppErrorWidget(
            message: message,
            onRetry: () {
              context.read<AuthBloc>().state.maybeWhen(
                    authenticated: (user) {
                      context.read<CustomerTablesBloc>().add(
                            CustomerTablesEvent.loadTables(storeId: user.storeId),
                          );
                    },
                    orElse: () {},
                  );
            },
          ),
          loaded: (tables) {
            if (isMobileView) {
              return CustomerTablesMobileView(tables: tables);
            }
            return CustomerTablesDesktopView(tables: tables);
          },
        );
      },
    );
  }
}
