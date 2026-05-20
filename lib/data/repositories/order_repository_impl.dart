import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart' as drift;

import '../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/local/app_database.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final AppDatabase localDatabase;

  OrderRepositoryImpl({required this.localDatabase});

  @override
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order) async {
    try {
      final createdOrderEntity = await localDatabase.transaction(() async {
        // Insert the order
        final orderId = await localDatabase.into(localDatabase.orders).insert(
          OrdersCompanion(
            storeId: drift.Value(order.storeId),
            createdBy: drift.Value(order.createdBy),
            customerId: drift.Value(order.customerId),
            totalAmount: drift.Value(order.totalAmount),
            discount: drift.Value(order.discount),
            finalAmount: drift.Value(order.finalAmount),
            status: drift.Value(order.status),
            note: drift.Value(order.note),
            createdAt: drift.Value(order.createdAt.millisecondsSinceEpoch),
            updatedAt: drift.Value(order.updatedAt.millisecondsSinceEpoch),
          ),
        );

        // Insert order items
        final itemsCompanions = order.items.map((item) {
          return OrderItemsCompanion(
            orderId: drift.Value(orderId),
            productId: drift.Value(item.productId),
            quantity: drift.Value(item.quantity),
            productName: drift.Value(item.productName),
            priceAtPurchase: drift.Value(item.priceAtPurchase),
            subtotal: drift.Value(item.subtotal),
          );
        }).toList();

        for (var item in itemsCompanions) {
          await localDatabase.into(localDatabase.orderItems).insert(item);
        }

        // Return the created order with its assigned ID
        return order.copyWith(id: orderId);
      });

      return Right(createdOrderEntity);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create order: $e'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({int? status}) async {
    try {
      final query = localDatabase.select(localDatabase.orders);
      if (status != null) {
        query.where((tbl) => tbl.status.equals(status));
      }
      
      final result = await query.get();
      
      // We are not eagerly fetching items here since this might be used for reporting.
      // If we need items, we'd fetch them in a loop or a join.
      final orders = result.map((row) => OrderModel.fromDrift(row)).toList();
      return Right(orders);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch orders: $e'));
    }
  }
}
