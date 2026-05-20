import 'package:fpdart/fpdart.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/customer_table_entity.dart';
import '../../../domain/repositories/customer_table_repository.dart';
import '../datasources/local/customer_table_local_datasource.dart';
import '../models/customer_table_model.dart';

class CustomerTableRepositoryImpl implements CustomerTableRepository {
  final CustomerTableLocalDataSource localDataSource;

  CustomerTableRepositoryImpl(this.localDataSource);

  @override
  Stream<Either<Failure, List<CustomerTableEntity>>> watchCustomerTables(int storeId) {
    return localDataSource.watchCustomerTables(storeId).map((models) {
      final entities = models.cast<CustomerTableEntity>().toList();
      return Right<Failure, List<CustomerTableEntity>>(entities);
    }).handleError((error) {
      return Left<Failure, List<CustomerTableEntity>>(DatabaseFailure('Lỗi khi tải danh sách bàn: ${error.toString()}'));
    });
  }

  @override
  Future<Either<Failure, CustomerTableEntity>> createCustomerTable(CustomerTableEntity table) async {
    try {
      final model = CustomerTableModel.fromEntity(table);
      final createdModel = await localDataSource.createCustomerTable(model);
      return Right(createdModel);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi tạo bàn mới: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomerTable(CustomerTableEntity table) async {
    try {
      final model = CustomerTableModel.fromEntity(table);
      await localDataSource.updateCustomerTable(model);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi cập nhật thông tin bàn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomerTable(int id) async {
    try {
      await localDataSource.deleteCustomerTable(id);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi xóa bàn: ${e.toString()}'));
    }
  }
}
