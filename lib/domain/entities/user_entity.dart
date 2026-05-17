class UserEntity {
  final int id;
  final int storeId;
  final String email;
  final String name;
  final bool isOwner;
  final int? roleId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.storeId,
    required this.email,
    required this.name,
    required this.isOwner,
    this.roleId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}
