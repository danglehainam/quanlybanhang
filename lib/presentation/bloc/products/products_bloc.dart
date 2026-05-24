import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_products_usecase.dart';
import '../../../domain/usecases/create_product_usecase.dart';
import '../../../domain/usecases/update_product_usecase.dart';
import '../../../domain/usecases/delete_product_usecase.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final CreateProductUseCase _createProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  StreamSubscription? _productSubscription;

  ProductsBloc({
    required GetProductsUseCase getProductsUseCase,
    required CreateProductUseCase createProductUseCase,
    required UpdateProductUseCase updateProductUseCase,
    required DeleteProductUseCase deleteProductUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        _createProductUseCase = createProductUseCase,
        _updateProductUseCase = updateProductUseCase,
        _deleteProductUseCase = deleteProductUseCase,
        super(const ProductsState.initial()) {
    on<WatchProducts>(_onWatchProducts);
    on<ProductsUpdated>(_onProductsUpdated);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }

  void _onWatchProducts(WatchProducts event, Emitter<ProductsState> emit) {
    emit(const ProductsState.loading());
    
    _productSubscription?.cancel();
    
    _productSubscription = _getProductsUseCase(
      storeId: event.storeId,
      query: event.query,
      categoryId: event.categoryId,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
      status: event.productStatus,
      sortOption: event.sortOption,
    ).listen(
      (result) {
        add(ProductsEvent.productsUpdated(
          result,
          searchQuery: event.query,
          selectedCategoryId: event.categoryId,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
          productStatus: event.productStatus,
          sortOption: event.sortOption,
        ));
      }
    );
  }

  void _onProductsUpdated(ProductsUpdated event, Emitter<ProductsState> emit) {
    event.result.fold(
      (failure) => emit(ProductsState.error(failure.message)),
      (products) {
        emit(ProductsState.loaded(
          allProducts: products, // With DB filtering, allProducts is the filtered list
          filteredProducts: products, // Same as allProducts
          searchQuery: event.searchQuery ?? '',
          selectedCategoryId: event.selectedCategoryId,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
          productStatus: event.productStatus,
          sortOption: event.sortOption,
        ));
      }
    );
  }

  Future<void> _onCreateProduct(
    CreateProduct event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _createProductUseCase(event.product);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _updateProductUseCase(event.product);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _deleteProductUseCase(event.id);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }
}
