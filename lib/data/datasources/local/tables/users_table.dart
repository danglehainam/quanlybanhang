import 'package:drift/drift.dart';
import 'stores_table.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get name => text()();
  IntColumn get isOwner => integer().withDefault(const Constant(0))();
  IntColumn get roleId => integer().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}
