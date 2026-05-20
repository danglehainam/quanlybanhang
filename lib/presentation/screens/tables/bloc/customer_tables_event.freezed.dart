// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_tables_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerTablesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerTablesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerTablesEvent()';
}


}

/// @nodoc
class $CustomerTablesEventCopyWith<$Res>  {
$CustomerTablesEventCopyWith(CustomerTablesEvent _, $Res Function(CustomerTablesEvent) __);
}


/// Adds pattern-matching-related methods to [CustomerTablesEvent].
extension CustomerTablesEventPatterns on CustomerTablesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadTables value)?  loadTables,TResult Function( _CreateTable value)?  createTable,TResult Function( _UpdateTable value)?  updateTable,TResult Function( _DeleteTable value)?  deleteTable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadTables() when loadTables != null:
return loadTables(_that);case _CreateTable() when createTable != null:
return createTable(_that);case _UpdateTable() when updateTable != null:
return updateTable(_that);case _DeleteTable() when deleteTable != null:
return deleteTable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadTables value)  loadTables,required TResult Function( _CreateTable value)  createTable,required TResult Function( _UpdateTable value)  updateTable,required TResult Function( _DeleteTable value)  deleteTable,}){
final _that = this;
switch (_that) {
case _LoadTables():
return loadTables(_that);case _CreateTable():
return createTable(_that);case _UpdateTable():
return updateTable(_that);case _DeleteTable():
return deleteTable(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadTables value)?  loadTables,TResult? Function( _CreateTable value)?  createTable,TResult? Function( _UpdateTable value)?  updateTable,TResult? Function( _DeleteTable value)?  deleteTable,}){
final _that = this;
switch (_that) {
case _LoadTables() when loadTables != null:
return loadTables(_that);case _CreateTable() when createTable != null:
return createTable(_that);case _UpdateTable() when updateTable != null:
return updateTable(_that);case _DeleteTable() when deleteTable != null:
return deleteTable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int storeId)?  loadTables,TResult Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)?  createTable,TResult Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)?  updateTable,TResult Function( int tableId,   Function() onSuccess,   Function(String) onError)?  deleteTable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadTables() when loadTables != null:
return loadTables(_that.storeId);case _CreateTable() when createTable != null:
return createTable(_that.table,_that.onSuccess,_that.onError);case _UpdateTable() when updateTable != null:
return updateTable(_that.table,_that.onSuccess,_that.onError);case _DeleteTable() when deleteTable != null:
return deleteTable(_that.tableId,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int storeId)  loadTables,required TResult Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)  createTable,required TResult Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)  updateTable,required TResult Function( int tableId,   Function() onSuccess,   Function(String) onError)  deleteTable,}) {final _that = this;
switch (_that) {
case _LoadTables():
return loadTables(_that.storeId);case _CreateTable():
return createTable(_that.table,_that.onSuccess,_that.onError);case _UpdateTable():
return updateTable(_that.table,_that.onSuccess,_that.onError);case _DeleteTable():
return deleteTable(_that.tableId,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int storeId)?  loadTables,TResult? Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)?  createTable,TResult? Function( CustomerTableEntity table,   Function() onSuccess,   Function(String) onError)?  updateTable,TResult? Function( int tableId,   Function() onSuccess,   Function(String) onError)?  deleteTable,}) {final _that = this;
switch (_that) {
case _LoadTables() when loadTables != null:
return loadTables(_that.storeId);case _CreateTable() when createTable != null:
return createTable(_that.table,_that.onSuccess,_that.onError);case _UpdateTable() when updateTable != null:
return updateTable(_that.table,_that.onSuccess,_that.onError);case _DeleteTable() when deleteTable != null:
return deleteTable(_that.tableId,_that.onSuccess,_that.onError);case _:
  return null;

}
}

}

/// @nodoc


class _LoadTables implements CustomerTablesEvent {
  const _LoadTables({required this.storeId});
  

 final  int storeId;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadTablesCopyWith<_LoadTables> get copyWith => __$LoadTablesCopyWithImpl<_LoadTables>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTables&&(identical(other.storeId, storeId) || other.storeId == storeId));
}


@override
int get hashCode => Object.hash(runtimeType,storeId);

@override
String toString() {
  return 'CustomerTablesEvent.loadTables(storeId: $storeId)';
}


}

