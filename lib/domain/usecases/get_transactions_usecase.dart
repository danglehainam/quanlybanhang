import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Stream<Either<Failure, List<TransactionEntity>>> call(int storeId) {
    return repository.watchTransactions(storeId);
  }
}
