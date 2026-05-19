import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) {
    return _repository.deleteCategory(id);
  }
}
