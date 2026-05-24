import 'package:flutter/material.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/filter_accordion_block.dart';
import '../../../widgets/app_filter_sidebar.dart';
import '../../../widgets/app_filter_radio_tile.dart';

class ProductFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final bool showSearchField;
  
  final String searchQuery;
  final int? selectedCategoryId;
  final int? minPrice;
  final int? maxPrice;
  final int? productStatus;
  final int? sortOption;
  final List<CategoryEntity> categories;

  final void Function({
    String? query,
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? productStatus,
    int? sortOption,
  }) onFilterChanged;

  const ProductFilterSidebar({
    super.key, 
    this.showCloseButton = false,
    this.showSearchField = true,
    required this.searchQuery,
    required this.selectedCategoryId,
    required this.minPrice,
    required this.maxPrice,
    required this.productStatus,
    required this.sortOption,
    required this.categories,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppFilterSidebar(
      showCloseButton: showCloseButton,
      children: [
                // Search Block
                if (showSearchField)
                  FilterAccordionBlock(
                    title: 'Tìm kiếm',
                    child: AppTextField(
                      labelText: 'Tên sản phẩm...',
                      prefixIcon: Icons.search,
                      controller: TextEditingController(text: searchQuery)..selection = TextSelection.fromPosition(TextPosition(offset: searchQuery.length)),
                      onChanged: (val) {
                        onFilterChanged(
                          query: val,
                          categoryId: selectedCategoryId,
                          minPrice: minPrice,
                          maxPrice: maxPrice,
                          productStatus: productStatus,
                          sortOption: sortOption,
                        );
                      },
                    ),
                  ),

                // Category Block
                FilterAccordionBlock(
                  title: 'Danh mục',
                  child: Column(
                    children: [
                      // "All categories" option
                      AppFilterRadioTile<int?>(
                        title: 'Tất cả',
                        value: null,
                        groupValue: selectedCategoryId,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: val,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: sortOption,
                          );
                        },
                      ),
                      ...categories.map((cat) => AppFilterRadioTile<int?>(
                        title: cat.name,
                        value: cat.id,
                        groupValue: selectedCategoryId,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: val,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: sortOption,
                          );
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
                        controller: TextEditingController(text: minPrice?.toString() ?? '')..selection = TextSelection.fromPosition(TextPosition(offset: (minPrice?.toString() ?? '').length)),
                        onChanged: (val) {
                          final min = int.tryParse(val);
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: min,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: sortOption,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        labelText: 'Đến giá',
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: maxPrice?.toString() ?? '')..selection = TextSelection.fromPosition(TextPosition(offset: (maxPrice?.toString() ?? '').length)),
                        onChanged: (val) {
                          final max = int.tryParse(val);
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: max,
                            productStatus: productStatus,
                            sortOption: sortOption,
                          );
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
                      AppFilterRadioTile<int?>(
                        title: 'Tất cả',
                        value: null,
                        groupValue: productStatus,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: val,
                            sortOption: sortOption,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Còn hàng',
                        value: 1,
                        groupValue: productStatus,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: val,
                            sortOption: sortOption,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Hết hàng',
                        value: 0,
                        groupValue: productStatus,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: val,
                            sortOption: sortOption,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Sort Block
                FilterAccordionBlock(
                  title: 'Sắp xếp theo',
                  child: Column(
                    children: [
                      AppFilterRadioTile<int?>(
                        title: 'Mặc định',
                        value: null,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Tên: A - Z',
                        value: 0,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Tên: Z - A',
                        value: 1,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Giá tăng dần',
                        value: 2,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Giá giảm dần',
                        value: 3,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                      AppFilterRadioTile<int?>(
                        title: 'Mới nhất',
                        value: 4,
                        groupValue: sortOption,
                        onChanged: (val) {
                          onFilterChanged(
                            query: searchQuery,
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            productStatus: productStatus,
                            sortOption: val,
                          );
                        },
                      ),
                    ],
                  ),
                ),
      ],
    );
  }
}
