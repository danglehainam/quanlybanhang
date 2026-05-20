import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/buttons/app_icon_button.dart';

class PosOrderCardHeader extends StatelessWidget {
  final String orderName;
  final int itemCount;
  final int totalAmount;
  final bool isExpanded;
  final VoidCallback onExpand;
  final VoidCallback? onRemove;

  const PosOrderCardHeader({
    super.key,
    required this.orderName,
    required this.itemCount,
    required this.totalAmount,
    required this.isExpanded,
    required this.onExpand,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onExpand,
      borderRadius: BorderRadius.vertical(
        top: const Radius.circular(12),
        bottom: isExpanded ? Radius.zero : const Radius.circular(12),
      ),
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
                    '$itemCount món',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),
            Text(
              AppFormatters.formatCurrency(totalAmount),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            if (isExpanded && onRemove != null) ...[
              const SizedBox(width: 8),
              AppIconButton(
                icon: Icons.close,
                color: AppColors.error,
                tooltip: 'Xoá đơn',
                onPressed: onRemove!,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
