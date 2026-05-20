import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../bloc/sell/sell_state.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/empty_data_widget.dart';
import '../widgets/pos_product_item.dart';
import '../widgets/pos_order_card.dart';

class SellMobileView extends StatelessWidget {
  const SellMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SellBloc, SellState>(
      builder: (context, state) {
        if (state.isLoading && state.allProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            Column(
              children: [
                // Top Search & Filter Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      AppTextField(
                        labelText: l10n.searchProduct,
                        prefixIcon: Icons.search,
                        onChanged: (val) {
                          context.read<SellBloc>().add(SellEvent.filterProducts(val, state.selectedCategoryId));
                        },
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _FilterChip(
                              label: 'Tất cả',
                              isSelected: state.selectedCategoryId == null || state.selectedCategoryId == 0,
                              onTap: () {
                                context.read<SellBloc>().add(SellEvent.filterProducts(state.searchQuery, 0));
                              },
                            ),
                            ...state.categories.map((cat) => _FilterChip(
                                  label: cat.name,
                                  isSelected: state.selectedCategoryId == cat.id,
                                  onTap: () {
                                    context.read<SellBloc>().add(SellEvent.filterProducts(state.searchQuery, cat.id));
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Products Grid
                Expanded(
                  child: state.filteredProducts.isEmpty
                      ? Center(
                          child: EmptyDataWidget(
                            icon: Icons.inventory_2_outlined,
                            message: l10n.emptyProductMessage,
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16).copyWith(bottom: 100), // padding for bottom bar
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 columns for mobile
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: state.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = state.filteredProducts[index];
                            return PosProductItem(
                              product: product,
                              onTap: () {
                                context.read<SellBloc>().add(SellEvent.addProductToOrder(product));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Đã thêm ${product.name}'),
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
            
            // Bottom Cart Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomCartBar(context, state, l10n),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomCartBar(BuildContext context, SellState state, AppLocalizations l10n) {
    if (state.draftOrders.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.emptyOrderMessage,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
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
      );
    }
    
    final currentOrder = state.draftOrders[state.selectedOrderIndex];
    final int totalItems = currentOrder.items.fold(0, (sum, item) => sum + item.quantity);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Đơn #${state.selectedOrderIndex + 1} ($totalItems món)',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  ),
                  Text(
                    AppFormatters.formatCurrency(currentOrder.finalAmount),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                _showCartBottomSheet(context, state, l10n);
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text(l10n.cart),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCartBottomSheet(BuildContext parentContext, SellState state, AppLocalizations l10n) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: parentContext.read<SellBloc>(),
          child: BlocBuilder<SellBloc, SellState>(
            builder: (context, modalState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.draftOrders,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  context.read<SellBloc>().add(const SellEvent.addOrder());
                                },
                                icon: const Icon(Icons.add),
                                label: Text(l10n.addOrder),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Orders List
                    Expanded(
                      child: modalState.draftOrders.isEmpty
                          ? Center(child: Text(l10n.emptyOrderMessage))
                          : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: modalState.draftOrders.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final order = modalState.draftOrders[index];
                                final isExpanded = index == modalState.selectedOrderIndex;
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
            },
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primaryLight.withAlpha(50),
        checkmarkColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
