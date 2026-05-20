import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<Either<Failure, bool>> call(int transactionId) async {
    return repository.deleteTransaction(transactionId);
  }
}
