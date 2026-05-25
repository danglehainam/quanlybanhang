import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/filter_accordion_block.dart';
import '../../../widgets/app_filter_sidebar.dart';
import '../../../widgets/app_filter_radio_tile.dart';

class TransactionFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final bool showSearchField;
  
  final String searchQuery;
  final int selectedType;
  final int sortOption;

  final void Function({
    String? query,
    int? type,
    int? sortOption,
  }) onFilterChanged;

  const TransactionFilterSidebar({
    super.key,
    this.showCloseButton = false,
    this.showSearchField = true,
    required this.searchQuery,
    required this.selectedType,
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
              labelText: l10n.searchTransaction,
              prefixIcon: Icons.search,
              controller: TextEditingController(text: searchQuery)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: searchQuery.length),
                ),
              onChanged: (val) {
                onFilterChanged(
                  query: val,
                  type: selectedType,
                  sortOption: sortOption,
                );
              },
            ),
          ),

        // Transaction Type Block
        FilterAccordionBlock(
          title: l10n.transactionType,
          child: Column(
            children: [
              AppFilterRadioTile<int>(
                title: l10n.all,
                value: -1,
                groupValue: selectedType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: val,
                      sortOption: sortOption,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.incomeOnly,
                value: 0,
                groupValue: selectedType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: val,
                      sortOption: sortOption,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.expenseOnly,
                value: 1,
                groupValue: selectedType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: val,
                      sortOption: sortOption,
                    );
                  }
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
                groupValue: sortOption,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: selectedType,
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.oldest,
                value: 1,
                groupValue: sortOption,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: selectedType,
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.highestValue,
                value: 2,
                groupValue: sortOption,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: selectedType,
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.lowestValue,
                value: 3,
                groupValue: sortOption,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      query: searchQuery,
                      type: selectedType,
                      sortOption: val,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
