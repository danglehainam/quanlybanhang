import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/customer_table_entity.dart';

part 'customer_tables_state.freezed.dart';

@freezed
class CustomerTablesState with _$CustomerTablesState {
  const factory CustomerTablesState.initial() = _Initial;
  const factory CustomerTablesState.loading() = _Loading;
  const factory CustomerTablesState.loaded(List<CustomerTableEntity> tables) = _Loaded;
  const factory CustomerTablesState.error(String message) = _Error;
}
