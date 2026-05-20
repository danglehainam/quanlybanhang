import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_icon_button.dart';

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
    
    // Fallback for L10n args if not perfectly matched
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
          InkWell(
            onTap: onExpand,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isExpanded ? FontWeight.bold : FontWeight.w600,
                            color: isExpanded ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.items.length} món',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppFormatters.formatCurrency(order.finalAmount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  if (isExpanded) ...[
                    const SizedBox(width: 8),
                    AppIconButton(
                      icon: Icons.close,
                      color: AppColors.error,
                      tooltip: 'Xoá đơn',
                      onPressed: () {
                        context.read<SellBloc>().add(SellEvent.removeOrder(orderIndex));
                      },
                    ),
                  ]
                ],
              ),
            ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w500)),
                              Text(
                                AppFormatters.formatCurrency(item.priceAtPurchase),
                                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        // Quantity controls
                        Row(
                          children: [
                            AppIconButton(
                              icon: Icons.remove_circle_outline,
                              color: AppColors.textSecondary,
                              tooltip: 'Giảm',
                              onPressed: () {
                                context.read<SellBloc>().add(SellEvent.updateItemQuantity(idx, item.quantity - 1));
                              },
                            ),
                            SizedBox(
                              width: 30,
                              child: Text(
                                '${item.quantity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            AppIconButton(
                              icon: Icons.add_circle_outline,
                              color: AppColors.primary,
                              tooltip: 'Tăng',
                              onPressed: () {
                                context.read<SellBloc>().add(SellEvent.updateItemQuantity(idx, item.quantity + 1));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 80,
                          child: Text(
                            AppFormatters.formatCurrency(item.subtotal),
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
                    child: OutlinedButton(
                      onPressed: order.items.isEmpty
                          ? null
                          : () {
                              context.read<SellBloc>().add(const SellEvent.confirmOrder());
                            },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(l10n.confirmOrder),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppPrimaryButton(
                      label: l10n.completeOrder,
                      onPressed: order.items.isEmpty
                          ? null
                          : () {
                              context.read<SellBloc>().add(const SellEvent.completeOrder());
                            },
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
