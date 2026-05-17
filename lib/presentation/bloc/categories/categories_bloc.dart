import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoriesBloc({required GetCategoriesUseCase getCategoriesUseCase})
      : _getCategoriesUseCase = getCategoriesUseCase,
        super(const CategoriesState.initial()) {
    on<WatchCategories>(_onWatchCategories);
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
}
