import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class FindCustomerByPhoneUseCase {
  final CustomerRepository repository;

  FindCustomerByPhoneUseCase(this.repository);

  Future<Either<Failure, CustomerEntity?>> call(int storeId, String phone) async {
    return await repository.findByPhone(storeId, phone);
  }
}
