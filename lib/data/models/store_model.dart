import '../../domain/entities/store_entity.dart';

class StoreModel {
  final int id;
  final String name;
  final String? address;
  final String? phone;
  final int createdAt;
  final int updatedAt;

  const StoreModel({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as int,
      updatedAt: json['updated_at'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory StoreModel.fromEntity(StoreEntity entity) {
    return StoreModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      phone: entity.phone,
      createdAt: entity.createdAt.toUtc().millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.toUtc().millisecondsSinceEpoch,
    );
  }

  StoreEntity toEntity() {
    return StoreEntity(
      id: id,
      name: name,
      address: address,
      phone: phone,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt, isUtc: true),
    );
  }
}
