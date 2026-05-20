import '../../domain/entities/customer_table_entity.dart';
import '../datasources/local/app_database.dart';

class CustomerTableModel extends CustomerTableEntity {
  const CustomerTableModel({
    required super.id,
    required super.storeId,
    required super.name,
    required super.status,
    super.capacity,
    required super.isActive,
    required super.createdAt,
  });

  factory CustomerTableModel.fromDrift(CustomerTable driftModel) {
    return CustomerTableModel(
      id: driftModel.id,
      storeId: driftModel.storeId,
      name: driftModel.name,
      status: driftModel.status,
      capacity: driftModel.capacity,
      isActive: driftModel.isActive,
      createdAt: DateTime.fromMillisecondsSinceEpoch(driftModel.createdAt),
    );
  }

  factory CustomerTableModel.fromJson(Map<String, dynamic> json) {
    return CustomerTableModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      name: json['name'] as String,
      status: json['status'] as int,
      capacity: json['capacity'] as int?,
      isActive: (json['is_active'] as int) == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'name': name,
      'status': status,
      'capacity': capacity,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CustomerTableModel.fromEntity(CustomerTableEntity entity) {
    return CustomerTableModel(
      id: entity.id,
      storeId: entity.storeId,
      name: entity.name,
      status: entity.status,
      capacity: entity.capacity,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }
}
