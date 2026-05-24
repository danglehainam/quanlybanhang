import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return AppFilterSidebar(
      showCloseButton: showCloseButton,
      children: [
        // Search Block
        if (showSearchField)
          FilterAccordionBlock(
            title: l10n.searchLabel,
            child: AppTextField(
              labelText: l10n.searchFieldLabel,
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
          title: l10n.status,
          child: Column(
            children: [
              AppFilterRadioTile<int?>(
                title: l10n.all,
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
                title: l10n.orderStatusPending,
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
                title: l10n.orderStatusCompleted,
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
          title: l10n.sortBy,
          child: Column(
            children: [
              AppFilterRadioTile<int>(
                title: l10n.newest,
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
                title: l10n.oldest,
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
                title: l10n.highestValue,
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
                title: l10n.lowestValue,
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
