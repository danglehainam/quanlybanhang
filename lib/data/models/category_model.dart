import '../../domain/entities/category_entity.dart';
import '../datasources/local/app_database.dart'; // To get CategoryDriftModel

class CategoryModel {
  final int id;
  final int storeId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    required this.storeId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Mapper: From Drift
  factory CategoryModel.fromDrift(CategoryDriftModel driftModel) {
    return CategoryModel(
      id: driftModel.id,
      storeId: driftModel.storeId,
      name: driftModel.name,
      description: driftModel.description,
      createdAt: DateTime.fromMillisecondsSinceEpoch(driftModel.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(driftModel.updatedAt),
    );
  }

  // Mapper: From JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int),
    );
  }

  // Mapper: To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'name': name,
      'description': description,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Mapper: To Entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      storeId: storeId,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Mapper: From Entity
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      storeId: entity.storeId,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
