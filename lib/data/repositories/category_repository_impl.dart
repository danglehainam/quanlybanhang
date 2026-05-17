import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_local_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _localDataSource;

  CategoryRepositoryImpl(this._localDataSource);

  @override
  Stream<Either<Failure, List<CategoryEntity>>> watchCategories() {
    return _localDataSource.watchCategories().map<Either<Failure, List<CategoryEntity>>>((driftModels) {
      try {
        final entities = driftModels
            .map((model) => CategoryModel.fromDrift(model).toEntity())
            .toList();
        return Right(entities);
      } catch (e) {
        return Left(DatabaseFailure('Failed to parse categories: $e'));
      }
    }).handleError((error) {
      return Left(DatabaseFailure('Failed to watch categories: $error'));
    }).cast<Either<Failure, List<CategoryEntity>>>();
  }
}
