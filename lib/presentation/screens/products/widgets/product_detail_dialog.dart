import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/buttons/app_text_button.dart';

class ProductDetailDialog extends StatelessWidget {
  final ProductEntity product;
  final CategoryEntity? category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductDetailDialog({
    super.key,
    required this.product,
    this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final isIncome = product.status == 1;

    return AppDialog(
      title: l10n.productDetailTitle,
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header with image, name & price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image card
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.divider),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: product.imageUrl!.startsWith('http')
                                ? Image.network(
                                    product.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image_not_supported, size: 40, color: AppColors.textSecondary),
                                  )
                                : Image.file(
                                    File(product.imageUrl!),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image_not_supported, size: 40, color: AppColors.textSecondary),
                                  ),
                          )
                        : const Icon(Icons.image, size: 40, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 16),
                  // Name, Category & Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category?.name ?? l10n.unassignedCategory,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          CurrencyUtils.formatCurrency(product.price),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 12),

              // 2. Info Grid
              _buildInfoRow(
                l10n.status,
                product.status == 1 ? l10n.inStock : l10n.outOfStock,
                customValueWidget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isIncome
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isIncome ? l10n.inStock : l10n.outOfStock,
                    style: TextStyle(
                      color: isIncome ? AppColors.success : AppColors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildInfoRow(
                l10n.quantityLabel,
                product.stock != null ? l10n.stockLabel(product.stock!) : l10n.madeToOrder,
              ),
              _buildInfoRow(
                l10n.dateCreated,
                dateFormat.format(product.createdAt.toLocal()),
              ),
              _buildInfoRow(
                l10n.dateUpdated,
                dateFormat.format(product.updatedAt.toLocal()),
              ),

              const SizedBox(height: 12),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 16),

              // 3. Description Block
              Text(
                l10n.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text(
                  product.description != null && product.description!.trim().isNotEmpty
                      ? product.description!
                      : l10n.noDescription,
                  style: TextStyle(
                    fontSize: 13,
                    color: product.description != null && product.description!.trim().isNotEmpty
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        AppTextButton(
          label: l10n.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 8),
        AppTextButton(
          label: l10n.delete,
          textColor: AppColors.error,
          onPressed: () {
            Navigator.of(context).pop();
            onDelete();
          },
        ),
        const SizedBox(width: 8),
        AppPrimaryButton(
          label: l10n.edit,
          onPressed: () {
            Navigator.of(context).pop();
            onEdit();
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Widget? customValueWidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          customValueWidget ??
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
        ],
      ),
    );
  }
}
