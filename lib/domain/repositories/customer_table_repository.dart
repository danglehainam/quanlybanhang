import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_table_entity.dart';

abstract class CustomerTableRepository {
  Stream<Either<Failure, List<CustomerTableEntity>>> watchCustomerTables(int storeId);
  Future<Either<Failure, CustomerTableEntity>> createCustomerTable(CustomerTableEntity table);
  Future<Either<Failure, Unit>> updateCustomerTable(CustomerTableEntity table);
  Future<Either<Failure, Unit>> deleteCustomerTable(int id);
}
