import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/transaction_entity.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/layout/two_column_desktop_layout.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_icon_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../widgets/transaction_form_dialog.dart';

class TransactionsDesktopView extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const TransactionsDesktopView({super.key, required this.transactions});

  @override
  State<TransactionsDesktopView> createState() => _TransactionsDesktopViewState();
}

class _TransactionsDesktopViewState extends State<TransactionsDesktopView> {
  int _selectedFilter = -1; // -1: All, 0: Income, 1: Expense

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    // Lọc giao dịch
    final filteredTransactions = widget.transactions.where((t) {
      if (_selectedFilter == -1) return true;
      return t.type == _selectedFilter;
    }).toList();

    return TwoColumnDesktopLayout(
      leftContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Bộ lọc giao dịch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: _selectedFilter,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: const [
              DropdownMenuItem(value: -1, child: Text('Tất cả giao dịch')),
              DropdownMenuItem(value: 0, child: Text('Chỉ khoản thu')),
              DropdownMenuItem(value: 1, child: Text('Chỉ khoản chi')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedFilter = val);
              }
            },
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: 'Thêm giao dịch',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<TransactionsBloc>(),
                  child: const TransactionFormDialog(),
                ),
              );
            },
          ),
        ],
      ),
      rightContent: filteredTransactions.isEmpty
          ? const EmptyDataWidget(message: 'Không tìm thấy giao dịch nào phù hợp')
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      columns: const [
                        DataColumn(label: Text('Loại')),
                        DataColumn(label: Text('Số Tiền')),
                        DataColumn(label: Text('Ghi Chú')),
                        DataColumn(label: Text('Ngày Tạo')),
                        DataColumn(label: Text('Thao tác')),
                      ],
                      rows: filteredTransactions.map((transaction) {
                        final isIncome = transaction.type == 0;
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isIncome ? 'Thu' : 'Chi',
                                  style: TextStyle(
                                    color: isIncome ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${isIncome ? '+' : '-'}${CurrencyUtils.formatCurrency(transaction.amount)}',
                                style: TextStyle(
                                  color: isIncome ? Colors.green : Colors.red,
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
                                    tooltip: 'Sửa',
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
                                    tooltip: 'Xóa',
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
    showAdaptiveDialog(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa giao dịch ${transaction.id} này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TransactionsBloc>().add(
                    TransactionsEvent.deleteTransaction(
                      transaction.id,
                      onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Xóa giao dịch thành công')),
                        );
                      },
                      onError: (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(err), backgroundColor: Colors.red),
                        );
                      },
                    ),
                  );
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
