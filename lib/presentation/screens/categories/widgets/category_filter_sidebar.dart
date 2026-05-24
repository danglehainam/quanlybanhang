import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return AppFilterSidebar(
      showCloseButton: showCloseButton,
      children: [
        // Search Block
        if (showSearchField)
          FilterAccordionBlock(
            title: l10n.searchLabel,
            child: AppTextField(
              labelText: l10n.searchCategory,
              prefixIcon: Icons.search,
              controller: searchController,
              onChanged: (val) {
                // If we need to trigger immediate search, we can add logic here.
              },
            ),
          ),

        // Sort Block
        FilterAccordionBlock(
          title: l10n.sortBy,
          child: Column(
            children: [
              AppFilterRadioTile<int?>(
                title: l10n.newest,
                value: null,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: l10n.oldest,
                value: 1,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: l10n.sortNameAZ,
                value: 2,
                groupValue: sortOption,
                onChanged: (val) {
                  onFilterChanged(
                    sortOption: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: l10n.sortNameZA,
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
