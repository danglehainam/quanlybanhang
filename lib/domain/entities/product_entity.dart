class ProductEntity {
  final int id;
  final int storeId;
  final int? categoryId;
  final String name;
  final int price;
  final String? imageUrl;
  final String? description;
  final int status;
  final int? stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    this.status = 1,
    this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  ProductEntity copyWith({
    int? id,
    int? storeId,
    int? categoryId,
    String? name,
    int? price,
    String? imageUrl,
    String? description,
    int? status,
    int? stock,
    bool clearStock = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      status: status ?? this.status,
      stock: clearStock ? null : (stock ?? this.stock),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
