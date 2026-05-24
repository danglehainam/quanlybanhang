import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../widgets/app_formatters.dart';

class OrderDetailDialog extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.orderDetailTitle(order.id),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            // Metadata info
            _buildInfoRow(l10n.orderDate, AppFormatters.formatDateTime(order.createdAt)),
            _buildInfoRow(l10n.customerLabel, order.customer?.name ?? l10n.retailCustomer),
            if (order.customer?.phone != null)
              _buildInfoRow(l10n.phoneLabel, order.customer!.phone),
            _buildInfoRow(l10n.tableLabel, order.table?.name ?? '-'),
            _buildStatusRow(l10n.statusLabel, order.status, l10n),
            if (order.note != null && order.note!.isNotEmpty)
              _buildInfoRow(l10n.noteLabel, order.note!),

            const SizedBox(height: 16),
            Text(
              l10n.orderDetailProducts,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Order items list
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 250),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: order.items.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(
                                  item.productName,
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                                ),
                                Text(
                                  '${AppFormatters.formatCurrency(item.priceAtPurchase)} x ${item.quantity}',
                                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            AppFormatters.formatCurrency(item.subtotal),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Summary Info
            _buildSummaryRow('${l10n.totalAmount}:', AppFormatters.formatCurrency(order.totalAmount)),
            if (order.discount > 0)
              _buildSummaryRow(
                '${l10n.discount}:',
                '-${AppFormatters.formatCurrency(order.discount)}',
                color: AppColors.success,
              ),
            const Divider(),
            _buildSummaryRow(
              '${l10n.finalAmount}:',
              AppFormatters.formatCurrency(order.finalAmount),
              isBold: true,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int status, AppLocalizations l10n) {
    String text = l10n.orderStatusPending;
    Color color = AppColors.warning;
    if (status == 1) {
      text = l10n.orderStatusCompleted;
      color = AppColors.success;
    } else if (status == 2) {
      text = l10n.orderStatusCancelled;
      color = AppColors.error;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(26), // 10% opacity
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color, width: 0.5),
            ),
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 13,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
              color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: fontSize,
              color: color ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
