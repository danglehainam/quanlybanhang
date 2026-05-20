import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_customer_tables_usecase.dart';
import '../../../../domain/usecases/create_customer_table_usecase.dart';
import '../../../../domain/usecases/update_customer_table_usecase.dart';
import '../../../../domain/usecases/delete_customer_table_usecase.dart';
import 'customer_tables_event.dart';
import 'customer_tables_state.dart';

class CustomerTablesBloc extends Bloc<CustomerTablesEvent, CustomerTablesState> {
  final GetCustomerTablesUseCase _getTablesUseCase;
  final CreateCustomerTableUseCase _createTableUseCase;
  final UpdateCustomerTableUseCase _updateTableUseCase;
  final DeleteCustomerTableUseCase _deleteTableUseCase;

  StreamSubscription? _tablesSubscription;

  CustomerTablesBloc(
    this._getTablesUseCase,
    this._createTableUseCase,
    this._updateTableUseCase,
    this._deleteTableUseCase,
  ) : super(const CustomerTablesState.initial()) {
    on<CustomerTablesEvent>((event, emit) async {
      await event.map(
        loadTables: (e) async {
          emit(const CustomerTablesState.loading());
          await _tablesSubscription?.cancel();

          _tablesSubscription = _getTablesUseCase.execute(e.storeId).listen(
            (result) {
              result.fold(
                (failure) => addError(failure), // Handle via BlocObserver or emit error
                (tables) => emit(CustomerTablesState.loaded(tables)),
              );
            },
            onError: (error) {
              emit(CustomerTablesState.error('Lỗi stream: $error'));
            },
          );
        },
        createTable: (e) async {
          final result = await _createTableUseCase.execute(e.table);
          result.fold(
            (failure) => e.onError(failure.message),
            (_) => e.onSuccess(),
          );
        },
        updateTable: (e) async {
          final result = await _updateTableUseCase.execute(e.table);
          result.fold(
            (failure) => e.onError(failure.message),
            (_) => e.onSuccess(),
          );
        },
        deleteTable: (e) async {
          final result = await _deleteTableUseCase.execute(e.tableId);
          result.fold(
            (failure) => e.onError(failure.message),
            (_) => e.onSuccess(),
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    _tablesSubscription?.cancel();
    return super.close();
  }
}
