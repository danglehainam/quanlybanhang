import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/create_category_usecase.dart';
import '../../../domain/usecases/update_category_usecase.dart';
import '../../../domain/usecases/delete_category_usecase.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  CategoriesBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required CreateCategoryUseCase createCategoryUseCase,
    required UpdateCategoryUseCase updateCategoryUseCase,
    required DeleteCategoryUseCase deleteCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _createCategoryUseCase = createCategoryUseCase,
        _updateCategoryUseCase = updateCategoryUseCase,
        _deleteCategoryUseCase = deleteCategoryUseCase,
        super(const CategoriesState.initial()) {
    on<WatchCategories>(_onWatchCategories);
    on<CreateCategory>(_onCreateCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onWatchCategories(
    WatchCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesState.loading());
    
    await emit.forEach(
      _getCategoriesUseCase(event.storeId),
      onData: (result) => result.fold(
        (failure) => CategoriesState.error(failure.message),
        (categories) => CategoriesState.loaded(categories),
      ),
      onError: (error, stackTrace) => CategoriesState.error(error.toString()),
    );
  }

  Future<void> _onCreateCategory(
    CreateCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    final result = await _createCategoryUseCase(event.category);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    final result = await _updateCategoryUseCase(event.category);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    final result = await _deleteCategoryUseCase(event.id);
    
    result.fold(
      (failure) => event.onError(failure.message),
      (_) => event.onSuccess(),
    );
  }
}
