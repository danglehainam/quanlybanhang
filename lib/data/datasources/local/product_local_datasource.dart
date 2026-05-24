import 'package:drift/drift.dart';
import 'app_database.dart';

class ProductLocalDataSource {
  final AppDatabase _db;

  ProductLocalDataSource(this._db);

  Stream<List<ProductDriftModel>> watchProducts({
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? status,
    int? sortOption,
  }) {
    final stmt = _db.select(_db.products);

    // Apply where clauses
    stmt.where((tbl) {
      var predicate = const Constant(true) as Expression<bool>;
      if (query != null && query.isNotEmpty) {
        predicate = predicate & tbl.name.like('%$query%');
      }
      if (categoryId != null && categoryId > 0) {
        predicate = predicate & tbl.categoryId.equals(categoryId);
      }
      if (minPrice != null) {
        predicate = predicate & tbl.price.isBiggerOrEqualValue(minPrice);
      }
      if (maxPrice != null) {
        predicate = predicate & tbl.price.isSmallerOrEqualValue(maxPrice);
      }
      if (status != null) {
        predicate = predicate & tbl.status.equals(status);
      }
      return predicate;
    });

    // Apply ordering
    if (sortOption != null) {
      if (sortOption == 0) {
        stmt.orderBy([(tbl) => OrderingTerm(expression: tbl.price, mode: OrderingMode.asc)]);
      } else {
        stmt.orderBy([(tbl) => OrderingTerm(expression: tbl.price, mode: OrderingMode.desc)]);
      }
    } else {
      stmt.orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);
    }

    return stmt.watch();
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
