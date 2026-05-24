import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../domain/entities/customer_table_entity.dart';
import '../../../../../domain/usecases/get_customer_tables_usecase.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';
import '../../../widgets/app_dialog.dart';
import '../../../../../l10n/app_localizations.dart';

class TableSelectionCubit extends Cubit<List<CustomerTableEntity>?> {
  final GetCustomerTablesUseCase getTablesUseCase;

  TableSelectionCubit(this.getTablesUseCase) : super(null);

  void loadTables(int storeId) async {
    final stream = getTablesUseCase.execute(storeId);
    stream.listen((eitherResult) {
      eitherResult.fold(
        (failure) => emit([]),
        (tables) => emit(tables.where((t) => t.status == 1).toList()),
      );
    });
  }
}

class TableSelectionDialog extends StatelessWidget {
  const TableSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 1,
    );

    return BlocProvider(
      create: (context) => TableSelectionCubit(getIt())..loadTables(storeId),
      child: BlocBuilder<TableSelectionCubit, List<CustomerTableEntity>?>(
        builder: (context, tables) {
          final l10n = AppLocalizations.of(context)!;
          
          return AppDialog(
            title: l10n.selectTable,
            content: tables == null
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : tables.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: Text('Chưa có dữ liệu bàn.')),
                      )
                    : SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tables.length,
                          itemBuilder: (context, index) {
                            final table = tables[index];
                            return ListTile(
                              title: Text(table.name),
                              onTap: () {
                                Navigator.of(context).pop(table);
                              },
                            );
                          },
                        ),
                      ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('clear'), // return 'clear' to explicitly clear table
                child: const Text('Bỏ chọn'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
            ],
          );
        },
      ),
    );
  }
}
