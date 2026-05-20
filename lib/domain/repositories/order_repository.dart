import 'package:fpdart/fpdart.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';

abstract class OrderRepository {
  /// Create a new order with its items in the local database.
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order);

  /// Fetch all completed/pending orders (if needed later)
  Future<Either<Failure, List<OrderEntity>>> getOrders({int? status});
}
