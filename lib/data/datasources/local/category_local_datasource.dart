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
}
