import 'order_item_entity.dart';

class OrderEntity {
  final int id;
  final int storeId;
  final int createdBy;
  final int? customerId;
  final int totalAmount;
  final int discount;
  final int finalAmount;
  final int status; // 0: pending, 1: completed, 2: cancelled
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // For the UI to keep track of items easily (in-memory & fetched)
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.storeId,
    required this.createdBy,
    this.customerId,
    required this.totalAmount,
    this.discount = 0,
    required this.finalAmount,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  OrderEntity copyWith({
    int? id,
    int? storeId,
    int? createdBy,
    int? customerId,
    int? totalAmount,
    int? discount,
    int? finalAmount,
    int? status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItemEntity>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      createdBy: createdBy ?? this.createdBy,
      customerId: customerId ?? this.customerId,
      totalAmount: totalAmount ?? this.totalAmount,
      discount: discount ?? this.discount,
      finalAmount: finalAmount ?? this.finalAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }
}
