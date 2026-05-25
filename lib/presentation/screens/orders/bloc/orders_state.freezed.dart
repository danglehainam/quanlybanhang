// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersState()';
}


}

/// @nodoc
class $OrdersStateCopyWith<$Res>  {
$OrdersStateCopyWith(OrdersState _, $Res Function(OrdersState) __);
}


/// Adds pattern-matching-related methods to [OrdersState].
extension OrdersStatePatterns on OrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrdersInitialState value)?  initial,TResult Function( OrdersLoadingState value)?  loading,TResult Function( OrdersErrorState value)?  error,TResult Function( OrdersLoadedState value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrdersInitialState() when initial != null:
return initial(_that);case OrdersLoadingState() when loading != null:
return loading(_that);case OrdersErrorState() when error != null:
return error(_that);case OrdersLoadedState() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrdersInitialState value)  initial,required TResult Function( OrdersLoadingState value)  loading,required TResult Function( OrdersErrorState value)  error,required TResult Function( OrdersLoadedState value)  loaded,}){
final _that = this;
switch (_that) {
case OrdersInitialState():
return initial(_that);case OrdersLoadingState():
return loading(_that);case OrdersErrorState():
return error(_that);case OrdersLoadedState():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrdersInitialState value)?  initial,TResult? Function( OrdersLoadingState value)?  loading,TResult? Function( OrdersErrorState value)?  error,TResult? Function( OrdersLoadedState value)?  loaded,}){
final _that = this;
switch (_that) {
case OrdersInitialState() when initial != null:
return initial(_that);case OrdersLoadingState() when loading != null:
return loading(_that);case OrdersErrorState() when error != null:
return error(_that);case OrdersLoadedState() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( List<OrderEntity> allOrders,  List<OrderEntity> filteredOrders,  String searchQuery,  int? statusFilter,  int? sortOption,  int timeFilterType,  DateTime selectedDate,  int selectedMonth,  int selectedQuarter,  int selectedYear)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrdersInitialState() when initial != null:
return initial();case OrdersLoadingState() when loading != null:
return loading();case OrdersErrorState() when error != null:
return error(_that.message);case OrdersLoadedState() when loaded != null:
return loaded(_that.allOrders,_that.filteredOrders,_that.searchQuery,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( List<OrderEntity> allOrders,  List<OrderEntity> filteredOrders,  String searchQuery,  int? statusFilter,  int? sortOption,  int timeFilterType,  DateTime selectedDate,  int selectedMonth,  int selectedQuarter,  int selectedYear)  loaded,}) {final _that = this;
switch (_that) {
case OrdersInitialState():
return initial();case OrdersLoadingState():
return loading();case OrdersErrorState():
return error(_that.message);case OrdersLoadedState():
return loaded(_that.allOrders,_that.filteredOrders,_that.searchQuery,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( List<OrderEntity> allOrders,  List<OrderEntity> filteredOrders,  String searchQuery,  int? statusFilter,  int? sortOption,  int timeFilterType,  DateTime selectedDate,  int selectedMonth,  int selectedQuarter,  int selectedYear)?  loaded,}) {final _that = this;
switch (_that) {
case OrdersInitialState() when initial != null:
return initial();case OrdersLoadingState() when loading != null:
return loading();case OrdersErrorState() when error != null:
return error(_that.message);case OrdersLoadedState() when loaded != null:
return loaded(_that.allOrders,_that.filteredOrders,_that.searchQuery,_that.statusFilter,_that.sortOption,_that.timeFilterType,_that.selectedDate,_that.selectedMonth,_that.selectedQuarter,_that.selectedYear);case _:
  return null;

}
}

}

/// @nodoc


class OrdersInitialState implements OrdersState {
  const OrdersInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersState.initial()';
}


}




/// @nodoc


class OrdersLoadingState implements OrdersState {
  const OrdersLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersState.loading()';
}


}




/// @nodoc


class OrdersErrorState implements OrdersState {
  const OrdersErrorState(this.message);
  

