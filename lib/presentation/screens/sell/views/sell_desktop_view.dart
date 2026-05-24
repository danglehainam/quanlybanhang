import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../bloc/sell/sell_state.dart';
import '../../../widgets/buttons/app_icon_button.dart';
import '../../../widgets/empty_data_widget.dart';
import '../widgets/pos_order_card.dart';
import '../widgets/product_grouped_grid.dart';
import '../../products/widgets/product_filter_sidebar.dart';

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
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.draftOrders,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                AppIconButton(
                  icon: Icons.add,
                  tooltip: l10n.addOrder,
                  color: AppColors.primary,
                  onPressed: () {
                    context.read<SellBloc>().add(const SellEvent.addOrder());
                  },
                )
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: state.draftOrders.isEmpty
                ? Center(
                    child: Text(
                      'Chưa có đơn hàng nào.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.draftOrders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = state.draftOrders[index];
                      final isExpanded = index == state.selectedOrderIndex;
                      
                      return PosOrderCard(
                        order: order,
                        orderIndex: index,
                        isExpanded: isExpanded,
                        onExpand: () {
                          context.read<SellBloc>().add(SellEvent.selectOrder(index));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

