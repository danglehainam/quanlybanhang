import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_entity.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CustomerEntity?>> findByPhone(int storeId, String phone);
  Future<Either<Failure, CustomerEntity>> createCustomer({
    required int storeId,
    required String name,
    required String phone,
  });
}
