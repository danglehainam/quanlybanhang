import 'package:fpdart/fpdart.dart';

import '../../../core/error/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class UpdateOrderUseCase {
  final OrderRepository repository;

  UpdateOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(OrderEntity order) {
    return repository.updateOrder(order);
  }
}
