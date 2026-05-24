import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/product_entity.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.loaded({
    required List<ProductEntity> allProducts,
    required List<ProductEntity> filteredProducts,
    @Default('') String searchQuery,
    int? selectedCategoryId,
    int? sortOption,
    int? minPrice,
    int? maxPrice,
    int? productStatus,
  }) = _Loaded;
  const factory ProductsState.error(String message) = _Error;
}
