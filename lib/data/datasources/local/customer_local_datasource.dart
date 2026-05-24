import 'package:drift/drift.dart';
import 'app_database.dart';

abstract class CustomerLocalDataSource {
  Future<Customer?> getCustomerByPhone(int storeId, String phone);
  Future<Customer> createCustomer({
    required int storeId,
    required String name,
    required String phone,
  });
}

class CustomerLocalDataSourceImpl implements CustomerLocalDataSource {
  final AppDatabase database;

  CustomerLocalDataSourceImpl(this.database);

  @override
  Future<Customer?> getCustomerByPhone(int storeId, String phone) async {
    return await (database.select(database.customers)
          ..where((t) => t.storeId.equals(storeId) & t.phone.equals(phone)))
        .getSingleOrNull();
  }

  @override
  Future<Customer> createCustomer({
    required int storeId,
    required String name,
    required String phone,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final companion = CustomersCompanion.insert(
      storeId: storeId,
      name: name,
      phone: phone,
      createdAt: now,
      updatedAt: now,
    );

    final id = await database.into(database.customers).insert(companion);
    return await (database.select(database.customers)..where((t) => t.id.equals(id))).getSingle();
  }
}
