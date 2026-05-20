import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';

part 'sell_event.freezed.dart';

@freezed
class SellEvent with _$SellEvent {
  const factory SellEvent.loadInitialData() = LoadInitialDataEvent;
  const factory SellEvent.filterProducts(String query, int? categoryId) = FilterProductsEvent;
  
  // Order Management
  const factory SellEvent.addOrder() = AddOrderEvent;
  const factory SellEvent.selectOrder(int index) = SelectOrderEvent;
  const factory SellEvent.removeOrder(int index) = RemoveOrderEvent;
  
  // Order Items Management
  const factory SellEvent.addProductToOrder(ProductEntity product) = AddProductToOrderEvent;
  const factory SellEvent.updateItemQuantity(int itemIndex, int newQuantity) = UpdateItemQuantityEvent;
  const factory SellEvent.removeItem(int itemIndex) = RemoveItemEvent;
  
  // Actions
  const factory SellEvent.confirmOrder() = ConfirmOrderEvent;
  const factory SellEvent.completeOrder() = CompleteOrderEvent;
}
