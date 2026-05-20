// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sell_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellState {

 bool get isLoading; List<ProductEntity> get allProducts; List<ProductEntity> get filteredProducts; List<CategoryEntity> get categories;// POS Draft Orders
 List<OrderEntity> get draftOrders; int get selectedOrderIndex; String get searchQuery; int? get selectedCategoryId;// KiotViet advanced filters
 int? get minPrice; int? get maxPrice; int? get productStatus;// 1: Active, 0: Inactive
 int? get sortOption;// 0: Price Ascending, 1: Price Descending
 String? get error; bool get isActionSuccess;
/// Create a copy of SellState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellStateCopyWith<SellState> get copyWith => _$SellStateCopyWithImpl<SellState>(this as SellState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.allProducts, allProducts)&&const DeepCollectionEquality().equals(other.filteredProducts, filteredProducts)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.draftOrders, draftOrders)&&(identical(other.selectedOrderIndex, selectedOrderIndex) || other.selectedOrderIndex == selectedOrderIndex)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.productStatus, productStatus) || other.productStatus == productStatus)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption)&&(identical(other.error, error) || other.error == error)&&(identical(other.isActionSuccess, isActionSuccess) || other.isActionSuccess == isActionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(allProducts),const DeepCollectionEquality().hash(filteredProducts),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(draftOrders),selectedOrderIndex,searchQuery,selectedCategoryId,minPrice,maxPrice,productStatus,sortOption,error,isActionSuccess);

@override
String toString() {
  return 'SellState(isLoading: $isLoading, allProducts: $allProducts, filteredProducts: $filteredProducts, categories: $categories, draftOrders: $draftOrders, selectedOrderIndex: $selectedOrderIndex, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, minPrice: $minPrice, maxPrice: $maxPrice, productStatus: $productStatus, sortOption: $sortOption, error: $error, isActionSuccess: $isActionSuccess)';
}


}

