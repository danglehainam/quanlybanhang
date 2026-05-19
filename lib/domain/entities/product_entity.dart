class ProductEntity {
  final int id;
  final int storeId;
  final int? categoryId;
  final String name;
  final int price;
  final String? imageUrl;
  final String? recipe;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.recipe,
    this.status = 1,
    required this.createdAt,
    required this.updatedAt,
  });
}
