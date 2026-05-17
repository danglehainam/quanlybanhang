class StoreEntity {
  final int id;
  final String name;
  final String? address;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StoreEntity({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
}
