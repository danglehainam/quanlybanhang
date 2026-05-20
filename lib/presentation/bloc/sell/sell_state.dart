import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/entities/category_entity.dart';

part 'sell_state.freezed.dart';

@freezed
abstract class SellState with _$SellState {
  const factory SellState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductEntity> allProducts,
    @Default([]) List<ProductEntity> filteredProducts,
    @Default([]) List<CategoryEntity> categories,
    
    // POS Draft Orders
    @Default([]) List<OrderEntity> draftOrders,
    @Default(0) int selectedOrderIndex,
    
    @Default('') String searchQuery,
    int? selectedCategoryId,
    
    // KiotViet advanced filters
    int? minPrice,
    int? maxPrice,
    int? productStatus, // 1: Active, 0: Inactive
    int? sortOption, // 0: Price Ascending, 1: Price Descending
    
    String? error,
    @Default(false) bool isActionSuccess, // Used for showing success snackbar
  }) = _SellState;
}
