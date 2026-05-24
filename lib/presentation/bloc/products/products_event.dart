import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/product_entity.dart';

part 'products_event.freezed.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.watchProducts({
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? productStatus,
    int? sortOption,
  }) = WatchProducts;
  
  const factory ProductsEvent.productsUpdated(
    Either<Failure, List<ProductEntity>> result, {
    String? searchQuery,
    int? selectedCategoryId,
    int? minPrice,
    int? maxPrice,
    int? productStatus,
    int? sortOption,
  }) = ProductsUpdated;
  const factory ProductsEvent.createProduct(
    ProductEntity product, {
    required void Function() onSuccess,
    required void Function(String) onError,
  }) = CreateProduct;
  const factory ProductsEvent.updateProduct(
    ProductEntity product, {
    required void Function() onSuccess,
    required void Function(String) onError,
  }) = UpdateProduct;
  const factory ProductsEvent.deleteProduct(
    int id, {
    required void Function() onSuccess,
    required void Function(String) onError,
  }) = DeleteProduct;
}
