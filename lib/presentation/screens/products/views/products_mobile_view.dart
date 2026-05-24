import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/products/products_state.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../widgets/product_mobile_item.dart';
import '../../../widgets/app_form_modal.dart';
import '../widgets/product_form_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../widgets/product_filter_sidebar.dart';

class ProductsMobileView extends StatelessWidget {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final String searchQuery;
  final int? selectedCategoryId;
  final int? sortOption;
  final int? minPrice;
  final int? maxPrice;
  final int? productStatus;

  const ProductsMobileView({
    super.key,
    required this.products,
    required this.categories,
    required this.searchQuery,
    this.selectedCategoryId,
    this.sortOption,
    this.minPrice,
    this.maxPrice,
    this.productStatus,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryMap = {for (var c in categories) c.id: c};

    return Column(
      children: [
        // Top Filter Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  labelText: l10n.searchProduct,
                  prefixIcon: Icons.search,
                  controller: TextEditingController(text: searchQuery)..selection = TextSelection.fromPosition(TextPosition(offset: searchQuery.length)),
                  onChanged: (val) {
                    context.read<ProductsBloc>().add(ProductsEvent.watchProducts(
                      query: val,
                      categoryId: selectedCategoryId,
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                      productStatus: productStatus,
                      sortOption: sortOption,
                    ));
                  },
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterBottomSheet(context),
                ),
              ),
            ],
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
                          showAppFormModal(
                            context: context,
                            isMobileView: true,
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
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: parentContext.read<ProductsBloc>(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, modalState) {
                  return modalState.maybeWhen(
                    loaded: (allProducts, filteredProducts, searchQuery, selectedCategoryId, sortOption, minPrice, maxPrice, productStatus) {
                      return ProductFilterSidebar(
                        showCloseButton: true,
                        showSearchField: false,
                        searchQuery: searchQuery,
                        selectedCategoryId: selectedCategoryId,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        productStatus: productStatus,
                        sortOption: sortOption,
                        categories: categories,
                        onFilterChanged: ({categoryId, maxPrice, minPrice, productStatus, query, sortOption}) {
                          context.read<ProductsBloc>().add(ProductsEvent.watchProducts(
                            query: query,
                            categoryId: categoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: sortOption,
                          ));
                        },
                      );
                    },
                    orElse: () => const Center(child: CircularProgressIndicator.adaptive()),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
