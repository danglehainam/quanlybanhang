import 'package:drift/drift.dart';

import 'stores_table.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {storeId, phone}
      ];
}
