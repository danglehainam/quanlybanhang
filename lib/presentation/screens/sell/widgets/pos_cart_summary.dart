import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';

import '../../../widgets/app_formatters.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_outlined_button.dart';

class PosCartSummary extends StatelessWidget {
  final OrderEntity? activeOrder;

  const PosCartSummary({
    super.key,
    required this.activeOrder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (activeOrder == null) {
      return const SizedBox.shrink();
    }

    final hasItems = activeOrder!.items.isNotEmpty;

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.divider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary Rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.totalAmount, style: const TextStyle(color: AppColors.textSecondary)),
                Text(AppFormatters.formatCurrency(activeOrder!.totalAmount), style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.discount, style: const TextStyle(color: AppColors.textSecondary)),
                Text('-${AppFormatters.formatCurrency(activeOrder!.discount)}', style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.success)),
              ],
            ),
            const SizedBox(height: 4),
            const Divider(),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.finalAmount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  AppFormatters.formatCurrency(activeOrder!.finalAmount),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: AppOutlinedButton(
                      label: l10n.confirmOrder,
                      onPressed: hasItems ? () => context.read<SellBloc>().add(const SellEvent.confirmOrder()) : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: AppPrimaryButton(
                      label: l10n.completeOrder,
                      onPressed: hasItems ? () => context.read<SellBloc>().add(const SellEvent.completeOrder()) : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
