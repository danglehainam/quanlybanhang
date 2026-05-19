import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quan_ly_ban_hang/core/error/failures.dart';
import 'package:quan_ly_ban_hang/domain/entities/product_entity.dart';
import 'package:quan_ly_ban_hang/domain/repositories/product_repository.dart';
import 'package:quan_ly_ban_hang/domain/usecases/create_product_usecase.dart';
import 'package:quan_ly_ban_hang/domain/usecases/delete_product_usecase.dart';
import 'package:quan_ly_ban_hang/domain/usecases/get_products_usecase.dart';
import 'package:quan_ly_ban_hang/domain/usecases/update_product_usecase.dart';

class MockProductRepository implements ProductRepository {
  List<ProductEntity> products = [];
  bool shouldFail = false;

  @override
  Stream<Either<Failure, List<ProductEntity>>> watchProducts() {
    if (shouldFail) {
      return Stream.value(const Left(DatabaseFailure('Database Error')));
    }
    return Stream.value(Right(products));
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    if (shouldFail) return const Left(DatabaseFailure('Error'));
    products.add(product);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    if (shouldFail) return const Left(DatabaseFailure('Error'));
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    if (shouldFail) return const Left(DatabaseFailure('Error'));
    products.removeWhere((p) => p.id == id);
    return const Right(null);
  }
}

void main() {
  late MockProductRepository mockRepository;
  late GetProductsUseCase getProductsUseCase;
  late CreateProductUseCase createProductUseCase;
  late UpdateProductUseCase updateProductUseCase;
  late DeleteProductUseCase deleteProductUseCase;

  final testProduct = ProductEntity(
    id: 1,
    storeId: 1,
    name: 'Test Product',
    price: 15000,
    status: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockRepository = MockProductRepository();
    getProductsUseCase = GetProductsUseCase(mockRepository);
    createProductUseCase = CreateProductUseCase(mockRepository);
    updateProductUseCase = UpdateProductUseCase(mockRepository);
    deleteProductUseCase = DeleteProductUseCase(mockRepository);
  });

  group('Product UseCases', () {
    test('GetProductsUseCase should return stream of products', () async {
      mockRepository.products = [testProduct];
      
      final stream = getProductsUseCase();
      final resultEither = await stream.first;
      
      expect(resultEither.isRight(), true);
      resultEither.fold(
        (l) => fail('Should not be left'),
        (products) {
          expect(products.length, 1);
          expect(products.first.name, 'Test Product');
        },
      );
    });

    test('CreateProductUseCase should add product', () async {
      final result = await createProductUseCase(testProduct);
      
      expect(result.isRight(), true);
      expect(mockRepository.products.length, 1);
      expect(mockRepository.products.first.name, 'Test Product');
    });

    test('UpdateProductUseCase should modify product', () async {
      mockRepository.products = [testProduct];
      
      final updatedProduct = ProductEntity(
        id: 1,
        storeId: 1,
        name: 'Updated Product',
        price: 20000,
        status: 1,
        createdAt: testProduct.createdAt,
        updatedAt: DateTime.now(),
      );
      
      final result = await updateProductUseCase(updatedProduct);
      
      expect(result.isRight(), true);
      expect(mockRepository.products.first.name, 'Updated Product');
      expect(mockRepository.products.first.price, 20000);
    });

    test('DeleteProductUseCase should remove product', () async {
      mockRepository.products = [testProduct];
      
      final result = await deleteProductUseCase(1);
      
      expect(result.isRight(), true);
      expect(mockRepository.products.isEmpty, true);
    });

    test('UseCases should return Failure when repository fails', () async {
      mockRepository.shouldFail = true;
      
      final createResult = await createProductUseCase(testProduct);
      expect(createResult.isLeft(), true);
      
      final updateResult = await updateProductUseCase(testProduct);
      expect(updateResult.isLeft(), true);
      
      final deleteResult = await deleteProductUseCase(1);
      expect(deleteResult.isLeft(), true);
    });
  });
}
