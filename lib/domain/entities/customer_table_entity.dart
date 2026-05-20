class CustomerTableEntity {
  final int id;
  final int storeId;
  final String name;
  final int status; // 0: Trống, 1: Có khách, 2: Đặt trước
  final int? capacity;
  final bool isActive;
  final DateTime createdAt;

  const CustomerTableEntity({
    required this.id,
    required this.storeId,
    required this.name,
    this.status = 0,
    this.capacity,
    this.isActive = true,
    required this.createdAt,
  });
}
