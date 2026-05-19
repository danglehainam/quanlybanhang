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
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onWatchProducts(
    WatchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading());
    
    await emit.forEach(
      _getProductsUseCase(),
      onData: (result) => result.fold(
        (failure) => ProductsState.error(failure.message),
        (products) => ProductsState.loaded(products),
      ),
      onError: (error, stackTrace) => ProductsState.error(error.toString()),
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
