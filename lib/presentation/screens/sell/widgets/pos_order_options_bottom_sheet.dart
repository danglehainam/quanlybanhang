import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../../domain/entities/customer_entity.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';

import 'customer_selection_dialog.dart';
import 'table_selection_dialog.dart';
import 'discount_input_dialog.dart';
import 'note_input_dialog.dart';
import '../../../widgets/app_formatters.dart';

class PosOrderOptionsBottomSheet extends StatelessWidget {
  final OrderEntity activeOrder;

  const PosOrderOptionsBottomSheet({
    super.key,
    required this.activeOrder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Thông tin đơn hàng',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Khách hàng
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.primary),
              title: const Text('Khách hàng'),
              subtitle: Text(
                activeOrder.customer?.name ?? l10n.retailCustomer,
                style: TextStyle(
                  fontWeight: activeOrder.customer != null ? FontWeight.bold : FontWeight.normal,
                  color: activeOrder.customer != null ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final selectedCustomer = await showDialog<CustomerEntity?>(
                  context: context,
                  builder: (context) => const CustomerSelectionDialog(),
                );
                if (selectedCustomer != null && context.mounted) {
                  context.read<SellBloc>().add(SellEvent.updateCustomer(selectedCustomer));
                  Navigator.of(context).pop();
                }
              },
            ),
            const Divider(height: 1),
            // Bàn
            ListTile(
              leading: const Icon(Icons.table_restaurant, color: AppColors.primary),
              title: const Text('Bàn'),
              subtitle: Text(
                activeOrder.table?.name ?? l10n.selectTable,
                style: TextStyle(
                  fontWeight: activeOrder.table != null ? FontWeight.bold : FontWeight.normal,
                  color: activeOrder.table != null ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final selectedTable = await showDialog(
                  context: context,
                  builder: (context) => const TableSelectionDialog(),
                );
                if (selectedTable != null && context.mounted) {
                  context.read<SellBloc>().add(SellEvent.updateTable(selectedTable));
                  Navigator.of(context).pop();
                }
              },
            ),
            const Divider(height: 1),
            // Giảm giá
            ListTile(
              leading: const Icon(Icons.local_offer, color: AppColors.primary),
              title: const Text('Giảm giá'),
              subtitle: Text(
                activeOrder.discountPercent != null
                    ? '${activeOrder.discountPercent}% (${AppFormatters.formatCurrency(activeOrder.discount)})'
                    : (activeOrder.discount > 0 ? AppFormatters.formatCurrency(activeOrder.discount) : l10n.discount),
                style: TextStyle(
                  fontWeight: activeOrder.discount > 0 ? FontWeight.bold : FontWeight.normal,
                  color: activeOrder.discount > 0 ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final discountResult = await showDialog<({bool isPercentage, num value, int calculatedAmount})>(
                  context: context,
                  builder: (dialogContext) => DiscountInputDialog(
                    initialDiscount: activeOrder.discount,
                    totalAmount: activeOrder.totalAmount,
                  ),
                );
                if (discountResult != null && context.mounted) {
                  if (discountResult.isPercentage) {
                    context.read<SellBloc>().add(SellEvent.updateDiscount(
                        discountPercent: discountResult.value as double,
                        discountAmount: discountResult.calculatedAmount));
                  } else {
                    context.read<SellBloc>().add(SellEvent.updateDiscount(
                        discountPercent: null,
                        discountAmount: discountResult.calculatedAmount));
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
            const Divider(height: 1),
            // Ghi chú
            ListTile(
              leading: const Icon(Icons.edit_note, color: AppColors.primary),
              title: const Text('Ghi chú'),
              subtitle: Text(
                (activeOrder.note?.isNotEmpty ?? false) ? activeOrder.note! : l10n.note,
                style: TextStyle(
                  fontWeight: (activeOrder.note?.isNotEmpty ?? false) ? FontWeight.bold : FontWeight.normal,
                  color: (activeOrder.note?.isNotEmpty ?? false) ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<SellBloc>(),
                    child: NoteInputDialog(initialNote: activeOrder.note),
                  ),
                );
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