/// @nodoc
abstract mixin class $SellStateCopyWith<$Res>  {
  factory $SellStateCopyWith(SellState value, $Res Function(SellState) _then) = _$SellStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ProductEntity> allProducts, List<ProductEntity> filteredProducts, List<CategoryEntity> categories, List<OrderEntity> draftOrders, int selectedOrderIndex, String searchQuery, int? selectedCategoryId, int? minPrice, int? maxPrice, int? productStatus, int? sortOption, String? error, bool isActionSuccess
});




}
/// @nodoc
class _$SellStateCopyWithImpl<$Res>
    implements $SellStateCopyWith<$Res> {
  _$SellStateCopyWithImpl(this._self, this._then);

  final SellState _self;
  final $Res Function(SellState) _then;

/// Create a copy of SellState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? allProducts = null,Object? filteredProducts = null,Object? categories = null,Object? draftOrders = null,Object? selectedOrderIndex = null,Object? searchQuery = null,Object? selectedCategoryId = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? productStatus = freezed,Object? sortOption = freezed,Object? error = freezed,Object? isActionSuccess = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,allProducts: null == allProducts ? _self.allProducts : allProducts // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,filteredProducts: null == filteredProducts ? _self.filteredProducts : filteredProducts // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,draftOrders: null == draftOrders ? _self.draftOrders : draftOrders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,selectedOrderIndex: null == selectedOrderIndex ? _self.selectedOrderIndex : selectedOrderIndex // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as int?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as int?,productStatus: freezed == productStatus ? _self.productStatus : productStatus // ignore: cast_nullable_to_non_nullable
as int?,sortOption: freezed == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isActionSuccess: null == isActionSuccess ? _self.isActionSuccess : isActionSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SellState].
extension SellStatePatterns on SellState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellState value)  $default,){
final _that = this;
switch (_that) {
case _SellState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellState value)?  $default,){
final _that = this;
switch (_that) {
case _SellState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductEntity> allProducts,  List<ProductEntity> filteredProducts,  List<CategoryEntity> categories,  List<OrderEntity> draftOrders,  int selectedOrderIndex,  String searchQuery,  int? selectedCategoryId,  int? minPrice,  int? maxPrice,  int? productStatus,  int? sortOption,  String? error,  bool isActionSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellState() when $default != null:
return $default(_that.isLoading,_that.allProducts,_that.filteredProducts,_that.categories,_that.draftOrders,_that.selectedOrderIndex,_that.searchQuery,_that.selectedCategoryId,_that.minPrice,_that.maxPrice,_that.productStatus,_that.sortOption,_that.error,_that.isActionSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductEntity> allProducts,  List<ProductEntity> filteredProducts,  List<CategoryEntity> categories,  List<OrderEntity> draftOrders,  int selectedOrderIndex,  String searchQuery,  int? selectedCategoryId,  int? minPrice,  int? maxPrice,  int? productStatus,  int? sortOption,  String? error,  bool isActionSuccess)  $default,) {final _that = this;
switch (_that) {
case _SellState():
return $default(_that.isLoading,_that.allProducts,_that.filteredProducts,_that.categories,_that.draftOrders,_that.selectedOrderIndex,_that.searchQuery,_that.selectedCategoryId,_that.minPrice,_that.maxPrice,_that.productStatus,_that.sortOption,_that.error,_that.isActionSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ProductEntity> allProducts,  List<ProductEntity> filteredProducts,  List<CategoryEntity> categories,  List<OrderEntity> draftOrders,  int selectedOrderIndex,  String searchQuery,  int? selectedCategoryId,  int? minPrice,  int? maxPrice,  int? productStatus,  int? sortOption,  String? error,  bool isActionSuccess)?  $default,) {final _that = this;
switch (_that) {
case _SellState() when $default != null:
return $default(_that.isLoading,_that.allProducts,_that.filteredProducts,_that.categories,_that.draftOrders,_that.selectedOrderIndex,_that.searchQuery,_that.selectedCategoryId,_that.minPrice,_that.maxPrice,_that.productStatus,_that.sortOption,_that.error,_that.isActionSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _SellState implements SellState {
  const _SellState({this.isLoading = false, final  List<ProductEntity> allProducts = const [], final  List<ProductEntity> filteredProducts = const [], final  List<CategoryEntity> categories = const [], final  List<OrderEntity> draftOrders = const [], this.selectedOrderIndex = 0, this.searchQuery = '', this.selectedCategoryId, this.minPrice, this.maxPrice, this.productStatus, this.sortOption, this.error, this.isActionSuccess = false}): _allProducts = allProducts,_filteredProducts = filteredProducts,_categories = categories,_draftOrders = draftOrders;
  

@override@JsonKey() final  bool isLoading;
 final  List<ProductEntity> _allProducts;
@override@JsonKey() List<ProductEntity> get allProducts {
  if (_allProducts is EqualUnmodifiableListView) return _allProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allProducts);
}

 final  List<ProductEntity> _filteredProducts;
@override@JsonKey() List<ProductEntity> get filteredProducts {
  if (_filteredProducts is EqualUnmodifiableListView) return _filteredProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredProducts);
}

 final  List<CategoryEntity> _categories;
@override@JsonKey() List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

// POS Draft Orders
 final  List<OrderEntity> _draftOrders;
// POS Draft Orders
@override@JsonKey() List<OrderEntity> get draftOrders {
  if (_draftOrders is EqualUnmodifiableListView) return _draftOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_draftOrders);
}

@override@JsonKey() final  int selectedOrderIndex;
@override@JsonKey() final  String searchQuery;
@override final  int? selectedCategoryId;
// KiotViet advanced filters
@override final  int? minPrice;
@override final  int? maxPrice;
@override final  int? productStatus;
// 1: Active, 0: Inactive
@override final  int? sortOption;
// 0: Price Ascending, 1: Price Descending
@override final  String? error;
@override@JsonKey() final  bool isActionSuccess;

/// Create a copy of SellState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellStateCopyWith<_SellState> get copyWith => __$SellStateCopyWithImpl<_SellState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._allProducts, _allProducts)&&const DeepCollectionEquality().equals(other._filteredProducts, _filteredProducts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._draftOrders, _draftOrders)&&(identical(other.selectedOrderIndex, selectedOrderIndex) || other.selectedOrderIndex == selectedOrderIndex)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.productStatus, productStatus) || other.productStatus == productStatus)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption)&&(identical(other.error, error) || other.error == error)&&(identical(other.isActionSuccess, isActionSuccess) || other.isActionSuccess == isActionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_allProducts),const DeepCollectionEquality().hash(_filteredProducts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_draftOrders),selectedOrderIndex,searchQuery,selectedCategoryId,minPrice,maxPrice,productStatus,sortOption,error,isActionSuccess);

@override
String toString() {
  return 'SellState(isLoading: $isLoading, allProducts: $allProducts, filteredProducts: $filteredProducts, categories: $categories, draftOrders: $draftOrders, selectedOrderIndex: $selectedOrderIndex, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, minPrice: $minPrice, maxPrice: $maxPrice, productStatus: $productStatus, sortOption: $sortOption, error: $error, isActionSuccess: $isActionSuccess)';
}


}

/// @nodoc
abstract mixin class _$SellStateCopyWith<$Res> implements $SellStateCopyWith<$Res> {
  factory _$SellStateCopyWith(_SellState value, $Res Function(_SellState) _then) = __$SellStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ProductEntity> allProducts, List<ProductEntity> filteredProducts, List<CategoryEntity> categories, List<OrderEntity> draftOrders, int selectedOrderIndex, String searchQuery, int? selectedCategoryId, int? minPrice, int? maxPrice, int? productStatus, int? sortOption, String? error, bool isActionSuccess
});




}
/// @nodoc
class __$SellStateCopyWithImpl<$Res>
    implements _$SellStateCopyWith<$Res> {
  __$SellStateCopyWithImpl(this._self, this._then);

  final _SellState _self;
  final $Res Function(_SellState) _then;

/// Create a copy of SellState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? allProducts = null,Object? filteredProducts = null,Object? categories = null,Object? draftOrders = null,Object? selectedOrderIndex = null,Object? searchQuery = null,Object? selectedCategoryId = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? productStatus = freezed,Object? sortOption = freezed,Object? error = freezed,Object? isActionSuccess = null,}) {
  return _then(_SellState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,allProducts: null == allProducts ? _self._allProducts : allProducts // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,filteredProducts: null == filteredProducts ? _self._filteredProducts : filteredProducts // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,draftOrders: null == draftOrders ? _self._draftOrders : draftOrders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,selectedOrderIndex: null == selectedOrderIndex ? _self.selectedOrderIndex : selectedOrderIndex // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as int?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as int?,productStatus: freezed == productStatus ? _self.productStatus : productStatus // ignore: cast_nullable_to_non_nullable
as int?,sortOption: freezed == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isActionSuccess: null == isActionSuccess ? _self.isActionSuccess : isActionSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
