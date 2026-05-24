import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_event.freezed.dart';

@freezed
class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.loadOrders({required int storeId}) = LoadOrdersEvent;
  const factory OrdersEvent.filterOrders({
    String? query,
    int? statusFilter, // null for all, 0 for pending, 1 for completed
    int? sortOption,   // 0 for newest, 1 for oldest, 2 for highest price, 3 for lowest price
  }) = FilterOrdersEvent;
}
