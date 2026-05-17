import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await _localDataSource.findUserByEmail(email);
      if (user == null) {
        return const Left(AuthFailure('Email không tồn tại'));
      }

      if (user.isActive == 0) {
        return const Left(AuthFailure('Tài khoản đã bị vô hiệu hóa'));
      }

      final hashedPassword = _hashPassword(password);
      if (user.passwordHash != hashedPassword) {
        return const Left(AuthFailure('Mật khẩu không đúng'));
      }

      return Right(_userToEntity(user));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String userName,
    required String storeName,
  }) async {
    try {
      // Business validation: check duplicate email
      final existingUser = await _localDataSource.findUserByEmail(email);
      if (existingUser != null) {
        return const Left(ValidationFailure('Email đã được sử dụng'));
      }

      final now = DateTime.now().toUtc().millisecondsSinceEpoch;

      // Create store first
      final storeId = await _localDataSource.createStore(
        StoresCompanion.insert(
          name: storeName,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Create user as owner
      final userId = await _localDataSource.createUser(
        UsersCompanion.insert(
          storeId: storeId,
          email: email,
          passwordHash: _hashPassword(password),
          name: userName,
          isOwner: const Value(1),
          isActive: const Value(1),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Return the created user
      final createdUser = await _localDataSource.findUserById(userId);
      if (createdUser == null) {
        return const Left(DatabaseFailure('Không thể tạo tài khoản'));
      }

      return Right(_userToEntity(createdUser));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int userId) async {
    try {
      final user = await _localDataSource.findUserById(userId);
      if (user == null) {
        return const Left(AuthFailure('Không tìm thấy tài khoản'));
      }
      return Right(_userToEntity(user));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  UserEntity _userToEntity(User user) {
    return UserEntity(
      id: user.id,
      storeId: user.storeId,
      email: user.email,
      name: user.name,
      isOwner: user.isOwner == 1,
      roleId: user.roleId,
      isActive: user.isActive == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(user.createdAt, isUtc: true),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(user.updatedAt, isUtc: true),
    );
  }
}
