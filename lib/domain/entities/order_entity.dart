import 'customer_entity.dart';
import 'customer_table_entity.dart';
import 'order_item_entity.dart';

class OrderEntity {
  final int id;
  final int storeId;
  final int createdBy;
  final int? customerId;
  final int? tableId;
  final int totalAmount;
  final double? discountPercent;
  final int discount;
  final int finalAmount;
  final int status; // 0: pending, 1: completed, 2: cancelled
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // For the UI to keep track of items easily (in-memory & fetched)
  final List<OrderItemEntity> items;
  final CustomerEntity? customer;
  final CustomerTableEntity? table;

  const OrderEntity({
    required this.id,
    required this.storeId,
    required this.createdBy,
    this.customerId,
    this.tableId,
    required this.totalAmount,
    this.discountPercent,
    this.discount = 0,
    required this.finalAmount,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
    this.customer,
    this.table,
  });

  OrderEntity copyWith({
    int? id,
    int? storeId,
    int? createdBy,
    int? customerId,
    int? tableId,
    int? totalAmount,
    double? discountPercent,
    bool clearDiscountPercent = false,
    int? discount,
    int? finalAmount,
    int? status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItemEntity>? items,
    CustomerEntity? customer,
    CustomerTableEntity? table,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      createdBy: createdBy ?? this.createdBy,
      customerId: customerId ?? this.customerId,
      tableId: tableId ?? this.tableId,
      totalAmount: totalAmount ?? this.totalAmount,
      discountPercent: clearDiscountPercent ? null : (discountPercent ?? this.discountPercent),
      discount: discount ?? this.discount,
      finalAmount: finalAmount ?? this.finalAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      customer: customer ?? this.customer,
      table: table ?? this.table,
    );
  }
}
