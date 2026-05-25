import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/order_entity.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = OrdersInitialState;
  const factory OrdersState.loading() = OrdersLoadingState;
  const factory OrdersState.error(String message) = OrdersErrorState;
  const factory OrdersState.loaded({
    required List<OrderEntity> allOrders,
    required List<OrderEntity> filteredOrders,
    required String searchQuery,
    int? statusFilter,
    int? sortOption,
    required int timeFilterType,
    required DateTime selectedDate,
    required int selectedMonth,
    required int selectedQuarter,
    required int selectedYear,
  }) = OrdersLoadedState;
}
