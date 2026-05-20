// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sell_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellEvent()';
}


}

/// @nodoc
class $SellEventCopyWith<$Res>  {
$SellEventCopyWith(SellEvent _, $Res Function(SellEvent) __);
}


/// Adds pattern-matching-related methods to [SellEvent].
extension SellEventPatterns on SellEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadInitialDataEvent value)?  loadInitialData,TResult Function( FilterProductsEvent value)?  filterProducts,TResult Function( AddOrderEvent value)?  addOrder,TResult Function( SelectOrderEvent value)?  selectOrder,TResult Function( RemoveOrderEvent value)?  removeOrder,TResult Function( AddProductToOrderEvent value)?  addProductToOrder,TResult Function( UpdateItemQuantityEvent value)?  updateItemQuantity,TResult Function( RemoveItemEvent value)?  removeItem,TResult Function( ConfirmOrderEvent value)?  confirmOrder,TResult Function( CompleteOrderEvent value)?  completeOrder,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadInitialDataEvent() when loadInitialData != null:
return loadInitialData(_that);case FilterProductsEvent() when filterProducts != null:
return filterProducts(_that);case AddOrderEvent() when addOrder != null:
return addOrder(_that);case SelectOrderEvent() when selectOrder != null:
return selectOrder(_that);case RemoveOrderEvent() when removeOrder != null:
return removeOrder(_that);case AddProductToOrderEvent() when addProductToOrder != null:
return addProductToOrder(_that);case UpdateItemQuantityEvent() when updateItemQuantity != null:
return updateItemQuantity(_that);case RemoveItemEvent() when removeItem != null:
return removeItem(_that);case ConfirmOrderEvent() when confirmOrder != null:
return confirmOrder(_that);case CompleteOrderEvent() when completeOrder != null:
return completeOrder(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadInitialDataEvent value)  loadInitialData,required TResult Function( FilterProductsEvent value)  filterProducts,required TResult Function( AddOrderEvent value)  addOrder,required TResult Function( SelectOrderEvent value)  selectOrder,required TResult Function( RemoveOrderEvent value)  removeOrder,required TResult Function( AddProductToOrderEvent value)  addProductToOrder,required TResult Function( UpdateItemQuantityEvent value)  updateItemQuantity,required TResult Function( RemoveItemEvent value)  removeItem,required TResult Function( ConfirmOrderEvent value)  confirmOrder,required TResult Function( CompleteOrderEvent value)  completeOrder,}){
final _that = this;
switch (_that) {
case LoadInitialDataEvent():
return loadInitialData(_that);case FilterProductsEvent():
return filterProducts(_that);case AddOrderEvent():
return addOrder(_that);case SelectOrderEvent():
return selectOrder(_that);case RemoveOrderEvent():
return removeOrder(_that);case AddProductToOrderEvent():
return addProductToOrder(_that);case UpdateItemQuantityEvent():
return updateItemQuantity(_that);case RemoveItemEvent():
return removeItem(_that);case ConfirmOrderEvent():
return confirmOrder(_that);case CompleteOrderEvent():
return completeOrder(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadInitialDataEvent value)?  loadInitialData,TResult? Function( FilterProductsEvent value)?  filterProducts,TResult? Function( AddOrderEvent value)?  addOrder,TResult? Function( SelectOrderEvent value)?  selectOrder,TResult? Function( RemoveOrderEvent value)?  removeOrder,TResult? Function( AddProductToOrderEvent value)?  addProductToOrder,TResult? Function( UpdateItemQuantityEvent value)?  updateItemQuantity,TResult? Function( RemoveItemEvent value)?  removeItem,TResult? Function( ConfirmOrderEvent value)?  confirmOrder,TResult? Function( CompleteOrderEvent value)?  completeOrder,}){
final _that = this;
switch (_that) {
case LoadInitialDataEvent() when loadInitialData != null:
return loadInitialData(_that);case FilterProductsEvent() when filterProducts != null:
return filterProducts(_that);case AddOrderEvent() when addOrder != null:
return addOrder(_that);case SelectOrderEvent() when selectOrder != null:
return selectOrder(_that);case RemoveOrderEvent() when removeOrder != null:
return removeOrder(_that);case AddProductToOrderEvent() when addProductToOrder != null:
return addProductToOrder(_that);case UpdateItemQuantityEvent() when updateItemQuantity != null:
return updateItemQuantity(_that);case RemoveItemEvent() when removeItem != null:
return removeItem(_that);case ConfirmOrderEvent() when confirmOrder != null:
return confirmOrder(_that);case CompleteOrderEvent() when completeOrder != null:
return completeOrder(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadInitialData,TResult Function( String query,  int? categoryId)?  filterProducts,TResult Function()?  addOrder,TResult Function( int index)?  selectOrder,TResult Function( int index)?  removeOrder,TResult Function( ProductEntity product)?  addProductToOrder,TResult Function( int itemIndex,  int newQuantity)?  updateItemQuantity,TResult Function( int itemIndex)?  removeItem,TResult Function()?  confirmOrder,TResult Function()?  completeOrder,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadInitialDataEvent() when loadInitialData != null:
return loadInitialData();case FilterProductsEvent() when filterProducts != null:
return filterProducts(_that.query,_that.categoryId);case AddOrderEvent() when addOrder != null:
return addOrder();case SelectOrderEvent() when selectOrder != null:
return selectOrder(_that.index);case RemoveOrderEvent() when removeOrder != null:
return removeOrder(_that.index);case AddProductToOrderEvent() when addProductToOrder != null:
return addProductToOrder(_that.product);case UpdateItemQuantityEvent() when updateItemQuantity != null:
return updateItemQuantity(_that.itemIndex,_that.newQuantity);case RemoveItemEvent() when removeItem != null:
return removeItem(_that.itemIndex);case ConfirmOrderEvent() when confirmOrder != null:
return confirmOrder();case CompleteOrderEvent() when completeOrder != null:
return completeOrder();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadInitialData,required TResult Function( String query,  int? categoryId)  filterProducts,required TResult Function()  addOrder,required TResult Function( int index)  selectOrder,required TResult Function( int index)  removeOrder,required TResult Function( ProductEntity product)  addProductToOrder,required TResult Function( int itemIndex,  int newQuantity)  updateItemQuantity,required TResult Function( int itemIndex)  removeItem,required TResult Function()  confirmOrder,required TResult Function()  completeOrder,}) {final _that = this;
switch (_that) {
case LoadInitialDataEvent():
return loadInitialData();case FilterProductsEvent():
return filterProducts(_that.query,_that.categoryId);case AddOrderEvent():
return addOrder();case SelectOrderEvent():
return selectOrder(_that.index);case RemoveOrderEvent():
return removeOrder(_that.index);case AddProductToOrderEvent():
return addProductToOrder(_that.product);case UpdateItemQuantityEvent():
return updateItemQuantity(_that.itemIndex,_that.newQuantity);case RemoveItemEvent():
return removeItem(_that.itemIndex);case ConfirmOrderEvent():
return confirmOrder();case CompleteOrderEvent():
return completeOrder();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadInitialData,TResult? Function( String query,  int? categoryId)?  filterProducts,TResult? Function()?  addOrder,TResult? Function( int index)?  selectOrder,TResult? Function( int index)?  removeOrder,TResult? Function( ProductEntity product)?  addProductToOrder,TResult? Function( int itemIndex,  int newQuantity)?  updateItemQuantity,TResult? Function( int itemIndex)?  removeItem,TResult? Function()?  confirmOrder,TResult? Function()?  completeOrder,}) {final _that = this;
switch (_that) {
case LoadInitialDataEvent() when loadInitialData != null:
return loadInitialData();case FilterProductsEvent() when filterProducts != null:
return filterProducts(_that.query,_that.categoryId);case AddOrderEvent() when addOrder != null:
return addOrder();case SelectOrderEvent() when selectOrder != null:
return selectOrder(_that.index);case RemoveOrderEvent() when removeOrder != null:
return removeOrder(_that.index);case AddProductToOrderEvent() when addProductToOrder != null:
return addProductToOrder(_that.product);case UpdateItemQuantityEvent() when updateItemQuantity != null:
return updateItemQuantity(_that.itemIndex,_that.newQuantity);case RemoveItemEvent() when removeItem != null:
return removeItem(_that.itemIndex);case ConfirmOrderEvent() when confirmOrder != null:
return confirmOrder();case CompleteOrderEvent() when completeOrder != null:
return completeOrder();case _:
  return null;

}
}

}

