import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';

import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_outlined_button.dart';

import 'pos_order_card_header.dart';
import 'pos_order_item_row.dart';

class PosOrderCard extends StatelessWidget {
  final OrderEntity order;
  final int orderIndex;
  final bool isExpanded;
  final VoidCallback onExpand;

  const PosOrderCard({
    super.key,
    required this.order,
    required this.orderIndex,
    required this.isExpanded,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orderName = 'Đơn #${orderIndex + 1}';

    return Card(
      margin: EdgeInsets.zero,
      elevation: isExpanded ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isExpanded ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header (Click to expand)
          PosOrderCardHeader(
            orderName: orderName,
            itemCount: order.items.length,
            totalAmount: order.finalAmount,
            isExpanded: isExpanded,
            onExpand: onExpand,
            onRemove: () => context.read<SellBloc>().add(SellEvent.removeOrder(orderIndex)),
          ),

          // Expanded Content
          if (isExpanded) ...[
            const Divider(height: 1),
            if (order.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  l10n.emptyOrderMessage,
                  style: const TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items.length,
                itemBuilder: (context, idx) {
                  final item = order.items[idx];
                  return PosOrderItemRow(
                    productName: item.productName,
                    price: item.priceAtPurchase,
                    quantity: item.quantity,
                    subtotal: item.subtotal,
                    onIncrease: () => context.read<SellBloc>().add(SellEvent.updateItemQuantity(idx, item.quantity + 1)),
                    onDecrease: () => context.read<SellBloc>().add(SellEvent.updateItemQuantity(idx, item.quantity - 1)),
                  );
                },
              ),
            const Divider(height: 1),
            // Actions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      label: l10n.confirmOrder,
                      onPressed: order.items.isEmpty ? null : () => context.read<SellBloc>().add(const SellEvent.confirmOrder()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppPrimaryButton(
                      label: l10n.completeOrder,
                      onPressed: order.items.isEmpty ? null : () => context.read<SellBloc>().add(const SellEvent.completeOrder()),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
