import '../../domain/entities/product_entity.dart';
import '../datasources/local/app_database.dart'; // To get ProductDriftModel

class ProductModel {
  final int id;
  final int storeId;
  final int? categoryId;
  final String name;
  final int price;
  final String? imageUrl;
  final String? description;
  final int status;
  final int? stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductModel({
    required this.id,
    required this.storeId,
    this.categoryId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    required this.status,
    this.stock,
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
      description: driftModel.description,
      status: driftModel.status,
      stock: driftModel.stock,
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
      description: json['description'] as String?,
      status: json['status'] as int? ?? 1,
      stock: json['stock'] as int?,
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
      'description': description,
      'status': status,
      'stock': stock,
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
      description: description,
      status: status,
      stock: stock,
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
      description: entity.description,
      status: entity.status,
      stock: entity.stock,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
