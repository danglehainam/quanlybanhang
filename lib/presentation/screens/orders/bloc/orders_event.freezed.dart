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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadOrdersEvent value)?  loadOrders,TResult Function( FilterOrdersEvent value)?  filterOrders,TResult Function( UpdateOrderStatusEvent value)?  updateOrderStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that);case UpdateOrderStatusEvent() when updateOrderStatus != null:
return updateOrderStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadOrdersEvent value)  loadOrders,required TResult Function( FilterOrdersEvent value)  filterOrders,required TResult Function( UpdateOrderStatusEvent value)  updateOrderStatus,}){
final _that = this;
switch (_that) {
case LoadOrdersEvent():
return loadOrders(_that);case FilterOrdersEvent():
return filterOrders(_that);case UpdateOrderStatusEvent():
return updateOrderStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadOrdersEvent value)?  loadOrders,TResult? Function( FilterOrdersEvent value)?  filterOrders,TResult? Function( UpdateOrderStatusEvent value)?  updateOrderStatus,}){
final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that);case UpdateOrderStatusEvent() when updateOrderStatus != null:
return updateOrderStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int storeId)?  loadOrders,TResult Function( String? query,  int? statusFilter,  int? sortOption,  int? timeFilterType,  DateTime? selectedDate,  int? selectedMonth,  int? selectedQuarter,  int? selectedYear)?  filterOrders,TResult Function( OrderEntity order,  int newStatus,  void Function() onSuccess,  void Function(String) onError)?  updateOrderStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that.storeId);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that.query,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case UpdateOrderStatusEvent() when updateOrderStatus != null:
return updateOrderStatus(_that.order,_that.newStatus,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int storeId)  loadOrders,required TResult Function( String? query,  int? statusFilter,  int? sortOption,  int? timeFilterType,  DateTime? selectedDate,  int? selectedMonth,  int? selectedQuarter,  int? selectedYear)  filterOrders,required TResult Function( OrderEntity order,  int newStatus,  void Function() onSuccess,  void Function(String) onError)  updateOrderStatus,}) {final _that = this;
switch (_that) {
case LoadOrdersEvent():
return loadOrders(_that.storeId);case FilterOrdersEvent():
return filterOrders(_that.query,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case UpdateOrderStatusEvent():
return updateOrderStatus(_that.order,_that.newStatus,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int storeId)?  loadOrders,TResult? Function( String? query,  int? statusFilter,  int? sortOption,  int? timeFilterType,  DateTime? selectedDate,  int? selectedMonth,  int? selectedQuarter,  int? selectedYear)?  filterOrders,TResult? Function( OrderEntity order,  int newStatus,  void Function() onSuccess,  void Function(String) onError)?  updateOrderStatus,}) {final _that = this;
switch (_that) {
case LoadOrdersEvent() when loadOrders != null:
return loadOrders(_that.storeId);case FilterOrdersEvent() when filterOrders != null:
return filterOrders(_that.query,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case UpdateOrderStatusEvent() when updateOrderStatus != null:
return updateOrderStatus(_that.order,_that.newStatus,_that.onSuccess,_that.onError);case _:
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
  const FilterOrdersEvent({this.query, this.statusFilter, this.sortOption, this.timeFilterType, this.selectedDate, this.selectedMonth, this.selectedQuarter, this.selectedYear});
  

 final  String? query;
 final  int? statusFilter;
// null for all, 0 for pending, 1 for completed
 final  int? sortOption;
// 0 for newest, 1 for oldest, 2 for highest price, 3 for lowest price
 final  int? timeFilterType;
 final  DateTime? selectedDate;
 final  int? selectedMonth;
 final  int? selectedQuarter;
 final  int? selectedYear;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterOrdersEventCopyWith<FilterOrdersEvent> get copyWith => _$FilterOrdersEventCopyWithImpl<FilterOrdersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterOrdersEvent&&(identical(other.query, query) || other.query == query)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption)&&(identical(other.timeFilterType, timeFilterType) || other.timeFilterType == timeFilterType)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedQuarter, selectedQuarter) || other.selectedQuarter == selectedQuarter)&&(identical(other.selectedYear, selectedYear) || other.selectedYear == selectedYear));
}


