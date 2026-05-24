import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class CreateCustomerUseCase {
  final CustomerRepository repository;

  CreateCustomerUseCase(this.repository);

  Future<Either<Failure, CustomerEntity>> call({
    required int storeId,
    required String name,
    required String phone,
  }) async {
    if (phone.isEmpty || name.isEmpty) {
      return Left(ValidationFailure('Tên và số điện thoại không được để trống'));
    }
    return await repository.createCustomer(
      storeId: storeId,
      name: name,
      phone: phone,
    );
  }
}
