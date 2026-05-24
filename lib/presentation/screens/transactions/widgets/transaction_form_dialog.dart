import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../domain/entities/transaction_entity.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_text_button.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';

class TransactionFormDialog extends StatefulWidget {
  final TransactionEntity? transactionToEdit;
  final int? initialType;

  const TransactionFormDialog({
    super.key,
    this.transactionToEdit,
    this.initialType,
  });

  @override
  State<TransactionFormDialog> createState() => _TransactionFormDialogState();
}

class _TransactionFormDialogState extends State<TransactionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  int _selectedType = 0; // 0: income, 1: expense
  bool _isLoading = false;

  bool get _isEditMode => widget.transactionToEdit != null;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.transactionToEdit != null
        ? CurrencyUtils.formatNumber(widget.transactionToEdit!.amount)
        : '',
    );
    _noteController = TextEditingController(text: widget.transactionToEdit?.note);
    _selectedType = widget.transactionToEdit?.type ?? widget.initialType ?? 0;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authState = context.read<AuthBloc>().state;
      UserEntity? currentUser;
      authState.maybeWhen(
        authenticated: (user) => currentUser = user,
        orElse: () {},
      );

      if (currentUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final amount = CurrencyUtils.parseCurrency(_amountController.text);

      final transaction = TransactionEntity(
        id: _isEditMode ? widget.transactionToEdit!.id : 0,
        storeId: currentUser!.storeId,
        createdBy: currentUser!.id,
        type: _selectedType,
        amount: amount,
        note: _noteController.text.trim(),
        createdAt: _isEditMode ? widget.transactionToEdit!.createdAt : DateTime.now().toUtc(),
      );

      final bloc = context.read<TransactionsBloc>();

      if (_isEditMode) {
        bloc.add(TransactionsEvent.updateTransaction(
          transaction,
          onSuccess: () {
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập nhật giao dịch thành công')),
              );
            }
          },
          onError: (error) {
            if (mounted) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error), backgroundColor: Colors.red),
              );
            }
          },
        ));
      } else {
        bloc.add(TransactionsEvent.createTransaction(
          transaction,
          onSuccess: () {
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tạo giao dịch thành công')),
              );
            }
          },
          onError: (error) {
            if (mounted) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error), backgroundColor: Colors.red),
              );
            }
          },
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTypeSelection = widget.initialType == null && !_isEditMode;

    return AppDialog(
      title: _isEditMode 
          ? (_selectedType == 0 ? 'Sửa khoản thu' : 'Sửa khoản chi')
          : (_selectedType == 0 ? 'Thêm khoản thu' : 'Thêm khoản chi'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showTypeSelection) ...[
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<int>(
                      title: const Text('Thu'),
                      value: 0,
                      groupValue: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<int>(
                      title: const Text('Chi'),
                      value: 1,
                      groupValue: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            AppTextField(
              controller: _amountController,
              labelText: 'Số tiền (VND)',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập số tiền';
                }
                final parsedValue = CurrencyUtils.parseCurrency(value);
                if (parsedValue <= 0) {
                  return 'Số tiền phải lớn hơn 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _noteController,
              labelText: 'Ghi chú',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập ghi chú';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        AppTextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          label: 'Hủy',
        ),
        const SizedBox(width: 8),
        AppPrimaryButton(
          label: 'Lưu',
          isLoading: _isLoading,
          onPressed: _onSave,
        ),
      ],
    );
  }
}
