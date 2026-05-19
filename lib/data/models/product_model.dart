import '../../domain/entities/product_entity.dart';
import '../datasources/local/app_database.dart'; // To get ProductDriftModel

class ProductModel {
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

  const ProductModel({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.recipe,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Mapper: From Drift
  factory ProductModel.fromDrift(ProductDriftModel driftModel) {
    return ProductModel(
      id: driftModel.id,
      storeId: driftModel.storeId,
      categoryId: driftModel.categoryId,
      name: driftModel.name,
      price: driftModel.price,
      imageUrl: driftModel.imageUrl,
      recipe: driftModel.recipe,
      status: driftModel.status,
      createdAt: DateTime.fromMillisecondsSinceEpoch(driftModel.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(driftModel.updatedAt),
    );
  }

  // Mapper: From JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      categoryId: json['category_id'] as int?,
      name: json['name'] as String,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String?,
      recipe: json['recipe'] as String?,
      status: json['status'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int),
    );
  }

  // Mapper: To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'category_id': categoryId,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'recipe': recipe,
      'status': status,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Mapper: To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      storeId: storeId,
      categoryId: categoryId,
      name: name,
      price: price,
      imageUrl: imageUrl,
      recipe: recipe,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Mapper: From Entity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      storeId: entity.storeId,
      categoryId: entity.categoryId,
      name: entity.name,
      price: entity.price,
      imageUrl: entity.imageUrl,
      recipe: entity.recipe,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
