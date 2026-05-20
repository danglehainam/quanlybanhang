import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  Future<Either<Failure, bool>> call(TransactionEntity transaction) async {
    if (transaction.amount <= 0) {
      return const Left(ValidationFailure('Số tiền giao dịch phải lớn hơn 0'));
    }
    if (transaction.note.trim().isEmpty) {
      return const Left(ValidationFailure('Vui lòng nhập ghi chú giao dịch'));
    }
    return repository.updateTransaction(transaction);
  }
}
