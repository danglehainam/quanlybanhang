import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/product_entity.dart';

part 'products_event.freezed.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.watchProducts() = WatchProducts;
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
