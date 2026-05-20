import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/order_item_entity.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import 'sell_event.dart';
import 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final OrderRepository orderRepository;
  final SharedPreferences prefs;

  SellBloc({
    required this.productRepository,
    required this.categoryRepository,
    required this.orderRepository,
    required this.prefs,
  }) : super(const SellState()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<FilterProductsEvent>(_onFilterProducts);
    on<AddOrderEvent>(_onAddOrder);
    on<SelectOrderEvent>(_onSelectOrder);
    on<RemoveOrderEvent>(_onRemoveOrder);
    on<AddProductToOrderEvent>(_onAddProductToOrder);
    on<UpdateItemQuantityEvent>(_onUpdateItemQuantity);
    on<RemoveItemEvent>(_onRemoveItem);
    on<ConfirmOrderEvent>(_onConfirmOrder);
    on<CompleteOrderEvent>(_onCompleteOrder);
  }

  Future<void> _onLoadInitialData(LoadInitialDataEvent event, Emitter<SellState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final productsResult = await productRepository.watchProducts().first;
    final categoriesResult = await categoryRepository.watchCategories().first;

    productsResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (products) {
        categoriesResult.fold(
          (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
          (categories) {
            final activeProducts = products.where((p) => p.status == 1).toList();
            emit(state.copyWith(
              isLoading: false,
              allProducts: activeProducts,
              filteredProducts: activeProducts,
              categories: categories,
            ));
            
            // Add a default empty order if none exists
            if (state.draftOrders.isEmpty) {
              add(const SellEvent.addOrder());
            }
          },
        );
      },
    );
  }

  void _onFilterProducts(FilterProductsEvent event, Emitter<SellState> emit) {
    final query = event.query.toLowerCase();
    final categoryId = event.categoryId;

    final filtered = state.allProducts.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(query);
      final matchesCategory = categoryId == null || categoryId == 0 || p.categoryId == categoryId;
      return matchesSearch && matchesCategory;
    }).toList();

    emit(state.copyWith(
      searchQuery: event.query,
      selectedCategoryId: categoryId,
      filteredProducts: filtered,
    ));
  }

  void _onAddOrder(AddOrderEvent event, Emitter<SellState> emit) {
    final newOrder = OrderEntity(
      id: DateTime.now().millisecondsSinceEpoch, // temporary ID for UI mapping
      storeId: 1, // Need to get actual store ID from Auth state or Prefs
      createdBy: 1, // Need to get actual user ID
      totalAmount: 0,
      finalAmount: 0,
      status: 0, // Pending
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      items: [],
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders)..add(newOrder);
    
    emit(state.copyWith(
      draftOrders: updatedDrafts,
      selectedOrderIndex: updatedDrafts.length - 1,
    ));
  }

  void _onSelectOrder(SelectOrderEvent event, Emitter<SellState> emit) {
    if (event.index >= 0 && event.index < state.draftOrders.length) {
      emit(state.copyWith(selectedOrderIndex: event.index));
    }
  }

  void _onRemoveOrder(RemoveOrderEvent event, Emitter<SellState> emit) {
    if (event.index >= 0 && event.index < state.draftOrders.length) {
      final updatedDrafts = List<OrderEntity>.from(state.draftOrders)..removeAt(event.index);
      
      int newSelectedIndex = state.selectedOrderIndex;
      if (newSelectedIndex >= updatedDrafts.length) {
        newSelectedIndex = updatedDrafts.length - 1;
      }
      if (newSelectedIndex < 0) {
        newSelectedIndex = 0;
      }

      emit(state.copyWith(
        draftOrders: updatedDrafts,
        selectedOrderIndex: newSelectedIndex,
      ));
      
      // Keep at least one order
      if (updatedDrafts.isEmpty) {
        add(const SellEvent.addOrder());
      }
    }
  }

  void _onAddProductToOrder(AddProductToOrderEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];
    final product = event.product;

    final existingItemIndex = order.items.indexWhere((item) => item.productId == product.id);
    List<OrderItemEntity> updatedItems = List.from(order.items);

    if (existingItemIndex >= 0) {
      // Increase quantity
      final item = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = item.copyWith(
        quantity: item.quantity + 1,
        subtotal: (item.quantity + 1) * item.priceAtPurchase,
      );
    } else {
      // Add new item
      updatedItems.add(OrderItemEntity(
        id: DateTime.now().millisecondsSinceEpoch, // temp ID
        orderId: order.id,
        productId: product.id,
        quantity: 1,
        productName: product.name,
        priceAtPurchase: product.price,
        subtotal: product.price,
      ));
    }

    _updateOrderInDrafts(emit, orderIndex, updatedItems);
  }

  void _onUpdateItemQuantity(UpdateItemQuantityEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];
    
    if (event.itemIndex >= 0 && event.itemIndex < order.items.length) {
      if (event.newQuantity <= 0) {
        add(SellEvent.removeItem(event.itemIndex));
        return;
      }
      
      List<OrderItemEntity> updatedItems = List.from(order.items);
      final item = updatedItems[event.itemIndex];
      updatedItems[event.itemIndex] = item.copyWith(
        quantity: event.newQuantity,
        subtotal: event.newQuantity * item.priceAtPurchase,
      );

      _updateOrderInDrafts(emit, orderIndex, updatedItems);
    }
  }

  void _onRemoveItem(RemoveItemEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];
    
    if (event.itemIndex >= 0 && event.itemIndex < order.items.length) {
      List<OrderItemEntity> updatedItems = List.from(order.items)..removeAt(event.itemIndex);
      _updateOrderInDrafts(emit, orderIndex, updatedItems);
    }
  }

  void _updateOrderInDrafts(Emitter<SellState> emit, int orderIndex, List<OrderItemEntity> updatedItems) {
    final order = state.draftOrders[orderIndex];
    final int totalAmount = updatedItems.fold(0, (sum, item) => sum + item.subtotal);
    final int finalAmount = totalAmount - order.discount;

    final updatedOrder = order.copyWith(
      items: updatedItems,
      totalAmount: totalAmount,
      finalAmount: finalAmount > 0 ? finalAmount : 0,
      updatedAt: DateTime.now(),
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
    updatedDrafts[orderIndex] = updatedOrder;

    emit(state.copyWith(draftOrders: updatedDrafts));
  }

  Future<void> _onConfirmOrder(ConfirmOrderEvent event, Emitter<SellState> emit) async {
    await _saveOrder(emit, 0); // Status 0: pending
  }

  Future<void> _onCompleteOrder(CompleteOrderEvent event, Emitter<SellState> emit) async {
    await _saveOrder(emit, 1); // Status 1: completed
  }

  Future<void> _saveOrder(Emitter<SellState> emit, int status) async {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final orderToSave = state.draftOrders[orderIndex];

    if (orderToSave.items.isEmpty) {
      emit(state.copyWith(error: 'Đơn hàng trống, không thể lưu.'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, isActionSuccess: false));

    // Update status before saving
    final updatedOrder = orderToSave.copyWith(status: status, updatedAt: DateTime.now());

    final result = await orderRepository.createOrder(updatedOrder);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (savedOrder) {
        // Remove the saved order from drafts
        final updatedDrafts = List<OrderEntity>.from(state.draftOrders)..removeAt(orderIndex);
        
        int newSelectedIndex = state.selectedOrderIndex;
        if (newSelectedIndex >= updatedDrafts.length) {
          newSelectedIndex = updatedDrafts.length - 1;
        }
        if (newSelectedIndex < 0) {
          newSelectedIndex = 0;
        }

        emit(state.copyWith(
          isLoading: false,
          isActionSuccess: true,
          draftOrders: updatedDrafts,
          selectedOrderIndex: newSelectedIndex,
        ));
        
        // Reset success flag
        emit(state.copyWith(isActionSuccess: false));

        // If no more drafts, create a new empty one
        if (updatedDrafts.isEmpty) {
          add(const SellEvent.addOrder());
        }
      },
    );
  }
}
