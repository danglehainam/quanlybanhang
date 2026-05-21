import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../../core/di/dependency_injection.dart';
import 'bloc/transactions_bloc.dart';
import 'bloc/transactions_event.dart';
import 'bloc/transactions_state.dart';
import 'views/transactions_mobile_view.dart';
import 'views/transactions_desktop_view.dart';
import 'widgets/transaction_form_dialog.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<TransactionsBloc>();
        final authState = context.read<AuthBloc>().state;
        authState.maybeWhen(
          authenticated: (user) {
            bloc.add(TransactionsEvent.loadTransactions(storeId: user.storeId));
          },
          orElse: () {},
        );
        return bloc;
      },
      child: const TransactionsView(),
    );
  }
}

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return Scaffold(
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const AppLoadingWidget(),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () {
                final authState = context.read<AuthBloc>().state;
                authState.maybeWhen(
                  authenticated: (user) {
                    context.read<TransactionsBloc>().add(
                          TransactionsEvent.loadTransactions(storeId: user.storeId),
                        );
                  },
                  orElse: () {},
                );
              },
            ),
            loaded: (transactions) {
              if (isMobileView) {
                return TransactionsMobileView(transactions: transactions);
              }
              return TransactionsDesktopView(transactions: transactions);
            },
          );
        },
      ),
      floatingActionButton: isMobileView ? FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<TransactionsBloc>(),
              child: const TransactionFormDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}
