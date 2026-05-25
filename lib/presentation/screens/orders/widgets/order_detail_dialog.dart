import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/buttons/app_filled_button.dart';
import '../../../widgets/buttons/app_text_button.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';

class OrderDetailDialog extends StatefulWidget {
  final OrderEntity order;

  const OrderDetailDialog({super.key, required this.order});

  @override
  State<OrderDetailDialog> createState() => _OrderDetailDialogState();
}

class _OrderDetailDialogState extends State<OrderDetailDialog> {
  bool _isLoading = false;

  void _confirmCancel(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: l10n.confirmCancelOrderTitle,
        content: l10n.confirmCancelOrderMessage,
        confirmLabel: l10n.cancelOrder,
        cancelLabel: l10n.back,
        isDestructive: true,
        onConfirm: () => _updateStatus(2),
      ),
    );
  }

  void _confirmPay(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: l10n.confirmPayTitle,
        content: l10n.confirmPayMessage,
        confirmLabel: l10n.pay,
        cancelLabel: l10n.back,
        isDestructive: false,
        onConfirm: () => _updateStatus(1),
      ),
    );
  }

  void _updateStatus(int newStatus) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<OrdersBloc>();

    setState(() {
      _isLoading = true;
    });

    bloc.add(
      OrdersEvent.updateOrderStatus(
        widget.order,
        newStatus,
        onSuccess: () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  newStatus == 1
                      ? l10n.orderStatusCompletedSuccess
                      : l10n.orderStatusCancelledSuccess,
                ),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.of(context).pop(); // Close the OrderDetailDialog
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, AppLocalizations l10n) {
    final status = widget.order.status;
    final List<Widget> buttons = [];

    // Back button is always present
    buttons.add(
      AppTextButton(
        label: l10n.back,
        onPressed: () => Navigator.pop(context),
      ),
    );

    if (status == 0) {
      // Pending: Back, Cancel, Pay
      buttons.add(const SizedBox(width: 8));
      buttons.add(
        AppFilledButton(
          label: l10n.cancelOrder,
          backgroundColor: AppColors.error,
          onPressed: () => _confirmCancel(l10n),
        ),
      );
      buttons.add(const SizedBox(width: 8));
      buttons.add(
        AppFilledButton(
          label: l10n.pay,
          backgroundColor: AppColors.success,
          onPressed: () => _confirmPay(l10n),
        ),
      );
    } else if (status == 1) {
      // Completed: Back, Cancel
      buttons.add(const SizedBox(width: 8));
      buttons.add(
        AppFilledButton(
          label: l10n.cancelOrder,
          backgroundColor: AppColors.error,
          onPressed: () => _confirmCancel(l10n),
        ),
      );
    }

    return buttons;
  }

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
                  l10n.orderDetailTitle(widget.order.id),
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
            _buildInfoRow(l10n.orderDate, AppFormatters.formatDateTime(widget.order.createdAt)),
            _buildInfoRow(l10n.customerLabel, widget.order.customer?.name ?? l10n.retailCustomer),
            if (widget.order.customer?.phone != null)
              _buildInfoRow(l10n.phoneLabel, widget.order.customer!.phone),
            _buildInfoRow(l10n.tableLabel, widget.order.table?.name ?? '-'),
            _buildStatusRow(l10n.statusLabel, widget.order.status, l10n),
            if (widget.order.note != null && widget.order.note!.isNotEmpty)
              _buildInfoRow(l10n.noteLabel, widget.order.note!),

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
                  itemCount: widget.order.items.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = widget.order.items[index];
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
            _buildSummaryRow('${l10n.totalAmount}:', AppFormatters.formatCurrency(widget.order.totalAmount)),
            if (widget.order.discount > 0)
              _buildSummaryRow(
                '${l10n.discount}:',
                '-${AppFormatters.formatCurrency(widget.order.discount)}',
                color: AppColors.success,
              ),
            const Divider(),
            _buildSummaryRow(
              '${l10n.finalAmount}:',
              AppFormatters.formatCurrency(widget.order.finalAmount),
              isBold: true,
              fontSize: 16,
              color: AppColors.primary,
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // Action Buttons
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  ),
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildActions(context, l10n),
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
