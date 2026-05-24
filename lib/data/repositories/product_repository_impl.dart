import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_local_datasource.dart';
import '../datasources/local/app_database.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource _localDataSource;

  ProductRepositoryImpl(this._localDataSource);

  @override
  Stream<Either<Failure, List<ProductEntity>>> watchProducts({
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? status,
    int? sortOption,
  }) {
    return _localDataSource.watchProducts(
      query: query,
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      status: status,
      sortOption: sortOption,
    ).map((driftModels) {
      try {
        final entities = driftModels
            .map((model) => ProductModel.fromDrift(model).toEntity())
            .toList();
        return Right(entities);
      } catch (e) {
        return Left(DatabaseFailure('Failed to parse products: $e'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    try {
      final companion = ProductsCompanion(
        storeId: drift.Value(product.storeId),
        categoryId: drift.Value(product.categoryId),
        name: drift.Value(product.name),
        price: drift.Value(product.price),
        imageUrl: drift.Value(product.imageUrl),
        description: drift.Value(product.description),
        status: drift.Value(product.status),
        createdAt: drift.Value(product.createdAt.millisecondsSinceEpoch),
        updatedAt: drift.Value(product.updatedAt.millisecondsSinceEpoch),
      );
      await _localDataSource.insertProduct(companion);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      final companion = ProductsCompanion(
        id: drift.Value(product.id),
        storeId: drift.Value(product.storeId),
        categoryId: drift.Value(product.categoryId),
        name: drift.Value(product.name),
        price: drift.Value(product.price),
        imageUrl: drift.Value(product.imageUrl),
        description: drift.Value(product.description),
        status: drift.Value(product.status),
        createdAt: drift.Value(product.createdAt.millisecondsSinceEpoch),
        updatedAt: drift.Value(product.updatedAt.millisecondsSinceEpoch),
      );
      await _localDataSource.updateProduct(companion);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await _localDataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete product: $e'));
    }
  }
}
