import 'package:drift/drift.dart';
import 'stores_table.dart';

class CustomerTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  TextColumn get name => text()();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0: Available, 1: Occupied, 2: Reserved
  IntColumn get capacity => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();
}
