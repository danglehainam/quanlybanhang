import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/local/customer_local_datasource.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, CustomerEntity?>> findByPhone(int storeId, String phone) async {
    try {
      final customer = await localDataSource.getCustomerByPhone(storeId, phone);
      if (customer == null) {
        return const Right(null);
      }
      return Right(CustomerModel.toEntity(customer));
    } catch (e) {
      return Left(DatabaseFailure('Lỗi tìm kiếm khách hàng: $e'));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> createCustomer({
    required int storeId,
    required String name,
    required String phone,
  }) async {
    try {
      final customer = await localDataSource.createCustomer(
        storeId: storeId,
        name: name,
        phone: phone,
      );
      return Right(CustomerModel.toEntity(customer));
    } catch (e) {
      return Left(DatabaseFailure('Lỗi tạo khách hàng: $e'));
    }
  }
}
