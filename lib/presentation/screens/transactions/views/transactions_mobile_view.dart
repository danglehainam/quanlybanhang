import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../domain/entities/transaction_entity.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/empty_data_widget.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../widgets/transaction_form_dialog.dart';

class TransactionsMobileView extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionsMobileView({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (transactions.isEmpty) {
      return EmptyDataWidget(message: l10n.emptyTransactionList);
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isIncome = transaction.type == 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isIncome
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: isIncome ? AppColors.success : AppColors.error,
              ),
            ),
            title: Text(
              transaction.note,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(dateFormat.format(transaction.createdAt.toLocal())),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${isIncome ? '+' : '-'}${CurrencyUtils.formatCurrency(transaction.amount)}',
                  style: TextStyle(
                    color: isIncome ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<TransactionsBloc>(),
                          child: TransactionFormDialog(transactionToEdit: transaction),
                        ),
                      );
                    } else if (value == 'delete') {
                      _confirmDelete(context, transaction);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                    PopupMenuItem(value: 'delete', child: Text(l10n.delete)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
