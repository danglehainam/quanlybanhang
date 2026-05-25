import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart' as drift;

import '../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/local/app_database.dart';
import '../models/order_model.dart';
import '../models/customer_model.dart';
import '../models/customer_table_model.dart';
import '../models/order_item_model.dart';

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
            tableId: drift.Value(order.tableId),
            totalAmount: drift.Value(order.totalAmount),
            discountPercent: drift.Value(order.discountPercent),
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

        // Decrement stock for inventory-tracked products if completed (status == 1) or pending (status == 0)
        if (order.status == 0 || order.status == 1) {
          for (var item in order.items) {
            final productQuery = localDatabase.select(localDatabase.products)
              ..where((tbl) => tbl.id.equals(item.productId));
            final productDrift = await productQuery.getSingleOrNull();
            if (productDrift != null && productDrift.stock != null) {
              final newStock = productDrift.stock! - item.quantity;
              await (localDatabase.update(localDatabase.products)
                    ..where((tbl) => tbl.id.equals(item.productId)))
                  .write(ProductsCompanion(
                    stock: drift.Value(newStock),
                  ));
            }
          }
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
  Future<Either<Failure, OrderEntity>> updateOrder(OrderEntity order) async {
    try {
      await localDatabase.transaction(() async {
        // Fetch existing order to check old status
        final existingOrderQuery = localDatabase.select(localDatabase.orders)
              ..where((tbl) => tbl.id.equals(order.id));
        final existingOrder = await existingOrderQuery.getSingleOrNull();
        final int? oldStatus = existingOrder?.status;

        // Fetch old items from the database before deleting them
        final oldItemsQuery = localDatabase.select(localDatabase.orderItems)
          ..where((tbl) => tbl.orderId.equals(order.id));
        final oldItems = await oldItemsQuery.get();

        // 1. Refund stock for old items if previously status was 0 (Pending) or 1 (Completed)
        if (oldStatus == 0 || oldStatus == 1) {
          for (final oldItem in oldItems) {
            final productQuery = localDatabase.select(localDatabase.products)
              ..where((tbl) => tbl.id.equals(oldItem.productId));
            final productDrift = await productQuery.getSingleOrNull();
            if (productDrift != null && productDrift.stock != null) {
              final newStock = productDrift.stock! + oldItem.quantity;
              await (localDatabase.update(localDatabase.products)
                    ..where((tbl) => tbl.id.equals(oldItem.productId)))
                  .write(ProductsCompanion(
                stock: drift.Value(newStock),
              ));
            }
          }
        }

        // Update the order row in DB
        await (localDatabase.update(localDatabase.orders)
              ..where((tbl) => tbl.id.equals(order.id)))
            .write(
          OrdersCompanion(
            storeId: drift.Value(order.storeId),
            createdBy: drift.Value(order.createdBy),
            customerId: drift.Value(order.customerId),
            tableId: drift.Value(order.tableId),
            totalAmount: drift.Value(order.totalAmount),
            discountPercent: drift.Value(order.discountPercent),
            discount: drift.Value(order.discount),
            finalAmount: drift.Value(order.finalAmount),
            status: drift.Value(order.status),
            note: drift.Value(order.note),
            updatedAt: drift.Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );

        // Delete existing order items
        await (localDatabase.delete(localDatabase.orderItems)
              ..where((tbl) => tbl.orderId.equals(order.id)))
            .go();

        // Insert new order items
        final itemsCompanions = order.items.map((item) {
          return OrderItemsCompanion(
            orderId: drift.Value(order.id),
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

        // 2. Deduct stock for new items if new status is 0 (Pending) or 1 (Completed)
        if (order.status == 0 || order.status == 1) {
          for (var item in order.items) {
            final productQuery = localDatabase.select(localDatabase.products)
              ..where((tbl) => tbl.id.equals(item.productId));
            final productDrift = await productQuery.getSingleOrNull();
            if (productDrift != null && productDrift.stock != null) {
              final newStock = productDrift.stock! - item.quantity;
              await (localDatabase.update(localDatabase.products)
                    ..where((tbl) => tbl.id.equals(item.productId)))
                  .write(ProductsCompanion(
                stock: drift.Value(newStock),
              ));
            }
          }
        }
      });

      return Right(order);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update order: $e'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({int? status}) async {
    try {
      final query = localDatabase.select(localDatabase.orders).join([
        drift.leftOuterJoin(
          localDatabase.customers,
          localDatabase.customers.id.equalsExp(localDatabase.orders.customerId),
        ),
        drift.leftOuterJoin(
          localDatabase.customerTables,
          localDatabase.customerTables.id.equalsExp(localDatabase.orders.tableId),
        ),
      ]);
      
      if (status != null) {
        query.where(localDatabase.orders.status.equals(status));
      }
      
      final rows = await query.get();
      
      final List<OrderEntity> orders = [];
      for (final row in rows) {
        final orderRow = row.readTable(localDatabase.orders);
        final customerRow = row.readTableOrNull(localDatabase.customers);
        final tableRow = row.readTableOrNull(localDatabase.customerTables);
        
        // Fetch order items for this order
        final itemsQuery = localDatabase.select(localDatabase.orderItems)
          ..where((tbl) => tbl.orderId.equals(orderRow.id));
        final itemsResult = await itemsQuery.get();
        final items = itemsResult.map((itemRow) => OrderItemModel.fromDrift(itemRow)).toList();
        
        orders.add(OrderModel.fromDrift(
          orderRow,
          items: items,
        ).copyWith(
          customer: customerRow != null ? CustomerModel.toEntity(customerRow) : null,
          table: tableRow != null ? CustomerTableModel.fromDrift(tableRow) : null,
        ));
      }
      
      return Right(orders);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch orders: $e'));
    }
  }
}
