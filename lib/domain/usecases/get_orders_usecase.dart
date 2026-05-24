import 'package:fpdart/fpdart.dart';

import '../../../core/error/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call({int? status}) {
    return repository.getOrders(status: status);
  }
}
