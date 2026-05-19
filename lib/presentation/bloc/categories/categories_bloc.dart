import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/create_category_usecase.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;

  CategoriesBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required CreateCategoryUseCase createCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _createCategoryUseCase = createCategoryUseCase,
        super(const CategoriesState.initial()) {
    on<WatchCategories>(_onWatchCategories);
    on<CreateCategory>(_onCreateCategory);
  }

  Future<void> _onWatchCategories(
    WatchCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesState.loading());
    
    await emit.forEach(
      _getCategoriesUseCase(),
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
}
