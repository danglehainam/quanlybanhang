import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Stream<Either<Failure, List<TransactionEntity>>> watchTransactions(int storeId);
  Future<Either<Failure, int>> createTransaction(TransactionEntity transaction);
  Future<Either<Failure, bool>> updateTransaction(TransactionEntity transaction);
  Future<Either<Failure, bool>> deleteTransaction(int transactionId);
}