 final  String message;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersErrorStateCopyWith<OrdersErrorState> get copyWith => _$OrdersErrorStateCopyWithImpl<OrdersErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrdersState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrdersErrorStateCopyWith<$Res> implements $OrdersStateCopyWith<$Res> {
  factory $OrdersErrorStateCopyWith(OrdersErrorState value, $Res Function(OrdersErrorState) _then) = _$OrdersErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrdersErrorStateCopyWithImpl<$Res>
    implements $OrdersErrorStateCopyWith<$Res> {
  _$OrdersErrorStateCopyWithImpl(this._self, this._then);

  final OrdersErrorState _self;
  final $Res Function(OrdersErrorState) _then;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrdersErrorState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OrdersLoadedState implements OrdersState {
  const OrdersLoadedState({required final  List<OrderEntity> allOrders, required final  List<OrderEntity> filteredOrders, required this.searchQuery, this.statusFilter, this.sortOption, required this.timeFilterType, required this.selectedDate, required this.selectedMonth, required this.selectedQuarter, required this.selectedYear}): _allOrders = allOrders,_filteredOrders = filteredOrders;
  

 final  List<OrderEntity> _allOrders;
 List<OrderEntity> get allOrders {
  if (_allOrders is EqualUnmodifiableListView) return _allOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allOrders);
}

 final  List<OrderEntity> _filteredOrders;
 List<OrderEntity> get filteredOrders {
  if (_filteredOrders is EqualUnmodifiableListView) return _filteredOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredOrders);
}

 final  String searchQuery;
 final  int? statusFilter;
 final  int? sortOption;
 final  int timeFilterType;
 final  DateTime selectedDate;
 final  int selectedMonth;
 final  int selectedQuarter;
 final  int selectedYear;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersLoadedStateCopyWith<OrdersLoadedState> get copyWith => _$OrdersLoadedStateCopyWithImpl<OrdersLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersLoadedState&&const DeepCollectionEquality().equals(other._allOrders, _allOrders)&&const DeepCollectionEquality().equals(other._filteredOrders, _filteredOrders)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption)&&(identical(other.timeFilterType, timeFilterType) || other.timeFilterType == timeFilterType)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedQuarter, selectedQuarter) || other.selectedQuarter == selectedQuarter)&&(identical(other.selectedYear, selectedYear) || other.selectedYear == selectedYear));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allOrders),const DeepCollectionEquality().hash(_filteredOrders),searchQuery,statusFilter,sortOption,timeFilterType,selectedDate,selectedMonth,selectedQuarter,selectedYear);

@override
String toString() {
  return 'OrdersState.loaded(allOrders: $allOrders, filteredOrders: $filteredOrders, searchQuery: $searchQuery, statusFilter: $statusFilter, sortOption: $sortOption, timeFilterType: $timeFilterType, selectedDate: $selectedDate, selectedMonth: $selectedMonth, selectedQuarter: $selectedQuarter, selectedYear: $selectedYear)';
}


}

/// @nodoc
abstract mixin class $OrdersLoadedStateCopyWith<$Res> implements $OrdersStateCopyWith<$Res> {
  factory $OrdersLoadedStateCopyWith(OrdersLoadedState value, $Res Function(OrdersLoadedState) _then) = _$OrdersLoadedStateCopyWithImpl;
@useResult
$Res call({
 List<OrderEntity> allOrders, List<OrderEntity> filteredOrders, String searchQuery, int? statusFilter, int? sortOption, int timeFilterType, DateTime selectedDate, int selectedMonth, int selectedQuarter, int selectedYear
});




}
/// @nodoc
class _$OrdersLoadedStateCopyWithImpl<$Res>
    implements $OrdersLoadedStateCopyWith<$Res> {
  _$OrdersLoadedStateCopyWithImpl(this._self, this._then);

  final OrdersLoadedState _self;
  final $Res Function(OrdersLoadedState) _then;

/// Create a copy of OrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? allOrders = null,Object? filteredOrders = null,Object? searchQuery = null,Object? statusFilter = freezed,Object? sortOption = freezed,Object? timeFilterType = null,Object? selectedDate = null,Object? selectedMonth = null,Object? selectedQuarter = null,Object? selectedYear = null,}) {
  return _then(OrdersLoadedState(
allOrders: null == allOrders ? _self._allOrders : allOrders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,filteredOrders: null == filteredOrders ? _self._filteredOrders : filteredOrders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,statusFilter: freezed == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as int?,sortOption: freezed == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as int?,timeFilterType: null == timeFilterType ? _self.timeFilterType : timeFilterType // ignore: cast_nullable_to_non_nullable
as int,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedMonth: null == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as int,selectedQuarter: null == selectedQuarter ? _self.selectedQuarter : selectedQuarter // ignore: cast_nullable_to_non_nullable
as int,selectedYear: null == selectedYear ? _self.selectedYear : selectedYear // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
