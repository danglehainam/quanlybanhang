import 'package:drift/drift.dart';
import 'stores_table.dart';
import 'categories_table.dart';

@DataClassName('ProductDriftModel')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  TextColumn get name => text()();
  IntColumn get price => integer()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get recipe => text().nullable()();
  IntColumn get status => integer().withDefault(const Constant(1))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}
