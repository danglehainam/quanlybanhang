import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_table_entity.dart';
import '../repositories/customer_table_repository.dart';

class UpdateCustomerTableUseCase {
  final CustomerTableRepository repository;

  UpdateCustomerTableUseCase(this.repository);

  Future<Either<Failure, Unit>> execute(CustomerTableEntity table) {
    return repository.updateCustomerTable(table);
  }
}
