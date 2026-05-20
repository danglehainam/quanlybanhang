import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/stores_table.dart';
import 'tables/users_table.dart';
import 'tables/categories_table.dart';
import 'tables/products_table.dart';
import 'tables/orders_table.dart';
import 'tables/order_items_table.dart';
import 'tables/transactions_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Stores,
  Users,
  Categories,
  Products,
  Orders,
  OrderItems,
  Transactions,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 3) {
            await m.createTable(categories);
          }
          if (from < 4) {
            await m.createTable(products);
          }
          if (from < 5) {
            await m.addColumn(products, products.imageUrl);
          }
          if (from < 6) {
            await m.createTable(orders);
            await m.createTable(orderItems);
          }
          if (from < 7) {
            await m.createTable(transactions);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quan_ly_ban_hang.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
