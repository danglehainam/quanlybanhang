import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) {
    return _repository.deleteProduct(id);
  }
}
