import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_orders_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersBloc(this._getOrdersUseCase) : super(const OrdersState.initial()) {
    on<OrdersEvent>((event, emit) async {
      await event.map(
        loadOrders: (e) async {
          emit(const OrdersState.loading());
          final result = await _getOrdersUseCase();
          result.fold(
            (failure) => emit(OrdersState.error(failure.message)),
            (orders) {
              // Default filter and sort
              var filtered = List.from(orders);
              // Default sort by newest
              filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

              emit(OrdersState.loaded(
                allOrders: orders,
                filteredOrders: List.from(filtered),
                searchQuery: '',
                statusFilter: null,
                sortOption: 0,
              ));
            },
          );
        },
        filterOrders: (e) {
          state.maybeWhen(
            loaded: (allOrders, _, currentQuery, currentStatusFilter, currentSortOption) {
              final query = e.query ?? currentQuery;
              final statusFilter = e.statusFilter == -1 ? null : (e.statusFilter ?? currentStatusFilter);
              final sortOption = e.sortOption ?? currentSortOption;

              var filtered = allOrders.where((order) {
                // 1. Search Query
                final matchesSearch = query.isEmpty ||
                    order.id.toString().contains(query) ||
                    (order.customer?.name.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                    (order.customer?.phone.contains(query) ?? false) ||
                    (order.table?.name.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                    (order.note?.toLowerCase().contains(query.toLowerCase()) ?? false);

                // 2. Status Filter
                final matchesStatus = statusFilter == null || order.status == statusFilter;

                return matchesSearch && matchesStatus;
              }).toList();

              // 3. Sorting
              if (sortOption == 0) {
                // Newest
                filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              } else if (sortOption == 1) {
                // Oldest
                filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
              } else if (sortOption == 2) {
                // Highest Price
                filtered.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
              } else if (sortOption == 3) {
                // Lowest Price
                filtered.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
              }

              emit(OrdersState.loaded(
                allOrders: allOrders,
                filteredOrders: filtered,
                searchQuery: query,
                statusFilter: statusFilter,
                sortOption: sortOption,
              ));
            },
            orElse: () {},
          );
        },
      );
    });
  }
}
