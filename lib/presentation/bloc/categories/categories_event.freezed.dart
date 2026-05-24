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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WatchCategories value)?  watchCategories,TResult Function( CreateCategory value)?  createCategory,TResult Function( UpdateCategory value)?  updateCategory,TResult Function( DeleteCategory value)?  deleteCategory,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that);case CreateCategory() when createCategory != null:
return createCategory(_that);case UpdateCategory() when updateCategory != null:
return updateCategory(_that);case DeleteCategory() when deleteCategory != null:
return deleteCategory(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WatchCategories value)  watchCategories,required TResult Function( CreateCategory value)  createCategory,required TResult Function( UpdateCategory value)  updateCategory,required TResult Function( DeleteCategory value)  deleteCategory,}){
final _that = this;
switch (_that) {
case WatchCategories():
return watchCategories(_that);case CreateCategory():
return createCategory(_that);case UpdateCategory():
return updateCategory(_that);case DeleteCategory():
return deleteCategory(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WatchCategories value)?  watchCategories,TResult? Function( CreateCategory value)?  createCategory,TResult? Function( UpdateCategory value)?  updateCategory,TResult? Function( DeleteCategory value)?  deleteCategory,}){
final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that);case CreateCategory() when createCategory != null:
return createCategory(_that);case UpdateCategory() when updateCategory != null:
return updateCategory(_that);case DeleteCategory() when deleteCategory != null:
return deleteCategory(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int storeId)?  watchCategories,TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  createCategory,TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  updateCategory,TResult Function( int id,  void Function() onSuccess,  void Function(String) onError)?  deleteCategory,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that.storeId);case CreateCategory() when createCategory != null:
return createCategory(_that.category,_that.onSuccess,_that.onError);case UpdateCategory() when updateCategory != null:
return updateCategory(_that.category,_that.onSuccess,_that.onError);case DeleteCategory() when deleteCategory != null:
return deleteCategory(_that.id,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int storeId)  watchCategories,required TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)  createCategory,required TResult Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)  updateCategory,required TResult Function( int id,  void Function() onSuccess,  void Function(String) onError)  deleteCategory,}) {final _that = this;
switch (_that) {
case WatchCategories():
return watchCategories(_that.storeId);case CreateCategory():
return createCategory(_that.category,_that.onSuccess,_that.onError);case UpdateCategory():
return updateCategory(_that.category,_that.onSuccess,_that.onError);case DeleteCategory():
return deleteCategory(_that.id,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int storeId)?  watchCategories,TResult? Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  createCategory,TResult? Function( CategoryEntity category,  void Function() onSuccess,  void Function(String) onError)?  updateCategory,TResult? Function( int id,  void Function() onSuccess,  void Function(String) onError)?  deleteCategory,}) {final _that = this;
switch (_that) {
case WatchCategories() when watchCategories != null:
return watchCategories(_that.storeId);case CreateCategory() when createCategory != null:
return createCategory(_that.category,_that.onSuccess,_that.onError);case UpdateCategory() when updateCategory != null:
return updateCategory(_that.category,_that.onSuccess,_that.onError);case DeleteCategory() when deleteCategory != null:
return deleteCategory(_that.id,_that.onSuccess,_that.onError);case _:
  return null;

}
}

}

/// @nodoc


class WatchCategories implements CategoriesEvent {
  const WatchCategories({required this.storeId});
  

 final  int storeId;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchCategoriesCopyWith<WatchCategories> get copyWith => _$WatchCategoriesCopyWithImpl<WatchCategories>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchCategories&&(identical(other.storeId, storeId) || other.storeId == storeId));
}


@override
int get hashCode => Object.hash(runtimeType,storeId);

@override
String toString() {
  return 'CategoriesEvent.watchCategories(storeId: $storeId)';
}


}

/// @nodoc
abstract mixin class $WatchCategoriesCopyWith<$Res> implements $CategoriesEventCopyWith<$Res> {
  factory $WatchCategoriesCopyWith(WatchCategories value, $Res Function(WatchCategories) _then) = _$WatchCategoriesCopyWithImpl;
@useResult
$Res call({
 int storeId
});




}
/// @nodoc
class _$WatchCategoriesCopyWithImpl<$Res>
    implements $WatchCategoriesCopyWith<$Res> {
  _$WatchCategoriesCopyWithImpl(this._self, this._then);

  final WatchCategories _self;
  final $Res Function(WatchCategories) _then;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storeId = null,}) {
  return _then(WatchCategories(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

/// @nodoc


class UpdateCategory implements CategoriesEvent {
  const UpdateCategory(this.category, {required this.onSuccess, required this.onError});
  

 final  CategoryEntity category;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCategoryCopyWith<UpdateCategory> get copyWith => _$UpdateCategoryCopyWithImpl<UpdateCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCategory&&(identical(other.category, category) || other.category == category)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,category,onSuccess,onError);

@override
String toString() {
  return 'CategoriesEvent.updateCategory(category: $category, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $UpdateCategoryCopyWith<$Res> implements $CategoriesEventCopyWith<$Res> {
  factory $UpdateCategoryCopyWith(UpdateCategory value, $Res Function(UpdateCategory) _then) = _$UpdateCategoryCopyWithImpl;
@useResult
$Res call({
 CategoryEntity category, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$UpdateCategoryCopyWithImpl<$Res>
    implements $UpdateCategoryCopyWith<$Res> {
  _$UpdateCategoryCopyWithImpl(this._self, this._then);

  final UpdateCategory _self;
  final $Res Function(UpdateCategory) _then;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(UpdateCategory(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

/// @nodoc


class DeleteCategory implements CategoriesEvent {
  const DeleteCategory(this.id, {required this.onSuccess, required this.onError});
  

 final  int id;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteCategoryCopyWith<DeleteCategory> get copyWith => _$DeleteCategoryCopyWithImpl<DeleteCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,id,onSuccess,onError);

@override
String toString() {
  return 'CategoriesEvent.deleteCategory(id: $id, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $DeleteCategoryCopyWith<$Res> implements $CategoriesEventCopyWith<$Res> {
  factory $DeleteCategoryCopyWith(DeleteCategory value, $Res Function(DeleteCategory) _then) = _$DeleteCategoryCopyWithImpl;
@useResult
$Res call({
 int id, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$DeleteCategoryCopyWithImpl<$Res>
    implements $DeleteCategoryCopyWith<$Res> {
  _$DeleteCategoryCopyWithImpl(this._self, this._then);

  final DeleteCategory _self;
  final $Res Function(DeleteCategory) _then;

/// Create a copy of CategoriesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(DeleteCategory(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

// dart format on
