import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quan_ly_ban_hang/data/datasources/local/app_database.dart';
import 'package:quan_ly_ban_hang/data/datasources/local/product_local_datasource.dart';
import 'package:quan_ly_ban_hang/data/repositories/product_repository_impl.dart';
import 'package:quan_ly_ban_hang/domain/entities/product_entity.dart';

class MockProductLocalDataSource implements ProductLocalDataSource {
  final List<ProductDriftModel> _products = [];
  bool shouldThrow = false;

  @override
  Stream<List<ProductDriftModel>> watchProducts() {
    if (shouldThrow) return Stream.error(Exception('Database Error'));
    return Stream.value(_products);
  }

  @override
  Future<int> insertProduct(ProductsCompanion product) async {
    if (shouldThrow) throw Exception('Database Error');
    return 1;
  }

  @override
  Future<bool> updateProduct(ProductsCompanion product) async {
    if (shouldThrow) throw Exception('Database Error');
    return true;
  }

  @override
  Future<int> deleteProduct(int id) async {
    if (shouldThrow) throw Exception('Database Error');
    return 1;
  }
}

void main() {
  late MockProductLocalDataSource mockDataSource;
  late ProductRepositoryImpl repository;

  final testEntity = ProductEntity(
    id: 1,
    storeId: 1,
    name: 'Test Product',
    price: 15000,
    imageUrl: 'path/to/image.jpg',
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockDataSource = MockProductLocalDataSource();
    repository = ProductRepositoryImpl(mockDataSource);
  });

  group('ProductRepositoryImpl', () {
    test('createProduct should return Right(null) when successful', () async {
      final result = await repository.createProduct(testEntity);
      expect(result.isRight(), true);
    });

    test('createProduct should return Left(DatabaseFailure) when exception occurs', () async {
      mockDataSource.shouldThrow = true;
      final result = await repository.createProduct(testEntity);
      expect(result.isLeft(), true);
    });

    test('updateProduct should return Right(null) when successful', () async {
      final result = await repository.updateProduct(testEntity);
      expect(result.isRight(), true);
    });

    test('updateProduct should return Left(DatabaseFailure) when exception occurs', () async {
      mockDataSource.shouldThrow = true;
      final result = await repository.updateProduct(testEntity);
      expect(result.isLeft(), true);
    });

    test('deleteProduct should return Right(null) when successful', () async {
      final result = await repository.deleteProduct(1);
      expect(result.isRight(), true);
    });

    test('deleteProduct should return Left(DatabaseFailure) when exception occurs', () async {
      mockDataSource.shouldThrow = true;
      final result = await repository.deleteProduct(1);
      expect(result.isLeft(), true);
    });
  });
}
