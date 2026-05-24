import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/buttons/app_icon_button.dart';

class PosOrderItemRow extends StatelessWidget {
  final String productName;
  final int price;
  final int quantity;
  final int subtotal;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const PosOrderItemRow({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  AppFormatters.formatCurrency(price),
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
                onPressed: onDecrease,
              ),
              SizedBox(
                width: 28,
                child: Text(
                  '$quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              AppIconButton(
                icon: Icons.add_circle_outline,
                color: AppColors.primary,
                tooltip: 'Tăng',
                onPressed: onIncrease,
              ),
            ],
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: Text(
              AppFormatters.formatCurrency(subtotal),
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          AppIconButton(
            icon: Icons.close,
            color: Colors.red,
            tooltip: 'Xóa',
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
