import 'app_database.dart';

class CategoryLocalDataSource {
  final AppDatabase _db;

  CategoryLocalDataSource(this._db);

  Stream<List<CategoryDriftModel>> watchCategories() {
    return _db.select(_db.categories).watch();
  }

  Future<void> insertCategory(CategoriesCompanion companion) async {
    await _db.into(_db.categories).insert(companion);
  }

  Future<void> updateCategory(CategoriesCompanion companion) async {
    await _db.update(_db.categories).replace(companion);
  }

  Future<void> deleteCategory(int id) async {
    await (_db.delete(_db.categories)..where((tbl) => tbl.id.equals(id))).go();
  }
}
