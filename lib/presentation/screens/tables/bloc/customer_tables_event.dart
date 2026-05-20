import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/customer_table_entity.dart';

part 'customer_tables_event.freezed.dart';

@freezed
class CustomerTablesEvent with _$CustomerTablesEvent {
  const factory CustomerTablesEvent.loadTables({required int storeId}) = _LoadTables;
  const factory CustomerTablesEvent.createTable(
    CustomerTableEntity table, {
    required Function() onSuccess,
    required Function(String) onError,
  }) = _CreateTable;
  const factory CustomerTablesEvent.updateTable(
    CustomerTableEntity table, {
    required Function() onSuccess,
    required Function(String) onError,
  }) = _UpdateTable;
  const factory CustomerTablesEvent.deleteTable(
    int tableId, {
    required Function() onSuccess,
    required Function(String) onError,
  }) = _DeleteTable;
}