@override
int get hashCode => Object.hash(runtimeType,query,statusFilter,sortOption,timeFilterType,selectedDate,selectedMonth,selectedQuarter,selectedYear);

@override
String toString() {
  return 'OrdersEvent.filterOrders(query: $query, statusFilter: $statusFilter, sortOption: $sortOption, timeFilterType: $timeFilterType, selectedDate: $selectedDate, selectedMonth: $selectedMonth, selectedQuarter: $selectedQuarter, selectedYear: $selectedYear)';
}


}

/// @nodoc
abstract mixin class $FilterOrdersEventCopyWith<$Res> implements $OrdersEventCopyWith<$Res> {
  factory $FilterOrdersEventCopyWith(FilterOrdersEvent value, $Res Function(FilterOrdersEvent) _then) = _$FilterOrdersEventCopyWithImpl;
@useResult
$Res call({
 String? query, int? statusFilter, int? sortOption, int? timeFilterType, DateTime? selectedDate, int? selectedMonth, int? selectedQuarter, int? selectedYear
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
@pragma('vm:prefer-inline') $Res call({Object? query = freezed,Object? statusFilter = freezed,Object? sortOption = freezed,Object? timeFilterType = freezed,Object? selectedDate = freezed,Object? selectedMonth = freezed,Object? selectedQuarter = freezed,Object? selectedYear = freezed,}) {
  return _then(FilterOrdersEvent(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as int?,sortOption: freezed == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as int?,timeFilterType: freezed == timeFilterType ? _self.timeFilterType : timeFilterType // ignore: cast_nullable_to_non_nullable
as int?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedMonth: freezed == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as int?,selectedQuarter: freezed == selectedQuarter ? _self.selectedQuarter : selectedQuarter // ignore: cast_nullable_to_non_nullable
as int?,selectedYear: freezed == selectedYear ? _self.selectedYear : selectedYear // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class UpdateOrderStatusEvent implements OrdersEvent {
  const UpdateOrderStatusEvent(this.order, this.newStatus, {required this.onSuccess, required this.onError});
  

 final  OrderEntity order;
 final  int newStatus;
 final  void Function() onSuccess;
 final  void Function(String) onError;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateOrderStatusEventCopyWith<UpdateOrderStatusEvent> get copyWith => _$UpdateOrderStatusEventCopyWithImpl<UpdateOrderStatusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateOrderStatusEvent&&(identical(other.order, order) || other.order == order)&&(identical(other.newStatus, newStatus) || other.newStatus == newStatus)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,order,newStatus,onSuccess,onError);

@override
String toString() {
  return 'OrdersEvent.updateOrderStatus(order: $order, newStatus: $newStatus, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $UpdateOrderStatusEventCopyWith<$Res> implements $OrdersEventCopyWith<$Res> {
  factory $UpdateOrderStatusEventCopyWith(UpdateOrderStatusEvent value, $Res Function(UpdateOrderStatusEvent) _then) = _$UpdateOrderStatusEventCopyWithImpl;
@useResult
$Res call({
 OrderEntity order, int newStatus, void Function() onSuccess, void Function(String) onError
});




}
/// @nodoc
class _$UpdateOrderStatusEventCopyWithImpl<$Res>
    implements $UpdateOrderStatusEventCopyWith<$Res> {
  _$UpdateOrderStatusEventCopyWithImpl(this._self, this._then);

  final UpdateOrderStatusEvent _self;
  final $Res Function(UpdateOrderStatusEvent) _then;

/// Create a copy of OrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,Object? newStatus = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(UpdateOrderStatusEvent(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,null == newStatus ? _self.newStatus : newStatus // ignore: cast_nullable_to_non_nullable
as int,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String),
  ));
}


}

// dart format on
