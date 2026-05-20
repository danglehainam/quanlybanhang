import '../../domain/entities/order_item_entity.dart';
import '../datasources/local/app_database.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.quantity,
    required super.productName,
    required super.priceAtPurchase,
    required super.subtotal,
  });

  factory OrderItemModel.fromDrift(OrderItem driftModel) {
    return OrderItemModel(
      id: driftModel.id,
      orderId: driftModel.orderId,
      productId: driftModel.productId,
      quantity: driftModel.quantity,
      productName: driftModel.productName,
      priceAtPurchase: driftModel.priceAtPurchase,
      subtotal: driftModel.subtotal,
    );
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
      productName: json['product_name'] as String,
      priceAtPurchase: json['price_at_purchase'] as int,
      subtotal: json['subtotal'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'product_name': productName,
      'price_at_purchase': priceAtPurchase,
      'subtotal': subtotal,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      id: entity.id,
      orderId: entity.orderId,
      productId: entity.productId,
      quantity: entity.quantity,
      productName: entity.productName,
      priceAtPurchase: entity.priceAtPurchase,
      subtotal: entity.subtotal,
    );
  }
}
