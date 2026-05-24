import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_local_datasource.dart';
import '../datasources/local/app_database.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _localDataSource;

  CategoryRepositoryImpl(this._localDataSource);

  @override
  Stream<Either<Failure, List<CategoryEntity>>> watchCategories(int storeId) {
    return _localDataSource.watchCategories(storeId).map<Either<Failure, List<CategoryEntity>>>((driftModels) {
      try {
        final entities = driftModels
            .map((model) => CategoryModel.fromDrift(model).toEntity())
            .toList();
        return Right(entities);
      } catch (e) {
        return Left(DatabaseFailure('Failed to parse categories: $e'));
      }
    }).handleError((error, stackTrace) {
      // Stream.handleError doesn't change the stream's type, but we can't emit a new value easily without rxdart.
      // So we just throw it and let the caller catch it, or better:
      throw DatabaseFailure('Failed to watch categories: $error');
    });
  }

  @override
  Future<Either<Failure, void>> createCategory(CategoryEntity category) async {
    try {
      final companion = CategoriesCompanion.insert(
        storeId: category.storeId,
        name: category.name,
        description: drift.Value(category.description),
        createdAt: category.createdAt.millisecondsSinceEpoch,
        updatedAt: category.updatedAt.millisecondsSinceEpoch,
      );
      await _localDataSource.insertCategory(companion);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create category: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryEntity category) async {
    try {
      final companion = CategoriesCompanion(
        id: drift.Value(category.id),
        storeId: drift.Value(category.storeId),
        name: drift.Value(category.name),
        description: drift.Value(category.description),
        createdAt: drift.Value(category.createdAt.millisecondsSinceEpoch),
        updatedAt: drift.Value(category.updatedAt.millisecondsSinceEpoch),
      );
      await _localDataSource.updateCategory(companion);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update category: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await _localDataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete category: $e'));
    }
  }
}
