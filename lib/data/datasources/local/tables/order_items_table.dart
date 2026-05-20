import 'package:drift/drift.dart';

import 'orders_table.dart';
import 'products_table.dart';

class OrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer()();
  TextColumn get productName => text()();
  IntColumn get priceAtPurchase => integer()();
  IntColumn get subtotal => integer()();
}
