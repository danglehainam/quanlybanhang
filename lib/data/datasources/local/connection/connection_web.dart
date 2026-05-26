import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor createDatabaseConnection() {
  return DatabaseConnection.delayed(
    WasmDatabase.open(
      databaseName: 'quan_ly_ban_hang',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    ).then((result) => result.resolvedExecutor),
  );
}
