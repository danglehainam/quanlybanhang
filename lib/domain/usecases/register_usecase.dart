import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String userName,
    required String storeName,
  }) {
    return repository.register(
      email: email,
      password: password,
      userName: userName,
      storeName: storeName,
    );
  }
}
