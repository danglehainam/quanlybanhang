import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Stream<Either<Failure, List<CategoryEntity>>> watchCategories();
}
