class OrderItemEntity {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String productName;
  final int priceAtPurchase;
  final int subtotal;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.priceAtPurchase,
    required this.subtotal,
  });

  OrderItemEntity copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    String? productName,
    int? priceAtPurchase,
    int? subtotal,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      priceAtPurchase: priceAtPurchase ?? this.priceAtPurchase,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
