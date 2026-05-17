import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Stream<Either<Failure, List<CategoryEntity>>> call() {
    return _repository.watchCategories();
  }
}
