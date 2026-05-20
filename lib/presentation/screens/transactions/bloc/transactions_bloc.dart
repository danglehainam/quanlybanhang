import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_transactions_usecase.dart';
import '../../../../domain/usecases/create_transaction_usecase.dart';
import '../../../../domain/usecases/update_transaction_usecase.dart';
import '../../../../domain/usecases/delete_transaction_usecase.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactionsUseCase _getTransactionsUseCase;
  final CreateTransactionUseCase _createTransactionUseCase;
  final UpdateTransactionUseCase _updateTransactionUseCase;
  final DeleteTransactionUseCase _deleteTransactionUseCase;

  TransactionsBloc(
    this._getTransactionsUseCase,
    this._createTransactionUseCase,
    this._updateTransactionUseCase,
    this._deleteTransactionUseCase,
  ) : super(const TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      await event.map(
        loadTransactions: (e) async {
          emit(const TransactionsState.loading());
          await emit.forEach(
            _getTransactionsUseCase(e.storeId),
            onData: (result) {
              return result.fold(
                (failure) => TransactionsState.error(failure.message),
                (transactions) => TransactionsState.loaded(transactions),
              );
            },
            onError: (error, stackTrace) {
              return TransactionsState.error('Lỗi khi tải danh sách giao dịch');
            },
          );
        },
        createTransaction: (e) async {
          final result = await _createTransactionUseCase(e.transaction);
          result.fold(
            (failure) {
              if (e.onError != null) e.onError!(failure.message);
            },
            (id) {
              if (e.onSuccess != null) e.onSuccess!();
            },
          );
        },
        updateTransaction: (e) async {
          final result = await _updateTransactionUseCase(e.transaction);
          result.fold(
            (failure) {
              if (e.onError != null) e.onError!(failure.message);
            },
            (success) {
              if (e.onSuccess != null) e.onSuccess!();
            },
          );
        },
        deleteTransaction: (e) async {
          final result = await _deleteTransactionUseCase(e.transactionId);
          result.fold(
            (failure) {
              if (e.onError != null) e.onError!(failure.message);
            },
            (success) {
              if (e.onSuccess != null) e.onSuccess!();
            },
          );
        },
      );
    });
  }
}
