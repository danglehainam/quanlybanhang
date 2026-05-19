import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../widgets/product_mobile_item.dart';
import '../widgets/product_form_dialog.dart';

class ProductsMobileView extends StatelessWidget {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  const ProductsMobileView({
    super.key,
    required this.products,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryMap = {for (var c in categories) c.id: c};

    return Column(
      children: [
        // Top Filter Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).cardColor,
          child: TextField(
            decoration: InputDecoration(
              hintText: l10n.searchProduct,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Products List
        Expanded(
          child: Container(
            color: Theme.of(context).cardColor,
            child: products.isEmpty
                ? EmptyDataWidget(message: l10n.emptyProductMessage)
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final category = product.categoryId != null ? categoryMap[product.categoryId] : null;

                      return ProductMobileItem(
                        product: product,
                        category: category,
                        onEdit: () {
                          showDialog(
                            context: context,
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
                          showDialog(
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
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
