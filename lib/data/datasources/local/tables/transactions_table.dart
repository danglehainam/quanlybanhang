import 'package:drift/drift.dart';
import 'stores_table.dart';
import 'users_table.dart';

@DataClassName('TransactionDriftModel')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer().references(Stores, #id)();
  IntColumn get createdBy => integer().references(Users, #id)();
  IntColumn get type => integer()();
  IntColumn get amount => integer()();
  TextColumn get note => text()();
  IntColumn get createdAt => integer()();
}
