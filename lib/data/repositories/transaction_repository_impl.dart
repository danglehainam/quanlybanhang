import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/repositories/transaction_repository.dart';
import '../datasources/local/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Stream<Either<Failure, List<TransactionEntity>>> watchTransactions(int storeId) {
    return localDataSource.watchTransactions(storeId).map((models) {
      final entities = models.map((model) => model.toEntity()).toList();
      return Right<Failure, List<TransactionEntity>>(entities);
    }).handleError((error) {
      return Left<Failure, List<TransactionEntity>>(DatabaseFailure('Lỗi khi tải danh sách giao dịch: ${error.toString()}'));
    });
  }

  @override
  Future<Either<Failure, int>> createTransaction(TransactionEntity transaction) async {
    try {
      final model = TransactionModel.fromEntity(transaction);
      final id = await localDataSource.insertTransaction(model);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi tạo giao dịch: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTransaction(TransactionEntity transaction) async {
    try {
      final model = TransactionModel.fromEntity(transaction);
      final success = await localDataSource.updateTransaction(model);
      return Right(success);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi cập nhật giao dịch: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTransaction(int transactionId) async {
    try {
      final success = await localDataSource.deleteTransaction(transactionId);
      return Right(success);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi xóa giao dịch: ${e.toString()}'));
    }
  }
}
