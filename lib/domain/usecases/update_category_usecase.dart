import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<Either<Failure, void>> call(CategoryEntity category) {
    return _repository.updateCategory(category);
  }
}
