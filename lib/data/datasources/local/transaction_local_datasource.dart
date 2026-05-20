import 'package:drift/drift.dart';
import '../../models/transaction_model.dart';
import 'app_database.dart';

class TransactionLocalDataSource {
  final AppDatabase db;

  TransactionLocalDataSource(this.db);

  Stream<List<TransactionModel>> watchTransactions(int storeId) {
    final query = db.select(db.transactions)
      ..where((t) => t.storeId.equals(storeId))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]);
      
    return query.watch().map((rows) {
      return rows.map((row) => TransactionModel.fromDrift(row)).toList();
    });
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    final companion = TransactionsCompanion.insert(
      storeId: transaction.storeId,
      createdBy: transaction.createdBy,
      type: transaction.type,
      amount: transaction.amount,
      note: transaction.note,
      createdAt: transaction.createdAt.millisecondsSinceEpoch,
    );
    return await db.into(db.transactions).insert(companion);
  }

  Future<bool> updateTransaction(TransactionModel transaction) async {
    final companion = TransactionsCompanion(
      id: Value(transaction.id),
      storeId: Value(transaction.storeId),
      createdBy: Value(transaction.createdBy),
      type: Value(transaction.type),
      amount: Value(transaction.amount),
      note: Value(transaction.note),
      createdAt: Value(transaction.createdAt.millisecondsSinceEpoch),
    );
    return await db.update(db.transactions).replace(companion);
  }

  Future<bool> deleteTransaction(int transactionId) async {
    final deletedCount = await (db.delete(db.transactions)..where((t) => t.id.equals(transactionId))).go();
    return deletedCount > 0;
  }
}
