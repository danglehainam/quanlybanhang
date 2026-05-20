import 'package:drift/drift.dart';

import 'stores_table.dart';
import 'users_table.dart';

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  IntColumn get createdBy => integer().references(Users, #id)();
  IntColumn get customerId => integer().nullable()(); // Assuming Customers table exists or will exist
  IntColumn get totalAmount => integer()();
  IntColumn get discount => integer().withDefault(const Constant(0))();
  IntColumn get finalAmount => integer()();
  IntColumn get status => integer()(); // 0: pending, 1: completed, 2: cancelled
  TextColumn get note => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}
