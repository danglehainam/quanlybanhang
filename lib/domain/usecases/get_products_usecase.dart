import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Stream<Either<Failure, List<ProductEntity>>> call({
    required int storeId,
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? status,
    int? sortOption,
  }) {
    return _repository.watchProducts(
      storeId: storeId,
      query: query,
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      status: status,
      sortOption: sortOption,
    );
  }
}
