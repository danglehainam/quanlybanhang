class CategoryEntity {
  final int id;
  final int storeId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.id,
    required this.storeId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
