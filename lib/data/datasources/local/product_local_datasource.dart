import 'app_database.dart';

class ProductLocalDataSource {
  final AppDatabase _db;

  ProductLocalDataSource(this._db);

  Stream<List<ProductDriftModel>> watchProducts() {
    return _db.select(_db.products).watch();
  }

  Future<void> insertProduct(ProductsCompanion companion) async {
    await _db.into(_db.products).insert(companion);
  }

  Future<void> updateProduct(ProductsCompanion companion) async {
    await _db.update(_db.products).replace(companion);
  }

  Future<void> deleteProduct(int id) async {
    await (_db.delete(_db.products)..where((tbl) => tbl.id.equals(id))).go();
  }
}
