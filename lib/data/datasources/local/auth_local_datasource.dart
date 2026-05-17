import 'app_database.dart';

class AuthLocalDataSource {
  final AppDatabase _db;

  AuthLocalDataSource(this._db);

  Future<User?> findUserByEmail(String email) {
    return (_db.select(_db.users)
          ..where((u) => u.email.equals(email)))
        .getSingleOrNull();
  }

  Future<User?> findUserById(int id) {
    return (_db.select(_db.users)
          ..where((u) => u.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> createStore(StoresCompanion store) {
    return _db.into(_db.stores).insert(store);
  }

  Future<int> createUser(UsersCompanion user) {
    return _db.into(_db.users).insert(user);
  }
}
