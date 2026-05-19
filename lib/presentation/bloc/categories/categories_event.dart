import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/category_entity.dart';

part 'categories_event.freezed.dart';

@freezed
abstract class CategoriesEvent with _$CategoriesEvent {
  const factory CategoriesEvent.watchCategories() = WatchCategories;
  const factory CategoriesEvent.createCategory(
    CategoryEntity category, {
    required void Function() onSuccess,
    required void Function(String) onError,
  }) = CreateCategory;
}
