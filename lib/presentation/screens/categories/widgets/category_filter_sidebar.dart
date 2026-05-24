import 'package:flutter/material.dart';

import '../../../widgets/app_filter_sidebar.dart';
import '../../../widgets/app_filter_radio_tile.dart';
import '../../../widgets/filter_accordion_block.dart';
import '../../../widgets/app_text_field.dart';

class CategoryFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final bool showSearchField;
  
  final TextEditingController searchController;
  final int? sortOption;

  final void Function({
    int? sortOption,
  }) onFilterChanged;

  const CategoryFilterSidebar({
    super.key, 
    this.showCloseButton = false,
    this.showSearchField = true,
    required this.searchController,
    required this.sortOption,
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
              labelText: 'Tên danh mục...',
              prefixIcon: Icons.search,
              controller: searchController,
              onChanged: (val) {
                // If we need to trigger immediate search, we can add logic here.
              },
            ),
          ),

        // Sort Block
        FilterAccordionBlock(
          title: 'Sắp xếp theo',
          child: Column(
            children: [
              AppFilterRadioTile<int?>(
                title: 'Mới nhất',
                value: null,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: 'Cũ nhất',
                value: 1,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: 'Tên: A - Z',
                value: 2,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: 'Tên: Z - A',
                value: 3,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
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
