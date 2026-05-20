import 'package:drift/drift.dart';
import '../../models/customer_table_model.dart';
import 'app_database.dart';

class CustomerTableLocalDataSource {
  final AppDatabase db;

  CustomerTableLocalDataSource(this.db);

  Stream<List<CustomerTableModel>> watchCustomerTables(int storeId) {
    final query = db.select(db.customerTables)
      ..where((t) => t.storeId.equals(storeId) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]);
    
    return query.watch().map((rows) {
      return rows.map((row) => CustomerTableModel.fromDrift(row)).toList();
    });
  }

  Future<CustomerTableModel> createCustomerTable(CustomerTableModel table) async {
    final companion = CustomerTablesCompanion.insert(
      storeId: table.storeId,
      name: table.name,
      status: const Value(0),
      capacity: Value(table.capacity),
      isActive: const Value(true),
      createdAt: DateTime.now().toUtc().millisecondsSinceEpoch,
    );

    final id = await db.into(db.customerTables).insert(companion);
    final createdTable = await (db.select(db.customerTables)..where((t) => t.id.equals(id))).getSingle();
    return CustomerTableModel.fromDrift(createdTable);
  }

  Future<void> updateCustomerTable(CustomerTableModel table) async {
    final companion = CustomerTablesCompanion(
      name: Value(table.name),
      status: Value(table.status),
      capacity: Value(table.capacity),
      isActive: Value(table.isActive),
    );

    await (db.update(db.customerTables)..where((t) => t.id.equals(table.id))).write(companion);
  }

  Future<void> deleteCustomerTable(int id) async {
    // Soft delete
    final companion = const CustomerTablesCompanion(
      isActive: Value(false),
    );
    await (db.update(db.customerTables)..where((t) => t.id.equals(id))).write(companion);
  }
}
