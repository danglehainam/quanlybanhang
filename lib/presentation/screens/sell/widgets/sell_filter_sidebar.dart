import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import '../../../bloc/sell/sell_state.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/filter_accordion_block.dart';

class SellFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final bool showSearchField;
  
  const SellFilterSidebar({
    super.key, 
    this.showCloseButton = false,
    this.showSearchField = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<SellBloc, SellState>(
      builder: (context, state) {
        return Container(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showCloseButton)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.filterAndSearch,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // Search Block
                    if (showSearchField)
                      FilterAccordionBlock(
                        title: 'Tìm kiếm',
                        child: AppTextField(
                          labelText: 'Tên sản phẩm...',
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

                    // Category Block
                    FilterAccordionBlock(
                      title: 'Danh mục',
                      child: Column(
                        children: [
                          ...state.categories.map((cat) => _buildRadioTile<int?>(
                            title: cat.name,
                            value: cat.id,
                            groupValue: state.selectedCategoryId,
                            onChanged: (val) {
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: val,
                                minPrice: state.minPrice,
                                maxPrice: state.maxPrice,
                                productStatus: state.productStatus,
                                sortOption: state.sortOption,
                              ));
                            },
                          )),
                        ],
                      ),
                    ),

                    // Price Range Block
                    FilterAccordionBlock(
                      title: 'Khoảng giá',
                      child: Column(
                        children: [
                          AppTextField(
                            labelText: 'Từ giá',
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              final min = int.tryParse(val);
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: min,
                                maxPrice: state.maxPrice,
                                productStatus: state.productStatus,
                                sortOption: state.sortOption,
                              ));
                            },
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            labelText: 'Đến giá',
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              final max = int.tryParse(val);
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: state.minPrice,
                                maxPrice: max,
                                productStatus: state.productStatus,
                                sortOption: state.sortOption,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),

                    // Status Block
                    FilterAccordionBlock(
                      title: 'Trạng thái',
                      child: Column(
                        children: [
                          _buildRadioTile<int?>(
                            title: 'Còn hàng',
                            value: 1,
                            groupValue: state.productStatus,
                            onChanged: (val) {
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: state.minPrice,
                                maxPrice: state.maxPrice,
                                productStatus: val,
                                sortOption: state.sortOption,
                              ));
                            },
                          ),
                          _buildRadioTile<int?>(
                            title: 'Hết hàng',
                            value: 0,
                            groupValue: state.productStatus,
                            onChanged: (val) {
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: state.minPrice,
                                maxPrice: state.maxPrice,
                                productStatus: val,
                                sortOption: state.sortOption,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),

                    // Sort Block
                    FilterAccordionBlock(
                      title: 'Sắp xếp',
                      child: Column(
                        children: [
                          _buildRadioTile<int?>(
                            title: 'Giá tăng dần',
                            value: 0,
                            groupValue: state.sortOption,
                            onChanged: (val) {
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: state.minPrice,
                                maxPrice: state.maxPrice,
                                productStatus: state.productStatus,
                                sortOption: val,
                              ));
                            },
                          ),
                          _buildRadioTile<int?>(
                            title: 'Giá giảm dần',
                            value: 1,
                            groupValue: state.sortOption,
                            onChanged: (val) {
                              context.read<SellBloc>().add(SellEvent.filterProducts(
                                query: state.searchQuery,
                                categoryId: state.selectedCategoryId,
                                minPrice: state.minPrice,
                                maxPrice: state.maxPrice,
                                productStatus: state.productStatus,
                                sortOption: val,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioTile<T>({
    required String title,
    required T value,
    required T groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return InkWell(
      onTap: () {
        if (value == groupValue) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Radio.adaptive(
              value: value,
              groupValue: groupValue,
              toggleable: true,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
