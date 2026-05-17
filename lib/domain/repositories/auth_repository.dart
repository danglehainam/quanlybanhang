import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String userName,
    required String storeName,
  });
  Future<Either<Failure, UserEntity>> getUserById(int userId);
}
