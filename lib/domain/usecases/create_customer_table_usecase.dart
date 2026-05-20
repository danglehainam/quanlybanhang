import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_table_entity.dart';
import '../repositories/customer_table_repository.dart';

class CreateCustomerTableUseCase {
  final CustomerTableRepository repository;

  CreateCustomerTableUseCase(this.repository);

  Future<Either<Failure, CustomerTableEntity>> execute(CustomerTableEntity table) {
    return repository.createCustomerTable(table);
  }
}
