import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../widgets/app_form_modal.dart';
import '../widgets/product_form_dialog.dart';
import '../widgets/product_detail_dialog.dart';
import '../../../widgets/layout/two_column_desktop_layout.dart';
import '../../../widgets/buttons/app_icon_button.dart';
import '../widgets/product_filter_sidebar.dart';

class ProductsDesktopView extends StatelessWidget {
  final int storeId;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final String searchQuery;
  final int? selectedCategoryId;
  final int? sortOption;
  final int? minPrice;
  final int? maxPrice;
  final int? productStatus;

  const ProductsDesktopView({
    super.key,
    required this.storeId,
    required this.products,
    required this.categories,
    required this.searchQuery,
    this.selectedCategoryId,
    this.sortOption,
    this.minPrice,
    this.maxPrice,
    this.productStatus,
  });

  void _showProductDetail(BuildContext context, ProductEntity product, CategoryEntity? category, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ProductsBloc>()),
          BlocProvider.value(value: context.read<CategoriesBloc>()),
        ],
        child: ProductDetailDialog(
          product: product,
          category: category,
          onEdit: () {
            showAppFormModal(
              context: context,
              isMobileView: false,
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<ProductsBloc>()),
                  BlocProvider.value(value: context.read<CategoriesBloc>()),
                ],
                child: ProductFormDialog(productToEdit: product),
              ),
            );
          },
          onDelete: () {
            showAdaptiveDialog(
              context: context,
              builder: (_) => AppConfirmDialog(
                title: l10n.deleteProductConfirmTitle,
                content: l10n.deleteProductConfirmMessage,
                confirmLabel: l10n.delete,
                cancelLabel: l10n.cancel,
                isDestructive: true,
                onConfirm: () {
                  context.read<ProductsBloc>().add(
                    ProductsEvent.deleteProduct(
                      product.id,
                      onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.productDeletedSuccess)),
                        );
                      },
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error), backgroundColor: AppColors.error),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryMap = {for (var c in categories) c.id: c};

    return TwoColumnDesktopLayout(
      leftContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ProductFilterSidebar(
              searchQuery: searchQuery,
              selectedCategoryId: selectedCategoryId,
              minPrice: minPrice,
              maxPrice: maxPrice,
              productStatus: productStatus,
              sortOption: sortOption,
              categories: categories,
              onFilterChanged: ({categoryId, maxPrice, minPrice, productStatus, query, sortOption}) {
                context.read<ProductsBloc>().add(ProductsEvent.watchProducts(
                  storeId: storeId,
                  query: query,
                  categoryId: categoryId,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                  productStatus: productStatus,
                  sortOption: sortOption,
                ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AppPrimaryButton(
              label: l10n.addProduct,
              onPressed: () {
                showAppFormModal(
                  context: context,
                  isMobileView: false,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<ProductsBloc>()),
                      BlocProvider.value(value: context.read<CategoriesBloc>()),
                    ],
                    child: const ProductFormDialog(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      rightContent: products.isEmpty
          ? EmptyDataWidget(message: l10n.emptyProductMessage)
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(label: Text(l10n.productImage)),
                        DataColumn(label: Text(l10n.productName)),
                        DataColumn(label: Text(l10n.price)),
                        DataColumn(label: Text(l10n.status)),
                        DataColumn(label: Text(l10n.actionsLabel)),
                      ],
                      rows: products.map((product) {
                        final category = product.categoryId != null ? categoryMap[product.categoryId] : null;

                        return DataRow(
                          cells: [
                            DataCell(
                              product.imageUrl != null && product.imageUrl!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: product.imageUrl!.startsWith('http')
                                          ? Image.network(
                                              product.imageUrl!,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.image_not_supported, size: 40, color: AppColors.textSecondary),
                                            )
                                          : Image.file(
                                              File(product.imageUrl!),
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.image_not_supported, size: 40, color: AppColors.textSecondary),
                                            ),
                                    )
                                  : Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Icon(Icons.image, color: AppColors.textSecondary),
                                    ),
                              onTap: () => _showProductDetail(context, product, category, l10n),
                            ),
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(category?.name ?? l10n.unassignedCategory, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                ],
                              ),
                              onTap: () => _showProductDetail(context, product, category, l10n),
                            ),
                            DataCell(
                              Text(CurrencyUtils.formatCurrency(product.price)),
                              onTap: () => _showProductDetail(context, product, category, l10n),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: product.status == 1 ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product.status == 1 ? l10n.inStock : l10n.outOfStock,
                                  style: TextStyle(
                                    color: product.status == 1 ? AppColors.success : AppColors.error,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onTap: () => _showProductDetail(context, product, category, l10n),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppIconButton(
                                    icon: Icons.edit,
                                    color: AppColors.primary,
                                    tooltip: l10n.editProduct,
                                    onPressed: () {
                                      showAppFormModal(
                                        context: context,
                                        isMobileView: false,
                                        builder: (_) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider.value(value: context.read<ProductsBloc>()),
                                            BlocProvider.value(value: context.read<CategoriesBloc>()),
                                          ],
                                          child: ProductFormDialog(productToEdit: product),
                                        ),
                                      );
                                    },
                                  ),
                                  AppIconButton(
                                    icon: Icons.delete,
                                    color: AppColors.error,
                                    tooltip: l10n.delete,
                                    onPressed: () {
                                      showAdaptiveDialog(
                                        context: context,
                                        builder: (_) => AppConfirmDialog(
                                          title: l10n.deleteProductConfirmTitle,
                                          content: l10n.deleteProductConfirmMessage,
                                          confirmLabel: l10n.delete,
                                          cancelLabel: l10n.cancel,
                                          isDestructive: true,
                                          onConfirm: () {
                                            context.read<ProductsBloc>().add(
                                              ProductsEvent.deleteProduct(
                                                product.id,
                                                onSuccess: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text(l10n.productDeletedSuccess)),
                                                  );
                                                },
                                                onError: (error) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text(error), backgroundColor: AppColors.error),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
