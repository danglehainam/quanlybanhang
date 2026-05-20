// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransactionsEvent()';
}


}

/// @nodoc
class $TransactionsEventCopyWith<$Res>  {
$TransactionsEventCopyWith(TransactionsEvent _, $Res Function(TransactionsEvent) __);
}


/// Adds pattern-matching-related methods to [TransactionsEvent].
extension TransactionsEventPatterns on TransactionsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadTransactions value)?  loadTransactions,TResult Function( _CreateTransaction value)?  createTransaction,TResult Function( _UpdateTransaction value)?  updateTransaction,TResult Function( _DeleteTransaction value)?  deleteTransaction,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadTransactions() when loadTransactions != null:
return loadTransactions(_that);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that);case _UpdateTransaction() when updateTransaction != null:
return updateTransaction(_that);case _DeleteTransaction() when deleteTransaction != null:
return deleteTransaction(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadTransactions value)  loadTransactions,required TResult Function( _CreateTransaction value)  createTransaction,required TResult Function( _UpdateTransaction value)  updateTransaction,required TResult Function( _DeleteTransaction value)  deleteTransaction,}){
final _that = this;
switch (_that) {
case _LoadTransactions():
return loadTransactions(_that);case _CreateTransaction():
return createTransaction(_that);case _UpdateTransaction():
return updateTransaction(_that);case _DeleteTransaction():
return deleteTransaction(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadTransactions value)?  loadTransactions,TResult? Function( _CreateTransaction value)?  createTransaction,TResult? Function( _UpdateTransaction value)?  updateTransaction,TResult? Function( _DeleteTransaction value)?  deleteTransaction,}){
final _that = this;
switch (_that) {
case _LoadTransactions() when loadTransactions != null:
return loadTransactions(_that);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that);case _UpdateTransaction() when updateTransaction != null:
return updateTransaction(_that);case _DeleteTransaction() when deleteTransaction != null:
return deleteTransaction(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int storeId)?  loadTransactions,TResult Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)?  createTransaction,TResult Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)?  updateTransaction,TResult Function( int transactionId,  VoidCallback? onSuccess,  void Function(String error)? onError)?  deleteTransaction,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadTransactions() when loadTransactions != null:
return loadTransactions(_that.storeId);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that.transaction,_that.onSuccess,_that.onError);case _UpdateTransaction() when updateTransaction != null:
return updateTransaction(_that.transaction,_that.onSuccess,_that.onError);case _DeleteTransaction() when deleteTransaction != null:
return deleteTransaction(_that.transactionId,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int storeId)  loadTransactions,required TResult Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)  createTransaction,required TResult Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)  updateTransaction,required TResult Function( int transactionId,  VoidCallback? onSuccess,  void Function(String error)? onError)  deleteTransaction,}) {final _that = this;
switch (_that) {
case _LoadTransactions():
return loadTransactions(_that.storeId);case _CreateTransaction():
return createTransaction(_that.transaction,_that.onSuccess,_that.onError);case _UpdateTransaction():
return updateTransaction(_that.transaction,_that.onSuccess,_that.onError);case _DeleteTransaction():
return deleteTransaction(_that.transactionId,_that.onSuccess,_that.onError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int storeId)?  loadTransactions,TResult? Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)?  createTransaction,TResult? Function( TransactionEntity transaction,  VoidCallback? onSuccess,  void Function(String error)? onError)?  updateTransaction,TResult? Function( int transactionId,  VoidCallback? onSuccess,  void Function(String error)? onError)?  deleteTransaction,}) {final _that = this;
switch (_that) {
case _LoadTransactions() when loadTransactions != null:
return loadTransactions(_that.storeId);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that.transaction,_that.onSuccess,_that.onError);case _UpdateTransaction() when updateTransaction != null:
return updateTransaction(_that.transaction,_that.onSuccess,_that.onError);case _DeleteTransaction() when deleteTransaction != null:
return deleteTransaction(_that.transactionId,_that.onSuccess,_that.onError);case _:
  return null;

}
}

}

/// @nodoc


class _LoadTransactions implements TransactionsEvent {
  const _LoadTransactions({required this.storeId});
  

 final  int storeId;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadTransactionsCopyWith<_LoadTransactions> get copyWith => __$LoadTransactionsCopyWithImpl<_LoadTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTransactions&&(identical(other.storeId, storeId) || other.storeId == storeId));
}


@override
int get hashCode => Object.hash(runtimeType,storeId);

@override
String toString() {
  return 'TransactionsEvent.loadTransactions(storeId: $storeId)';
}


}

