import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_event.freezed.dart';

@freezed
abstract class CategoriesEvent with _$CategoriesEvent {
  const factory CategoriesEvent.watchCategories() = WatchCategories;
}