/// @nodoc


class LoadInitialDataEvent implements SellEvent {
  const LoadInitialDataEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadInitialDataEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellEvent.loadInitialData()';
}


}




/// @nodoc


class FilterProductsEvent implements SellEvent {
  const FilterProductsEvent(this.query, this.categoryId);
  

 final  String query;
 final  int? categoryId;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterProductsEventCopyWith<FilterProductsEvent> get copyWith => _$FilterProductsEventCopyWithImpl<FilterProductsEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterProductsEvent&&(identical(other.query, query) || other.query == query)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode => Object.hash(runtimeType,query,categoryId);

@override
String toString() {
  return 'SellEvent.filterProducts(query: $query, categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $FilterProductsEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $FilterProductsEventCopyWith(FilterProductsEvent value, $Res Function(FilterProductsEvent) _then) = _$FilterProductsEventCopyWithImpl;
@useResult
$Res call({
 String query, int? categoryId
});




}
/// @nodoc
class _$FilterProductsEventCopyWithImpl<$Res>
    implements $FilterProductsEventCopyWith<$Res> {
  _$FilterProductsEventCopyWithImpl(this._self, this._then);

  final FilterProductsEvent _self;
  final $Res Function(FilterProductsEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? categoryId = freezed,}) {
  return _then(FilterProductsEvent(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class AddOrderEvent implements SellEvent {
  const AddOrderEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellEvent.addOrder()';
}


}




/// @nodoc


class SelectOrderEvent implements SellEvent {
  const SelectOrderEvent(this.index);
  

 final  int index;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectOrderEventCopyWith<SelectOrderEvent> get copyWith => _$SelectOrderEventCopyWithImpl<SelectOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectOrderEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'SellEvent.selectOrder(index: $index)';
}


}

/// @nodoc
abstract mixin class $SelectOrderEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $SelectOrderEventCopyWith(SelectOrderEvent value, $Res Function(SelectOrderEvent) _then) = _$SelectOrderEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$SelectOrderEventCopyWithImpl<$Res>
    implements $SelectOrderEventCopyWith<$Res> {
  _$SelectOrderEventCopyWithImpl(this._self, this._then);

  final SelectOrderEvent _self;
  final $Res Function(SelectOrderEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(SelectOrderEvent(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RemoveOrderEvent implements SellEvent {
  const RemoveOrderEvent(this.index);
  

 final  int index;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveOrderEventCopyWith<RemoveOrderEvent> get copyWith => _$RemoveOrderEventCopyWithImpl<RemoveOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveOrderEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'SellEvent.removeOrder(index: $index)';
}


}

/// @nodoc
abstract mixin class $RemoveOrderEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $RemoveOrderEventCopyWith(RemoveOrderEvent value, $Res Function(RemoveOrderEvent) _then) = _$RemoveOrderEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$RemoveOrderEventCopyWithImpl<$Res>
    implements $RemoveOrderEventCopyWith<$Res> {
  _$RemoveOrderEventCopyWithImpl(this._self, this._then);

  final RemoveOrderEvent _self;
  final $Res Function(RemoveOrderEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(RemoveOrderEvent(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AddProductToOrderEvent implements SellEvent {
  const AddProductToOrderEvent(this.product);
  

 final  ProductEntity product;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddProductToOrderEventCopyWith<AddProductToOrderEvent> get copyWith => _$AddProductToOrderEventCopyWithImpl<AddProductToOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddProductToOrderEvent&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'SellEvent.addProductToOrder(product: $product)';
}


}

/// @nodoc
abstract mixin class $AddProductToOrderEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $AddProductToOrderEventCopyWith(AddProductToOrderEvent value, $Res Function(AddProductToOrderEvent) _then) = _$AddProductToOrderEventCopyWithImpl;
@useResult
$Res call({
 ProductEntity product
});




}
/// @nodoc
class _$AddProductToOrderEventCopyWithImpl<$Res>
    implements $AddProductToOrderEventCopyWith<$Res> {
  _$AddProductToOrderEventCopyWithImpl(this._self, this._then);

  final AddProductToOrderEvent _self;
  final $Res Function(AddProductToOrderEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(AddProductToOrderEvent(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity,
  ));
}


}

/// @nodoc


class UpdateItemQuantityEvent implements SellEvent {
  const UpdateItemQuantityEvent(this.itemIndex, this.newQuantity);
  

 final  int itemIndex;
 final  int newQuantity;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateItemQuantityEventCopyWith<UpdateItemQuantityEvent> get copyWith => _$UpdateItemQuantityEventCopyWithImpl<UpdateItemQuantityEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateItemQuantityEvent&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex)&&(identical(other.newQuantity, newQuantity) || other.newQuantity == newQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex,newQuantity);

@override
String toString() {
  return 'SellEvent.updateItemQuantity(itemIndex: $itemIndex, newQuantity: $newQuantity)';
}


}

/// @nodoc
abstract mixin class $UpdateItemQuantityEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $UpdateItemQuantityEventCopyWith(UpdateItemQuantityEvent value, $Res Function(UpdateItemQuantityEvent) _then) = _$UpdateItemQuantityEventCopyWithImpl;
@useResult
$Res call({
 int itemIndex, int newQuantity
});




}
/// @nodoc
class _$UpdateItemQuantityEventCopyWithImpl<$Res>
    implements $UpdateItemQuantityEventCopyWith<$Res> {
  _$UpdateItemQuantityEventCopyWithImpl(this._self, this._then);

  final UpdateItemQuantityEvent _self;
  final $Res Function(UpdateItemQuantityEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,Object? newQuantity = null,}) {
  return _then(UpdateItemQuantityEvent(
null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,null == newQuantity ? _self.newQuantity : newQuantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RemoveItemEvent implements SellEvent {
  const RemoveItemEvent(this.itemIndex);
  

 final  int itemIndex;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveItemEventCopyWith<RemoveItemEvent> get copyWith => _$RemoveItemEventCopyWithImpl<RemoveItemEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveItemEvent&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex);

@override
String toString() {
  return 'SellEvent.removeItem(itemIndex: $itemIndex)';
}


}

/// @nodoc
abstract mixin class $RemoveItemEventCopyWith<$Res> implements $SellEventCopyWith<$Res> {
  factory $RemoveItemEventCopyWith(RemoveItemEvent value, $Res Function(RemoveItemEvent) _then) = _$RemoveItemEventCopyWithImpl;
@useResult
$Res call({
 int itemIndex
});




}
/// @nodoc
class _$RemoveItemEventCopyWithImpl<$Res>
    implements $RemoveItemEventCopyWith<$Res> {
  _$RemoveItemEventCopyWithImpl(this._self, this._then);

  final RemoveItemEvent _self;
  final $Res Function(RemoveItemEvent) _then;

/// Create a copy of SellEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,}) {
  return _then(RemoveItemEvent(
null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ConfirmOrderEvent implements SellEvent {
  const ConfirmOrderEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellEvent.confirmOrder()';
}


}




/// @nodoc


class CompleteOrderEvent implements SellEvent {
  const CompleteOrderEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellEvent.completeOrder()';
}


}




// dart format on
