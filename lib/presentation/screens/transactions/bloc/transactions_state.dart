import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/transaction_entity.dart';

part 'transactions_state.freezed.dart';

@freezed
abstract class TransactionsState with _$TransactionsState {
  const factory TransactionsState.initial() = _Initial;
  const factory TransactionsState.loading() = _Loading;
  const factory TransactionsState.loaded(List<TransactionEntity> transactions) = _Loaded;
  const factory TransactionsState.error(String message) = _Error;
}
