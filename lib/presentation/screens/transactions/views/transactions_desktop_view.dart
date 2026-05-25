import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../domain/entities/transaction_entity.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/layout/two_column_desktop_layout.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/buttons/app_icon_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../widgets/transaction_form_dialog.dart';
import '../widgets/transaction_filter_sidebar.dart';

class TransactionsDesktopView extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const TransactionsDesktopView({super.key, required this.transactions});

  @override
  State<TransactionsDesktopView> createState() => _TransactionsDesktopViewState();
}

class _TransactionsDesktopViewState extends State<TransactionsDesktopView> {
  String _searchQuery = '';
  int _selectedFilter = -1; // -1: All, 0: Income, 1: Expense
  int _sortOption = 0; // 0: Newest, 1: Oldest, 2: Highest Value, 3: Lowest Value

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    // 1. Filter transactions by type and search query (case-insensitive on note)
    var filteredTransactions = widget.transactions.where((t) {
      final matchesType = _selectedFilter == -1 ? true : t.type == _selectedFilter;
      final matchesSearch = t.note.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();

    // 2. Sort transactions
    switch (_sortOption) {
      case 0: // Newest
        filteredTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 1: // Oldest
        filteredTransactions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 2: // Highest Value
        filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case 3: // Lowest Value
        filteredTransactions.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    return TwoColumnDesktopLayout(
      leftContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TransactionFilterSidebar(
              searchQuery: _searchQuery,
              selectedType: _selectedFilter,
              sortOption: _sortOption,
              onFilterChanged: ({query, type, sortOption}) {
                setState(() {
                  if (query != null) _searchQuery = query;
                  if (type != null) _selectedFilter = type;
                  if (sortOption != null) _sortOption = sortOption;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: AppFilledButton(
                    label: l10n.addIncome,
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<TransactionsBloc>(),
                          child: const TransactionFormDialog(initialType: 0),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: AppFilledButton(
                    label: l10n.addExpense,
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<TransactionsBloc>(),
                          child: const TransactionFormDialog(initialType: 1),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      rightContent: filteredTransactions.isEmpty
          ? EmptyDataWidget(message: l10n.emptyTransactionMessage)
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      columns: [
                        DataColumn(label: Text(l10n.transactionTypeCol)),
                        DataColumn(label: Text(l10n.transactionAmountCol)),
                        DataColumn(label: Text(l10n.transactionNoteCol)),
                        DataColumn(label: Text(l10n.transactionDateCol)),
                        DataColumn(label: Text(l10n.actionsLabel)),
                      ],
                      rows: filteredTransactions.map((transaction) {
                        final isIncome = transaction.type == 0;
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isIncome
                                      ? AppColors.success.withValues(alpha: 0.1)
                                      : AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isIncome ? l10n.income : l10n.expense,
                                  style: TextStyle(
                                    color: isIncome ? AppColors.success : AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${isIncome ? '+' : '-'}${CurrencyUtils.formatCurrency(transaction.amount)}',
                                style: TextStyle(
                                  color: isIncome ? AppColors.success : AppColors.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(Text(transaction.note)),
                            DataCell(Text(dateFormat.format(transaction.createdAt.toLocal()))),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppIconButton(
                                    icon: Icons.edit,
                                    color: AppColors.primary,
                                    tooltip: l10n.edit,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<TransactionsBloc>(),
                                          child: TransactionFormDialog(transactionToEdit: transaction),
                                        ),
                                      );
                                    },
                                  ),
                                  AppIconButton(
                                    icon: Icons.delete,
                                    color: AppColors.error,
                                    tooltip: l10n.delete,
                                    onPressed: () => _confirmDelete(context, transaction),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _confirmDelete(BuildContext context, TransactionEntity transaction) {
    final l10n = AppLocalizations.of(context)!;
    showAdaptiveDialog(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: Text(l10n.confirmDeleteTransactionTitle),
        content: Text(l10n.confirmDeleteTransactionMessage(transaction.id)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TransactionsBloc>().add(
                    TransactionsEvent.deleteTransaction(
                      transaction.id,
                      onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.transactionDeletedSuccess)),
                        );
                      },
                      onError: (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err), backgroundColor: AppColors.error),
                        );
                      },
                    ),
                  );
            },
            child: Text(l10n.delete, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
