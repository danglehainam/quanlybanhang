import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/order_entity.dart';
import '../../../../domain/usecases/get_orders_usecase.dart';
import '../../../../domain/usecases/update_order_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final UpdateOrderUseCase _updateOrderUseCase;

  OrdersBloc(this._getOrdersUseCase, this._updateOrderUseCase) : super(const OrdersState.initial()) {
    on<OrdersEvent>((event, emit) async {
      await event.map(
        loadOrders: (e) async {
          emit(const OrdersState.loading());
          final result = await _getOrdersUseCase();
          result.fold(
            (failure) => emit(OrdersState.error(failure.message)),
            (orders) {
              final now = DateTime.now();
              // Default time filter to current date (today)
              final initialDate = DateTime.now();
              final initialMonth = now.month;
              final initialQuarter = ((now.month - 1) ~/ 3) + 1;
              final initialYear = now.year;

              // Filter all orders by default
              var filtered = List<OrderEntity>.from(orders);

              // Default sort by newest
              filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

              emit(OrdersState.loaded(
                allOrders: orders,
                filteredOrders: filtered,
                searchQuery: '',
                statusFilter: null,
                sortOption: 0,
                timeFilterType: 4, // Default to All Time!
                selectedDate: initialDate,
                selectedMonth: initialMonth,
                selectedQuarter: initialQuarter,
                selectedYear: initialYear,
              ));
            },
          );
        },
        filterOrders: (e) {
          state.maybeWhen(
            loaded: (allOrders, _, currentQuery, currentStatusFilter, currentSortOption,
                currentTimeFilterType, currentSelectedDate, currentSelectedMonth,
                currentSelectedQuarter, currentSelectedYear) {
              final query = e.query ?? currentQuery;
              final statusFilter = e.statusFilter == -1 ? null : (e.statusFilter ?? currentStatusFilter);
              final sortOption = e.sortOption ?? currentSortOption;

              final timeFilterType = e.timeFilterType ?? currentTimeFilterType;
              final selectedDate = e.selectedDate ?? currentSelectedDate;
              final selectedMonth = e.selectedMonth ?? currentSelectedMonth;
              final selectedQuarter = e.selectedQuarter ?? currentSelectedQuarter;
              final selectedYear = e.selectedYear ?? currentSelectedYear;

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

                // 3. Time Filter
                bool matchesTime = true;
                final localTime = order.createdAt.toLocal();
                if (timeFilterType == 0) {
                  // Specific Date
                  matchesTime = localTime.day == selectedDate.day &&
                      localTime.month == selectedDate.month &&
                      localTime.year == selectedDate.year;
                } else if (timeFilterType == 1) {
                  // By Month
                  matchesTime = localTime.month == selectedMonth &&
                      localTime.year == selectedYear;
                } else if (timeFilterType == 2) {
                  // By Quarter
                  final q = ((localTime.month - 1) ~/ 3) + 1;
                  matchesTime = q == selectedQuarter &&
                      localTime.year == selectedYear;
                } else if (timeFilterType == 3) {
                  // By Year
                  matchesTime = localTime.year == selectedYear;
                } else if (timeFilterType == 4) {
                  // All Time
                  matchesTime = true;
                }

                return matchesSearch && matchesStatus && matchesTime;
              }).toList();

              // 4. Sorting
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
                timeFilterType: timeFilterType,
                selectedDate: selectedDate,
                selectedMonth: selectedMonth,
                selectedQuarter: selectedQuarter,
                selectedYear: selectedYear,
              ));
            },
            orElse: () {},
          );
        },
        updateOrderStatus: (e) async {
          final updatedOrder = e.order.copyWith(status: e.newStatus);
          final result = await _updateOrderUseCase(updatedOrder);

          result.fold(
            (failure) => e.onError(failure.message),
            (_) {
              e.onSuccess();
              state.maybeWhen(
                loaded: (allOrders, _, searchQuery, statusFilter, sortOption,
                    timeFilterType, selectedDate, selectedMonth, selectedQuarter, selectedYear) {
                  final newAllOrders = allOrders.map((order) {
                    return order.id == updatedOrder.id ? updatedOrder : order;
                  }).toList();

                  var filtered = newAllOrders.where((order) {
                    // 1. Search Query
                    final matchesSearch = searchQuery.isEmpty ||
                        order.id.toString().contains(searchQuery) ||
                        (order.customer?.name.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
                        (order.customer?.phone.contains(searchQuery) ?? false) ||
                        (order.table?.name.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
                        (order.note?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);

                    // 2. Status Filter
                    final matchesStatus = statusFilter == null || order.status == statusFilter;

                    // 3. Time Filter
                    bool matchesTime = true;
                    final localTime = order.createdAt.toLocal();
                    if (timeFilterType == 0) {
                      matchesTime = localTime.day == selectedDate.day &&
                          localTime.month == selectedDate.month &&
                          localTime.year == selectedDate.year;
                    } else if (timeFilterType == 1) {
                      matchesTime = localTime.month == selectedMonth &&
                          localTime.year == selectedYear;
                    } else if (timeFilterType == 2) {
                      final q = ((localTime.month - 1) ~/ 3) + 1;
                      matchesTime = q == selectedQuarter &&
                          localTime.year == selectedYear;
                    } else if (timeFilterType == 3) {
                      matchesTime = localTime.year == selectedYear;
                    } else if (timeFilterType == 4) {
                      matchesTime = true;
                    }

                    return matchesSearch && matchesStatus && matchesTime;
                  }).toList();

                  // 4. Sorting
                  if (sortOption == 0) {
                    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  } else if (sortOption == 1) {
                    filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  } else if (sortOption == 2) {
                    filtered.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
                  } else if (sortOption == 3) {
                    filtered.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
                  }

                  emit(OrdersState.loaded(
                    allOrders: newAllOrders,
                    filteredOrders: filtered,
                    searchQuery: searchQuery,
                    statusFilter: statusFilter,
                    sortOption: sortOption,
                    timeFilterType: timeFilterType,
                    selectedDate: selectedDate,
                    selectedMonth: selectedMonth,
                    selectedQuarter: selectedQuarter,
                    selectedYear: selectedYear,
                  ));
                },
                orElse: () {},
              );
            },
          );
        },
      );
    });
  }
}
