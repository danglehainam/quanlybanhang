import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/category_entity.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../widgets/buttons/app_icon_button.dart';

class ProductDesktopItem extends StatelessWidget {
  final ProductEntity product;
  final CategoryEntity? category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductDesktopItem({
    super.key,
    required this.product,
    this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${currencyFormatter.format(product.price)} - ${category?.name ?? l10n.unassignedCategory}${product.stock != null ? ' - Tồn: ${product.stock}' : ' - Chế biến'}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: product.status == 1 ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              product.status == 1 ? 'Còn hàng' : 'Hết hàng',
              style: TextStyle(
                color: product.status == 1 ? Colors.green : Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          AppIconButton(
            icon: Icons.edit,
            color: AppColors.primary,
            tooltip: l10n.editProduct,
            onPressed: onEdit,
          ),
          AppIconButton(
            icon: Icons.delete,
            color: AppColors.error,
            tooltip: l10n.delete,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
