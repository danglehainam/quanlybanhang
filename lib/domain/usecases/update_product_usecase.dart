import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  Future<Either<Failure, void>> call(ProductEntity product) {
    if (product.name.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('Name cannot be empty')));
    }
    if (product.price < 0) {
      return Future.value(const Left(ValidationFailure('Price cannot be negative')));
    }
    return _repository.updateProduct(product);
  }
}
