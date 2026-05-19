// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoriesEvent()';
}


}

/// @nodoc
class $CategoriesEventCopyWith<$Res>  {
$CategoriesEventCopyWith(CategoriesEvent _, $Res Function(CategoriesEvent) __);
}


/// Adds pattern-matching-related methods to [CategoriesEvent].
extension CategoriesEventPatterns on CategoriesEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WatchCategories value)?  watchCategories,TResult Function( CreateCategory value)?  createCategory,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that);case CreateCategory() when createCategory != null:
return createCategory(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WatchCategories value)  watchCategories,required TResult Function( CreateCategory value)  createCategory,}){
final _that = this;
switch (_that) {
case WatchCategories():
return watchCategories(_that);case CreateCategory():
return createCategory(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WatchCategories value)?  watchCategories,TResult? Function( CreateCategory value)?  createCategory,}){
final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that);case CreateCategory() when createCategory != null:
return createCategory(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  watchCategories,TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  createCategory,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories();case CreateCategory() when createCategory != null:
return createCategory(_that.category,_that.onSuccess,_that.onError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  watchCategories,required TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)  createCategory,}) {final _that = this;
switch (_that) {
case WatchCategories():
return watchCategories();case CreateCategory():
return createCategory(_that.category,_that.onSuccess,_that.onError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  watchCategories,TResult? Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  createCategory,}) {final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories();case CreateCategory() when createCategory != null:
return createCategory(_that.category,_that.onSuccess,_that.onError);case _:
  return null;

}
}

}

/// @nodoc


class WatchCategories implements CategoriesEvent {
  const WatchCategories();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchCategories);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoriesEvent.watchCategories()';
}


}




/// @nodoc


class CreateCategory implements CategoriesEvent {
  const CreateCategory(this.category, {required this.onSuccess, required this.onError});
  

 final  CategoryEntity category;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCategoryCopyWith<CreateCategory> get copyWith => _$CreateCategoryCopyWithImpl<CreateCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,category,onSuccess,onError);

@override
String toString() {
  return 'CategoriesEvent.createCategory(category: $category, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $CreateCategoryCopyWith<$Res> implements $CategoriesEventCopyWith<$Res> {
  factory $CreateCategoryCopyWith(CreateCategory value, $Res Function(CreateCategory) _then) = _$CreateCategoryCopyWithImpl;
@useResult
$Res call({
 CategoryEntity category, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$CreateCategoryCopyWithImpl<$Res>
    implements $CreateCategoryCopyWith<$Res> {
  _$CreateCategoryCopyWithImpl(this._self, this._then);

  final CreateCategory _self;
  final $Res Function(CreateCategory) _then;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(CreateCategory(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

// dart format on
