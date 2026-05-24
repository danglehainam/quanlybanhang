// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrdersEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersEvent()';
}


}

/// @nodoc
class $OrdersEventCopyWith<$Res>  {
$OrdersEventCopyWith(OrdersEvent _, $Res Function(OrdersEvent) __);
}


/// Adds pattern-matching-related methods to [OrdersEvent].
extension OrdersEventPatterns on OrdersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadOrdersEvent value)?  loadOrders,TResult Function( FilterOrdersEvent value)?  filterOrders,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadOrdersEvent value)  loadOrders,required TResult Function( FilterOrdersEvent value)  filterOrders,}){
final _that = this;
switch (_that) {
case LoadOrdersEvent():
return loadOrders(_that);case FilterOrdersEvent():
return filterOrders(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadOrdersEvent value)?  loadOrders,TResult? Function( FilterOrdersEvent value)?  filterOrders,}){
final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int storeId)?  loadOrders,TResult Function( String? query,  int? statusFilter,  int? sortOption)?  filterOrders,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that.storeId);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that.query,_that.statusFilter,_that.sortOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int storeId)  loadOrders,required TResult Function( String? query,  int? statusFilter,  int? sortOption)  filterOrders,}) {final _that = this;
switch (_that) {
case LoadOrdersEvent():
return loadOrders(_that.storeId);case FilterOrdersEvent():
return filterOrders(_that.query,_that.statusFilter,_that.sortOption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int storeId)?  loadOrders,TResult? Function( String? query,  int? statusFilter,  int? sortOption)?  filterOrders,}) {final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that.storeId);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that.query,_that.statusFilter,_that.sortOption);case _:
  return null;

}
}

}

/// @nodoc


class LoadOrdersEvent implements OrdersEvent {
  const LoadOrdersEvent({required this.storeId});
  

 final  int storeId;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadOrdersEventCopyWith<LoadOrdersEvent> get copyWith => _$LoadOrdersEventCopyWithImpl<LoadOrdersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadOrdersEvent&&(identical(other.storeId, storeId) || other.storeId == storeId));
}


@override
int get hashCode => Object.hash(runtimeType,storeId);

@override
String toString() {
  return 'OrdersEvent.loadOrders(storeId: $storeId)';
}


}

/// @nodoc
abstract mixin class $LoadOrdersEventCopyWith<$Res> implements $OrdersEventCopyWith<$Res> {
  factory $LoadOrdersEventCopyWith(LoadOrdersEvent value, $Res Function(LoadOrdersEvent) _then) = _$LoadOrdersEventCopyWithImpl;
@useResult
$Res call({
 int storeId
});




}
/// @nodoc
class _$LoadOrdersEventCopyWithImpl<$Res>
    implements $LoadOrdersEventCopyWith<$Res> {
  _$LoadOrdersEventCopyWithImpl(this._self, this._then);

  final LoadOrdersEvent _self;
  final $Res Function(LoadOrdersEvent) _then;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storeId = null,}) {
  return _then(LoadOrdersEvent(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FilterOrdersEvent implements OrdersEvent {
  const FilterOrdersEvent({this.query, this.statusFilter, this.sortOption});
  

 final  String? query;
 final  int? statusFilter;
// null for all, 0 for pending, 1 for completed
 final  int? sortOption;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterOrdersEventCopyWith<FilterOrdersEvent> get copyWith => _$FilterOrdersEventCopyWithImpl<FilterOrdersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOrdersEvent&&(identical(other.query, query) || other.query == query)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption));
}


@override
int get hashCode => Object.hash(runtimeType,query,statusFilter,sortOption);

@override
String toString() {
  return 'OrdersEvent.filterOrders(query: $query, statusFilter: $statusFilter, sortOption: $sortOption)';
}


}

/// @nodoc
abstract mixin class $FilterOrdersEventCopyWith<$Res> implements $OrdersEventCopyWith<$Res> {
  factory $FilterOrdersEventCopyWith(FilterOrdersEvent value, $Res Function(FilterOrdersEvent) _then) = _$FilterOrdersEventCopyWithImpl;
@useResult
$Res call({
 String? query, int? statusFilter, int? sortOption
});




}
/// @nodoc
class _$FilterOrdersEventCopyWithImpl<$Res>
    implements $FilterOrdersEventCopyWith<$Res> {
  _$FilterOrdersEventCopyWithImpl(this._self, this._then);

  final FilterOrdersEvent _self;
  final $Res Function(FilterOrdersEvent) _then;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = freezed,Object? statusFilter = freezed,Object? sortOption = freezed,}) {
  return _then(FilterOrdersEvent(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as int?,sortOption: freezed == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
