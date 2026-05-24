import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/customer_table_entity.dart';

part 'sell_event.freezed.dart';

@freezed
class SellEvent with _$SellEvent {
  const factory SellEvent.loadInitialData({required int storeId}) = LoadInitialDataEvent;
  const factory SellEvent.filterProducts({
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? productStatus,
    int? sortOption,
  }) = FilterProductsEvent;
  
  // Order Management
  const factory SellEvent.addOrder() = AddOrderEvent;
  const factory SellEvent.selectOrder(int index) = SelectOrderEvent;
  const factory SellEvent.removeOrder(int index) = RemoveOrderEvent;
  
  // Order Items Management
  const factory SellEvent.updateCustomer(CustomerEntity? customer) = UpdateCustomerEvent;
  const factory SellEvent.updateTable(CustomerTableEntity? table) = UpdateTableEvent;
  const factory SellEvent.updateDiscount({int? discountAmount, double? discountPercent}) = UpdateDiscountEvent;
  const factory SellEvent.updateNote(String? note) = UpdateNoteEvent;
  const factory SellEvent.addProductToOrder(ProductEntity product) = AddProductToOrderEvent;
  const factory SellEvent.updateItemQuantity(int itemIndex, int newQuantity) = UpdateItemQuantityEvent;
  const factory SellEvent.removeItem(int itemIndex) = RemoveItemEvent;
  
  // Actions
  const factory SellEvent.confirmOrder() = ConfirmOrderEvent;
  const factory SellEvent.completeOrder() = CompleteOrderEvent;
}
