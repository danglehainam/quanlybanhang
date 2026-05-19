import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<Either<Failure, void>> call(CategoryEntity category) {
    return _repository.createCategory(category);
  }
}
