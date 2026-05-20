import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../repositories/customer_table_repository.dart';

class DeleteCustomerTableUseCase {
  final CustomerTableRepository repository;

  DeleteCustomerTableUseCase(this.repository);

  Future<Either<Failure, Unit>> execute(int id) {
    return repository.deleteCustomerTable(id);
  }
}
