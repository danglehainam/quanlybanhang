import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/category_entity.dart';

part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = _Loading;
  const factory CategoriesState.loaded(List<CategoryEntity> categories) = _Loaded;
  const factory CategoriesState.error(String message) = _Error;
}
