import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_table_entity.dart';
import '../repositories/customer_table_repository.dart';

class GetCustomerTablesUseCase {
  final CustomerTableRepository repository;

  GetCustomerTablesUseCase(this.repository);

  Stream<Either<Failure, List<CustomerTableEntity>>> execute(int storeId) {
    return repository.watchCustomerTables(storeId);
  }
}
