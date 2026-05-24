import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_error_widget.dart';
import 'bloc/orders_bloc.dart';
import 'bloc/orders_event.dart';
import 'bloc/orders_state.dart';
import 'views/orders_desktop_view.dart';
import 'views/orders_mobile_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 0,
    );

    return BlocProvider(
      create: (context) => getIt<OrdersBloc>()..add(OrdersEvent.loadOrders(storeId: storeId)),
      child: OrdersView(storeId: storeId),
    );
  }
}

class OrdersView extends StatelessWidget {
  final int storeId;
  const OrdersView({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          return state.when(
            initial: () => const AppLoadingWidget(),
            loading: () => const AppLoadingWidget(),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () => context.read<OrdersBloc>().add(OrdersEvent.loadOrders(storeId: storeId)),
            ),
            loaded: (allOrders, filteredOrders, searchQuery, statusFilter, sortOption) {
              if (isMobileView) {
                return OrdersMobileView(
                  storeId: storeId,
                  orders: filteredOrders,
                  searchQuery: searchQuery,
                  statusFilter: statusFilter,
                  sortOption: sortOption,
                );
              }
              
              return OrdersDesktopView(
                storeId: storeId,
                orders: filteredOrders,
                searchQuery: searchQuery,
                statusFilter: statusFilter,
                sortOption: sortOption,
              );
            },
          );
        },
      ),
    );
  }
}
