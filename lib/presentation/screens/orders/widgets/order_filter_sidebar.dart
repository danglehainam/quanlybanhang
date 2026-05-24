import 'package:flutter/material.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/filter_accordion_block.dart';
import '../../../widgets/app_filter_sidebar.dart';
import '../../../widgets/app_filter_radio_tile.dart';

class OrderFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final bool showSearchField;
  
  final String searchQuery;
  final int? statusFilter;
  final int? sortOption;

  final void Function({
    String? query,
    int? statusFilter,
    int? sortOption,
  }) onFilterChanged;

  const OrderFilterSidebar({
    super.key, 
    this.showCloseButton = false,
    this.showSearchField = true,
    required this.searchQuery,
    required this.statusFilter,
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
              labelText: 'Nhập SĐT, Tên bàn, ID...',
              prefixIcon: Icons.search,
              controller: TextEditingController(text: searchQuery)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: searchQuery.length),
                ),
              onChanged: (val) {
                onFilterChanged(
                  query: val,
                  statusFilter: statusFilter,
                  sortOption: sortOption,
                );
              },
            ),
          ),

        // Status Block
        FilterAccordionBlock(
          title: 'Trạng thái',
          child: Column(
            children: [
              AppFilterRadioTile<int?>(
                title: 'Tất cả',
                value: -1, // -1 means all in our logic
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: val == -1 ? null : val,
                    sortOption: sortOption,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: 'Chờ thanh toán',
                value: 0,
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: val,
                    sortOption: sortOption,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: 'Đã hoàn thành',
                value: 1,
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: val,
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
              AppFilterRadioTile<int>(
                title: 'Mới nhất',
                value: 0,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: statusFilter,
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int>(
                title: 'Cũ nhất',
                value: 1,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: statusFilter,
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int>(
                title: 'Giá trị cao nhất',
                value: 2,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: statusFilter,
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int>(
                title: 'Giá trị thấp nhất',
                value: 3,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  onFilterChanged(
                    query: searchQuery,
                    statusFilter: statusFilter,
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
