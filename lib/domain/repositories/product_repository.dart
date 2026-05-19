import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Stream<Either<Failure, List<ProductEntity>>> watchProducts();
  Future<Either<Failure, void>> createProduct(ProductEntity product);
  Future<Either<Failure, void>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(int id);
}
