import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final int storeId;
  final String email;
  final String passwordHash;
  final String name;
  final int isOwner;
  final int? roleId;
  final int isActive;
  final int createdAt;
  final int updatedAt;

  const UserModel({
    required this.id,
    required this.storeId,
    required this.email,
    required this.passwordHash,
    required this.name,
    required this.isOwner,
    this.roleId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      email: json['email'] as String,
      passwordHash: json['password_hash'] as String,
      name: json['name'] as String,
      isOwner: json['is_owner'] as int,
      roleId: json['role_id'] as int?,
      isActive: json['is_active'] as int,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'email': email,
      'password_hash': passwordHash,
      'name': name,
      'is_owner': isOwner,
      'role_id': roleId,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      storeId: entity.storeId,
      email: entity.email,
      passwordHash: '',
      name: entity.name,
      isOwner: entity.isOwner ? 1 : 0,
      roleId: entity.roleId,
      isActive: entity.isActive ? 1 : 0,
      createdAt: entity.createdAt.toUtc().millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.toUtc().millisecondsSinceEpoch,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      storeId: storeId,
      email: email,
      name: name,
      isOwner: isOwner == 1,
      roleId: roleId,
      isActive: isActive == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt, isUtc: true),
    );
  }
}
