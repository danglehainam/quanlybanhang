import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Stream<Either<Failure, List<ProductEntity>>> call() {
    return _repository.watchProducts();
  }
}