/// @nodoc
abstract mixin class _$LoadTablesCopyWith<$Res> implements $CustomerTablesEventCopyWith<$Res> {
  factory _$LoadTablesCopyWith(_LoadTables value, $Res Function(_LoadTables) _then) = __$LoadTablesCopyWithImpl;
@useResult
$Res call({
 int storeId
});




}
/// @nodoc
class __$LoadTablesCopyWithImpl<$Res>
    implements _$LoadTablesCopyWith<$Res> {
  __$LoadTablesCopyWithImpl(this._self, this._then);

  final _LoadTables _self;
  final $Res Function(_LoadTables) _then;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storeId = null,}) {
  return _then(_LoadTables(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CreateTable implements CustomerTablesEvent {
  const _CreateTable(this.table, {required this.onSuccess, required this.onError});
  

 final  CustomerTableEntity table;
 final   Function() onSuccess;
 final   Function(String) onError;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTableCopyWith<_CreateTable> get copyWith => __$CreateTableCopyWithImpl<_CreateTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTable&&(identical(other.table, table) || other.table == table)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,table,onSuccess,onError);

@override
String toString() {
  return 'CustomerTablesEvent.createTable(table: $table, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$CreateTableCopyWith<$Res> implements $CustomerTablesEventCopyWith<$Res> {
  factory _$CreateTableCopyWith(_CreateTable value, $Res Function(_CreateTable) _then) = __$CreateTableCopyWithImpl;
@useResult
$Res call({
 CustomerTableEntity table,  Function() onSuccess,  Function(String) onError
});




}
/// @nodoc
class __$CreateTableCopyWithImpl<$Res>
    implements _$CreateTableCopyWith<$Res> {
  __$CreateTableCopyWithImpl(this._self, this._then);

  final _CreateTable _self;
  final $Res Function(_CreateTable) _then;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? table = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(_CreateTable(
null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as CustomerTableEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as  Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as  Function(String),
  ));
}


}

/// @nodoc


class _UpdateTable implements CustomerTablesEvent {
  const _UpdateTable(this.table, {required this.onSuccess, required this.onError});
  

 final  CustomerTableEntity table;
 final   Function() onSuccess;
 final   Function(String) onError;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTableCopyWith<_UpdateTable> get copyWith => __$UpdateTableCopyWithImpl<_UpdateTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTable&&(identical(other.table, table) || other.table == table)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,table,onSuccess,onError);

@override
String toString() {
  return 'CustomerTablesEvent.updateTable(table: $table, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$UpdateTableCopyWith<$Res> implements $CustomerTablesEventCopyWith<$Res> {
  factory _$UpdateTableCopyWith(_UpdateTable value, $Res Function(_UpdateTable) _then) = __$UpdateTableCopyWithImpl;
@useResult
$Res call({
 CustomerTableEntity table,  Function() onSuccess,  Function(String) onError
});




}
/// @nodoc
class __$UpdateTableCopyWithImpl<$Res>
    implements _$UpdateTableCopyWith<$Res> {
  __$UpdateTableCopyWithImpl(this._self, this._then);

  final _UpdateTable _self;
  final $Res Function(_UpdateTable) _then;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? table = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(_UpdateTable(
null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as CustomerTableEntity,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as  Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as  Function(String),
  ));
}


}

/// @nodoc


class _DeleteTable implements CustomerTablesEvent {
  const _DeleteTable(this.tableId, {required this.onSuccess, required this.onError});
  

 final  int tableId;
 final   Function() onSuccess;
 final   Function(String) onError;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteTableCopyWith<_DeleteTable> get copyWith => __$DeleteTableCopyWithImpl<_DeleteTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteTable&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,tableId,onSuccess,onError);

@override
String toString() {
  return 'CustomerTablesEvent.deleteTable(tableId: $tableId, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$DeleteTableCopyWith<$Res> implements $CustomerTablesEventCopyWith<$Res> {
  factory _$DeleteTableCopyWith(_DeleteTable value, $Res Function(_DeleteTable) _then) = __$DeleteTableCopyWithImpl;
@useResult
$Res call({
 int tableId,  Function() onSuccess,  Function(String) onError
});




}
/// @nodoc
class __$DeleteTableCopyWithImpl<$Res>
    implements _$DeleteTableCopyWith<$Res> {
  __$DeleteTableCopyWithImpl(this._self, this._then);

  final _DeleteTable _self;
  final $Res Function(_DeleteTable) _then;

/// Create a copy of CustomerTablesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tableId = null,Object? onSuccess = null,Object? onError = null,}) {
  return _then(_DeleteTable(
null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as int,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as  Function(),onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as  Function(String),
  ));
}


}

// dart format on
