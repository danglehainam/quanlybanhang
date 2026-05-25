import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
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

  final int timeFilterType;
  final DateTime selectedDate;
  final int selectedMonth;
  final int selectedQuarter;
  final int selectedYear;

  final void Function({
    String? query,
    int? statusFilter,
    int? sortOption,
    int? timeFilterType,
    DateTime? selectedDate,
    int? selectedMonth,
    int? selectedQuarter,
    int? selectedYear,
  }) onFilterChanged;

  const OrderFilterSidebar({
    super.key, 
    this.showCloseButton = false,
    this.showSearchField = true,
    required this.searchQuery,
    required this.statusFilter,
    required this.sortOption,
    required this.timeFilterType,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedQuarter,
    required this.selectedYear,
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
                );
              },
            ),
          ),

        // Time Filter Block
        FilterAccordionBlock(
          title: l10n.timeFilter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFilterRadioTile<int>(
                title: l10n.specificDate,
                value: 0,
                groupValue: timeFilterType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(timeFilterType: val);
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.byMonth,
                value: 1,
                groupValue: timeFilterType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(timeFilterType: val);
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.byQuarter,
                value: 2,
                groupValue: timeFilterType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(timeFilterType: val);
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.byYear,
                value: 3,
                groupValue: timeFilterType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(timeFilterType: val);
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.allTime,
                value: 4,
                groupValue: timeFilterType,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(timeFilterType: val);
                  }
                },
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),

              // Dynamic selector depending on timeFilterType
              if (timeFilterType == 0) ...[
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );
                    if (picked != null) {
                      onFilterChanged(selectedDate: picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(selectedDate),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ] else if (timeFilterType == 1) ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: selectedMonth,
                        decoration: InputDecoration(
                          labelText: l10n.selectMonth,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: const OutlineInputBorder(),
                        ),
                        items: List.generate(12, (index) => index + 1).map((m) {
                          return DropdownMenuItem(value: m, child: Text('$m'));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            onFilterChanged(selectedMonth: val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildYearDropdown(context, selectedYear, l10n),
                    ),
                  ],
                ),
              ] else if (timeFilterType == 2) ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: selectedQuarter,
                        decoration: InputDecoration(
                          labelText: l10n.selectQuarter,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 1, child: Text(l10n.quarter1)),
                          DropdownMenuItem(value: 2, child: Text(l10n.quarter2)),
                          DropdownMenuItem(value: 3, child: Text(l10n.quarter3)),
                          DropdownMenuItem(value: 4, child: Text(l10n.quarter4)),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            onFilterChanged(selectedQuarter: val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildYearDropdown(context, selectedYear, l10n),
                    ),
                  ],
                ),
              ] else if (timeFilterType == 3) ...[
                _buildYearDropdown(context, selectedYear, l10n),
              ],
            ],
          ),
        ),

        // Status Block
        FilterAccordionBlock(
          title: l10n.status,
          child: Column(
            children: [
              AppFilterRadioTile<int?>(
                title: l10n.all,
                value: -1, 
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    statusFilter: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: l10n.orderStatusPending,
                value: 0,
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    statusFilter: val,
                  );
                },
              ),
              AppFilterRadioTile<int?>(
                title: l10n.orderStatusCompleted,
                value: 1,
                groupValue: statusFilter ?? -1,
                onChanged: (val) {
                  onFilterChanged(
                    statusFilter: val,
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
                  if (val != null) {
                    onFilterChanged(
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.oldest,
                value: 1,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.highestValue,
                value: 2,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
                      sortOption: val,
                    );
                  }
                },
              ),
              AppFilterRadioTile<int>(
                title: l10n.lowestValue,
                value: 3,
                groupValue: sortOption ?? 0,
                onChanged: (val) {
                  if (val != null) {
                    onFilterChanged(
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

  Widget _buildYearDropdown(BuildContext context, int selectedYear, AppLocalizations l10n) {
    final currentYear = DateTime.now().year;
    final years = List.generate(11, (index) => currentYear - 5 + index);

    return DropdownButtonFormField<int>(
      value: selectedYear,
      decoration: InputDecoration(
        labelText: l10n.selectYear,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: const OutlineInputBorder(),
      ),
      items: years.map((y) {
        return DropdownMenuItem(value: y, child: Text('$y'));
      }).toList(),
      onChanged: (val) {
        if (val != null) {
          onFilterChanged(selectedYear: val);
        }
      },
    );
  }
}