/// @nodoc
abstract mixin class _$LoadTransactionsCopyWith<$Res> implements $TransactionsEventCopyWith<$Res> {
  factory _$LoadTransactionsCopyWith(_LoadTransactions value, $Res Function(_LoadTransactions) _then) = __$LoadTransactionsCopyWithImpl;
@useResult
$Res call({
 int storeId
});




}
/// @nodoc
class __$LoadTransactionsCopyWithImpl<$Res>
    implements _$LoadTransactionsCopyWith<$Res> {
  __$LoadTransactionsCopyWithImpl(this._self, this._then);

  final _LoadTransactions _self;
  final $Res Function(_LoadTransactions) _then;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storeId = null,}) {
  return _then(_LoadTransactions(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CreateTransaction implements TransactionsEvent {
  const _CreateTransaction(this.transaction, {this.onSuccess, this.onError});
  

 final  TransactionEntity transaction;
 final  VoidCallback? onSuccess;
 final  void Function(String error)? onError;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTransactionCopyWith<_CreateTransaction> get copyWith => __$CreateTransactionCopyWithImpl<_CreateTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTransaction&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,transaction,onSuccess,onError);

@override
String toString() {
  return 'TransactionsEvent.createTransaction(transaction: $transaction, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$CreateTransactionCopyWith<$Res> implements $TransactionsEventCopyWith<$Res> {
  factory _$CreateTransactionCopyWith(_CreateTransaction value, $Res Function(_CreateTransaction) _then) = __$CreateTransactionCopyWithImpl;
@useResult
$Res call({
 TransactionEntity transaction, VoidCallback? onSuccess, void Function(String error)? onError
});




}
/// @nodoc
class __$CreateTransactionCopyWithImpl<$Res>
    implements _$CreateTransactionCopyWith<$Res> {
  __$CreateTransactionCopyWithImpl(this._self, this._then);

  final _CreateTransaction _self;
  final $Res Function(_CreateTransaction) _then;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? onSuccess = freezed,Object? onError = freezed,}) {
  return _then(_CreateTransaction(
null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionEntity,onSuccess: freezed == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as VoidCallback?,onError: freezed == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String error)?,
  ));
}


}

/// @nodoc


class _UpdateTransaction implements TransactionsEvent {
  const _UpdateTransaction(this.transaction, {this.onSuccess, this.onError});
  

 final  TransactionEntity transaction;
 final  VoidCallback? onSuccess;
 final  void Function(String error)? onError;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTransactionCopyWith<_UpdateTransaction> get copyWith => __$UpdateTransactionCopyWithImpl<_UpdateTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTransaction&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,transaction,onSuccess,onError);

@override
String toString() {
  return 'TransactionsEvent.updateTransaction(transaction: $transaction, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$UpdateTransactionCopyWith<$Res> implements $TransactionsEventCopyWith<$Res> {
  factory _$UpdateTransactionCopyWith(_UpdateTransaction value, $Res Function(_UpdateTransaction) _then) = __$UpdateTransactionCopyWithImpl;
@useResult
$Res call({
 TransactionEntity transaction, VoidCallback? onSuccess, void Function(String error)? onError
});




}
/// @nodoc
class __$UpdateTransactionCopyWithImpl<$Res>
    implements _$UpdateTransactionCopyWith<$Res> {
  __$UpdateTransactionCopyWithImpl(this._self, this._then);

  final _UpdateTransaction _self;
  final $Res Function(_UpdateTransaction) _then;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? onSuccess = freezed,Object? onError = freezed,}) {
  return _then(_UpdateTransaction(
null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionEntity,onSuccess: freezed == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as VoidCallback?,onError: freezed == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String error)?,
  ));
}


}

/// @nodoc


class _DeleteTransaction implements TransactionsEvent {
  const _DeleteTransaction(this.transactionId, {this.onSuccess, this.onError});
  

 final  int transactionId;
 final  VoidCallback? onSuccess;
 final  void Function(String error)? onError;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteTransactionCopyWith<_DeleteTransaction> get copyWith => __$DeleteTransactionCopyWithImpl<_DeleteTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,onSuccess,onError);

@override
String toString() {
  return 'TransactionsEvent.deleteTransaction(transactionId: $transactionId, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$DeleteTransactionCopyWith<$Res> implements $TransactionsEventCopyWith<$Res> {
  factory _$DeleteTransactionCopyWith(_DeleteTransaction value, $Res Function(_DeleteTransaction) _then) = __$DeleteTransactionCopyWithImpl;
@useResult
$Res call({
 int transactionId, VoidCallback? onSuccess, void Function(String error)? onError
});




}
/// @nodoc
class __$DeleteTransactionCopyWithImpl<$Res>
    implements _$DeleteTransactionCopyWith<$Res> {
  __$DeleteTransactionCopyWithImpl(this._self, this._then);

  final _DeleteTransaction _self;
  final $Res Function(_DeleteTransaction) _then;

/// Create a copy of TransactionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? onSuccess = freezed,Object? onError = freezed,}) {
  return _then(_DeleteTransaction(
null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,onSuccess: freezed == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as VoidCallback?,onError: freezed == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String error)?,
  ));
}


}

// dart format on
