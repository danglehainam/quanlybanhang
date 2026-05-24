import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/order_item_entity.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/usecases/update_order_usecase.dart';
import 'sell_event.dart';
import 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final OrderRepository orderRepository;
  final UpdateOrderUseCase updateOrderUseCase;
  final SharedPreferences prefs;

  SellBloc({
    required this.productRepository,
    required this.categoryRepository,
    required this.orderRepository,
    required this.updateOrderUseCase,
    required this.prefs,
  }) : super(const SellState()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<FilterProductsEvent>(_onFilterProducts);
    on<AddOrderEvent>(_onAddOrder);
    on<SelectOrderEvent>(_onSelectOrder);
    on<RemoveOrderEvent>(_onRemoveOrder);
    on<UpdateCustomerEvent>(_onUpdateCustomer);
    on<UpdateTableEvent>(_onUpdateTable);
    on<UpdateDiscountEvent>(_onUpdateDiscount);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<AddProductToOrderEvent>(_onAddProductToOrder);
    on<UpdateItemQuantityEvent>(_onUpdateItemQuantity);
    on<RemoveItemEvent>(_onRemoveItem);
    on<ConfirmOrderEvent>(_onConfirmOrder);
    on<CompleteOrderEvent>(_onCompleteOrder);
  }

  Future<void> _onLoadInitialData(LoadInitialDataEvent event, Emitter<SellState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final productsResult = await productRepository.watchProducts(storeId: event.storeId).first;
    final categoriesResult = await categoryRepository.watchCategories(event.storeId).first;

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
    final query = event.query ?? '';
    final categoryId = event.categoryId;
    final minPrice = event.minPrice;
    final maxPrice = event.maxPrice;
    final productStatus = event.productStatus;
    final sortOption = event.sortOption;

    var filtered = state.allProducts.where((p) {
      // 1. Search Query
      final matchesSearch = query.isEmpty || p.name.toLowerCase().contains(query.toLowerCase());
      
      // 2. Category
      final matchesCategory = categoryId == null || categoryId == 0 || p.categoryId == categoryId;
      
      // 3. Price Range
      final matchesMinPrice = minPrice == null || p.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || p.price <= maxPrice;
      
      // 4. Status
      final matchesStatus = productStatus == null || p.status == productStatus;
      
      return matchesSearch && matchesCategory && matchesMinPrice && matchesMaxPrice && matchesStatus;
    }).toList();

    // 5. Sort
    if (sortOption != null) {
      filtered.sort((a, b) {
        if (sortOption == 0) {
          return a.price.compareTo(b.price); // Ascending
        } else {
          return b.price.compareTo(a.price); // Descending
        }
      });
    }

    emit(state.copyWith(
      searchQuery: query,
      selectedCategoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      productStatus: productStatus,
      sortOption: sortOption,
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

  void _onUpdateCustomer(UpdateCustomerEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];

    final updatedOrder = order.copyWith(
      customer: event.customer,
      customerId: event.customer?.id,
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
    updatedDrafts[orderIndex] = updatedOrder;

    emit(state.copyWith(draftOrders: updatedDrafts));
  }

  void _onUpdateTable(UpdateTableEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];

    final updatedOrder = order.copyWith(
      table: event.table,
      tableId: event.table?.id,
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
    updatedDrafts[orderIndex] = updatedOrder;

    emit(state.copyWith(draftOrders: updatedDrafts));
  }

  void _onUpdateDiscount(UpdateDiscountEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];

    int newDiscountAmount = event.discountAmount ?? 0;
    
    // Auto-calculate if percent is provided but amount is missing
    if (event.discountPercent != null && event.discountAmount == null) {
      newDiscountAmount = (order.totalAmount * (event.discountPercent! / 100)).round();
    }

    int finalAmount = order.totalAmount - newDiscountAmount;
    if (finalAmount < 0) finalAmount = 0;

    final updatedOrder = order.copyWith(
      discount: newDiscountAmount,
      finalAmount: finalAmount,
      discountPercent: event.discountPercent,
      clearDiscountPercent: event.discountPercent == null, // clear it if null
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
    updatedDrafts[orderIndex] = updatedOrder;

    emit(state.copyWith(draftOrders: updatedDrafts));
  }

  void _onUpdateNote(UpdateNoteEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];

    final updatedOrder = order.copyWith(
      note: event.note,
    );

    final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
    updatedDrafts[orderIndex] = updatedOrder;

    emit(state.copyWith(draftOrders: updatedDrafts));
  }

  void _onAddProductToOrder(AddProductToOrderEvent event, Emitter<SellState> emit) {
    if (state.draftOrders.isEmpty) return;
    
    final orderIndex = state.selectedOrderIndex;
    final order = state.draftOrders[orderIndex];
    final product = event.product;

    final existingItemIndex = order.items.indexWhere((item) => item.productId == product.id);

    // Validate stock limit
    if (product.stock != null) {
      final currentQtyInCart = existingItemIndex >= 0 ? order.items[existingItemIndex].quantity : 0;
      if (currentQtyInCart >= product.stock!) {
        emit(state.copyWith(error: 'Sản phẩm ${product.name} đã đạt số lượng tồn kho tối đa (${product.stock}).'));
        emit(state.copyWith(error: null));
        return;
      }
    }

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

      final item = order.items[event.itemIndex];

      // Validate stock limit
      final product = state.allProducts.firstWhere((p) => p.id == item.productId, orElse: () => state.allProducts.first);
      if (product.stock != null && event.newQuantity > product.stock!) {
        emit(state.copyWith(error: 'Sản phẩm ${product.name} chỉ còn ${product.stock} sản phẩm trong kho.'));
        emit(state.copyWith(error: null));
        return;
      }
      
      List<OrderItemEntity> updatedItems = List.from(order.items);
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
    
    int newDiscountAmount = order.discount;
    
    // Auto recalculate discount amount if it's based on percentage
    if (order.discountPercent != null) {
      newDiscountAmount = (totalAmount * (order.discountPercent! / 100)).round();
    }
    
    int finalAmount = totalAmount - newDiscountAmount;
    if (finalAmount < 0) finalAmount = 0;

    final updatedOrder = order.copyWith(
      items: updatedItems,
      totalAmount: totalAmount,
      discount: newDiscountAmount,
      finalAmount: finalAmount,
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
 
    // Check if the order has a temporary timestamp ID (new draft) or real DB ID
    final isNewOrder = orderToSave.id > 1000000000;
    
    final result = isNewOrder 
        ? await orderRepository.createOrder(updatedOrder)
        : await updateOrderUseCase(updatedOrder);
 
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (savedOrder) {
        if (status == 1) {
          // Status 1: Completed -> Remove the saved order from drafts
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

          // Reload products list to reflect updated stock in state
          productRepository.watchProducts(storeId: orderToSave.storeId).first.then((productsResult) {
            productsResult.fold(
              (failure) {}, // ignore
              (products) {
                final activeProducts = products.where((p) => p.status == 1).toList();
                
                // Re-apply filter based on current search and category filters
                var filtered = activeProducts.where((p) {
                  final matchesSearch = state.searchQuery.isEmpty || p.name.toLowerCase().contains(state.searchQuery.toLowerCase());
                  final matchesCategory = state.selectedCategoryId == null || state.selectedCategoryId == 0 || p.categoryId == state.selectedCategoryId;
                  final matchesMinPrice = state.minPrice == null || p.price >= state.minPrice!;
                  final matchesMaxPrice = state.maxPrice == null || p.price <= state.maxPrice!;
                  final matchesStatus = state.productStatus == null || p.status == state.productStatus!;
                  return matchesSearch && matchesCategory && matchesMinPrice && matchesMaxPrice && matchesStatus;
                }).toList();

                if (state.sortOption != null) {
                  filtered.sort((a, b) {
                    if (state.sortOption == 0) {
                      return a.price.compareTo(b.price);
                    } else {
                      return b.price.compareTo(a.price);
                    }
                  });
                }

                emit(state.copyWith(
                  allProducts: activeProducts,
                  filteredProducts: filtered,
                ));
              },
            );
          });
        } else {
          // Status 0: Pending -> Keep the order active in the drafts, update its ID/status
          final updatedDrafts = List<OrderEntity>.from(state.draftOrders);
          updatedDrafts[orderIndex] = savedOrder;
 
          emit(state.copyWith(
            isLoading: false,
            isActionSuccess: true,
            draftOrders: updatedDrafts,
          ));
 
          // Reset success flag
          emit(state.copyWith(isActionSuccess: false));
        }
      },
    );
  }
}
