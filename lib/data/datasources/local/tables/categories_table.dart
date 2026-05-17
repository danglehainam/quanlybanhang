import 'package:drift/drift.dart';

@DataClassName('CategoryDriftModel')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}
