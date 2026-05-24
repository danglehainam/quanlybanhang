import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../bloc/sell/sell_state.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/empty_data_widget.dart';
import '../widgets/pos_cart_summary.dart';
import '../widgets/pos_cart_tabs.dart';
import '../widgets/pos_order_item_row.dart';
import '../widgets/product_grouped_grid.dart';
import '../../products/widgets/product_filter_sidebar.dart';
import '../widgets/pos_order_options_bottom_sheet.dart';
import '../../../../domain/entities/order_entity.dart';

class SellMobileView extends StatelessWidget {
  const SellMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SellBloc, SellState>(
      builder: (context, state) {
        if (state.isLoading && state.allProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return Column(
          children: [
            // Top Search & Filter Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      labelText: l10n.searchProduct,
                      prefixIcon: Icons.search,
                      onChanged: (val) {
                        context.read<SellBloc>().add(SellEvent.filterProducts(
                          query: val,
                          categoryId: state.selectedCategoryId,
                          minPrice: state.minPrice,
                          maxPrice: state.maxPrice,
                          productStatus: state.productStatus,
                          sortOption: state.sortOption,
                        ));
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
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
            // Products Grid (Upper Half)
            Expanded(
              flex: 55, // 55% of available space for products
              child: state.filteredProducts.isEmpty
                  ? Center(
                      child: EmptyDataWidget(
                        icon: Icons.inventory_2_outlined,
                        message: l10n.emptyProductMessage,
                      ),
                    )
                  : ProductGroupedGrid(
                      products: state.filteredProducts,
                      categories: state.categories,
                      crossAxisCount: 4, // 4 columns for mobile (compact)
                      childAspectRatio: 1.0,
                    ),
            ),
            
            // Divider
            Container(
              height: 1,
              color: AppColors.divider,
            ),
            
            // Cart Section (Lower Half)
            Expanded(
              flex: 45, // 45% of available space for cart
              child: Container(
                color: Colors.white,
                child: _buildInlineCart(context, state, l10n),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInlineCart(BuildContext context, SellState state, AppLocalizations l10n) {
    if (state.draftOrders.isEmpty) {
      return Column(
        children: [
          PosCartTabs(
            orders: state.draftOrders,
            selectedIndex: state.selectedOrderIndex,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.emptyOrderMessage,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      context.read<SellBloc>().add(const SellEvent.addOrder());
                    },
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addOrder),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    
    final activeOrder = (state.draftOrders.isNotEmpty && state.selectedOrderIndex >= 0 && state.selectedOrderIndex < state.draftOrders.length)
        ? state.draftOrders[state.selectedOrderIndex]
        : null;

    return Column(
      children: [
        PosCartTabs(
          orders: state.draftOrders,
          selectedIndex: state.selectedOrderIndex,
          onActiveTabTapped: activeOrder != null ? () => _showOrderDetailsBottomSheet(context, activeOrder) : null,
        ),
        // Orders List
        Expanded(
          child: () {
            if (activeOrder == null) {
              return Center(child: Text(l10n.emptyOrderMessage));
            }
            if (activeOrder.items.isEmpty) {
              return Center(
                child: Text(
                  l10n.emptyOrderMessage,
                  style: const TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                ),
              );
            }
            
            return ListView.separated(
            padding: const EdgeInsets.only(bottom: 8),
              itemCount: activeOrder.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = activeOrder.items[index];
                return PosOrderItemRow(
                  productName: item.productName,
                  price: item.priceAtPurchase,
                  quantity: item.quantity,
                  subtotal: item.subtotal,
                  onIncrease: () => context.read<SellBloc>().add(SellEvent.updateItemQuantity(index, item.quantity + 1)),
                  onDecrease: () {
                    context.read<SellBloc>().add(SellEvent.updateItemQuantity(index, item.quantity - 1));
                  },
                  onRemove: () {
                    context.read<SellBloc>().add(SellEvent.removeItem(index));
                  },
                );
              },
            );
          }(),
        ),
        // Summary
        if (activeOrder != null) PosCartSummary(activeOrder: activeOrder),
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
          value: parentContext.read<SellBloc>(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BlocBuilder<SellBloc, SellState>(
                builder: (context, modalState) {
                  return ProductFilterSidebar(
                    showCloseButton: true,
                    showSearchField: false,
                    searchQuery: modalState.searchQuery,
                    selectedCategoryId: modalState.selectedCategoryId,
                    minPrice: modalState.minPrice,
                    maxPrice: modalState.maxPrice,
                    productStatus: modalState.productStatus,
                    sortOption: modalState.sortOption,
                    categories: modalState.categories,
                    onFilterChanged: ({categoryId, maxPrice, minPrice, productStatus, query, sortOption}) {
                      context.read<SellBloc>().add(SellEvent.filterProducts(
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
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOrderDetailsBottomSheet(BuildContext parentContext, OrderEntity activeOrder) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: parentContext.read<SellBloc>(),
          child: PosOrderOptionsBottomSheet(activeOrder: activeOrder),
        );
      },
    );
  }
}

