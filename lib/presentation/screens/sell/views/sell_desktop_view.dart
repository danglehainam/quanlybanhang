import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../bloc/sell/sell_state.dart';
import '../../../widgets/empty_data_widget.dart';
import '../widgets/pos_cart_summary.dart';
import '../widgets/pos_cart_tabs.dart';
import '../widgets/pos_order_item_row.dart';
import '../widgets/product_grouped_grid.dart';
import '../../products/widgets/product_filter_sidebar.dart';
import '../widgets/pos_desktop_order_header.dart';

class SellDesktopView extends StatelessWidget {
  const SellDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SellBloc, SellState>(
      builder: (context, state) {
        if (state.isLoading && state.allProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: 1 flex (Filters)
            Expanded(
              flex: 1,
              child: _buildLeftColumn(context, state, l10n),
            ),
            
            const VerticalDivider(width: 1),

            // Middle Column: 2 flex (Products)
            Expanded(
              flex: 2,
              child: _buildMiddleColumn(context, state, l10n),
            ),
            
            const VerticalDivider(width: 1),

            // Right Column: 1 flex (Orders)
            Expanded(
              flex: 1,
              child: _buildRightColumn(context, state, l10n),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLeftColumn(BuildContext context, SellState state, AppLocalizations l10n) {
    return ProductFilterSidebar(
      searchQuery: state.searchQuery,
      selectedCategoryId: state.selectedCategoryId,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      productStatus: state.productStatus,
      sortOption: state.sortOption,
      categories: state.categories,
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
  }

  Widget _buildMiddleColumn(BuildContext context, SellState state, AppLocalizations l10n) {
    if (state.filteredProducts.isEmpty) {
      return Center(
        child: EmptyDataWidget(
          icon: Icons.inventory_2_outlined,
          message: l10n.emptyProductMessage,
        ),
      );
    }

    return Container(
      color: AppColors.background,
      child: ProductGroupedGrid(
        products: state.filteredProducts,
        categories: state.categories,
        crossAxisCount: 6,
        childAspectRatio: 0.85,
        bottomPadding: 16,
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context, SellState state, AppLocalizations l10n) {
    final activeOrder = (state.draftOrders.isNotEmpty && state.selectedOrderIndex >= 0 && state.selectedOrderIndex < state.draftOrders.length)
        ? state.draftOrders[state.selectedOrderIndex]
        : null;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PosCartTabs(
            orders: state.draftOrders,
            selectedIndex: state.selectedOrderIndex,
          ),
          if (activeOrder != null)
            PosDesktopOrderHeader(activeOrder: activeOrder),
          Expanded(
            child: activeOrder == null
                ? Center(
                    child: Text(
                      'Chưa có đơn hàng nào.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : activeOrder.items.isEmpty
                    ? Center(
                        child: Text(
                          l10n.emptyOrderMessage,
                          style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                        ),
                      )
                    : ListView.separated(
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
                      ),
          ),
          if (activeOrder != null) PosCartSummary(activeOrder: activeOrder),
        ],
      ),
    );
  }
}

