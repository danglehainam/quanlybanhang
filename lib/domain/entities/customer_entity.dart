class CustomerEntity {
  final int id;
  final int storeId;
  final String name;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomerEntity({
    required this.id,
    required this.storeId,
    required this.name,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
}
