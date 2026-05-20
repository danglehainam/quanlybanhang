import '../../domain/entities/order_entity.dart';
import '../datasources/local/app_database.dart';
import 'order_item_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.storeId,
    required super.createdBy,
    super.customerId,
    required super.totalAmount,
    super.discount,
    required super.finalAmount,
    required super.status,
    super.note,
    required super.createdAt,
    required super.updatedAt,
    super.items = const [],
  });

  factory OrderModel.fromDrift(Order driftModel, {List<OrderItemModel> items = const []}) {
    return OrderModel(
      id: driftModel.id,
      storeId: driftModel.storeId,
      createdBy: driftModel.createdBy,
      customerId: driftModel.customerId,
      totalAmount: driftModel.totalAmount,
      discount: driftModel.discount,
      finalAmount: driftModel.finalAmount,
      status: driftModel.status,
      note: driftModel.note,
      createdAt: DateTime.fromMillisecondsSinceEpoch(driftModel.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(driftModel.updatedAt),
      items: items,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      createdBy: json['created_by'] as int,
      customerId: json['customer_id'] as int?,
      totalAmount: json['total_amount'] as int,
      discount: json['discount'] as int? ?? 0,
      finalAmount: json['final_amount'] as int,
      status: json['status'] as int,
      note: json['note'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'created_by': createdBy,
      'customer_id': customerId,
      'total_amount': totalAmount,
      'discount': discount,
      'final_amount': finalAmount,
      'status': status,
      'note': note,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'items': items.map((e) => (e as OrderItemModel).toJson()).toList(),
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      storeId: entity.storeId,
      createdBy: entity.createdBy,
      customerId: entity.customerId,
      totalAmount: entity.totalAmount,
      discount: entity.discount,
      finalAmount: entity.finalAmount,
      status: entity.status,
      note: entity.note,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      items: entity.items,
    );
  }
}
