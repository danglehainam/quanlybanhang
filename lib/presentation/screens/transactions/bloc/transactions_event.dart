import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/transaction_entity.dart';

part 'transactions_event.freezed.dart';

@freezed
abstract class TransactionsEvent with _$TransactionsEvent {
  const factory TransactionsEvent.loadTransactions({required int storeId}) = _LoadTransactions;
  
  const factory TransactionsEvent.createTransaction(
    TransactionEntity transaction, {
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) = _CreateTransaction;
  
  const factory TransactionsEvent.updateTransaction(
    TransactionEntity transaction, {
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) = _UpdateTransaction;
  
  const factory TransactionsEvent.deleteTransaction(
    int transactionId, {
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) = _DeleteTransaction;
}

typedef VoidCallback = void Function();
