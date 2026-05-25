import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_formatters.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../widgets/order_filter_sidebar.dart';
import '../widgets/order_detail_dialog.dart';

class OrdersMobileView extends StatelessWidget {
  final int storeId;
  final List<OrderEntity> orders;
  final String searchQuery;
  final int? statusFilter;
  final int? sortOption;

  final int timeFilterType;
  final DateTime selectedDate;
  final int selectedMonth;
  final int selectedQuarter;
  final int selectedYear;

  const OrdersMobileView({
    super.key,
    required this.storeId,
    required this.orders,
    required this.searchQuery,
    this.statusFilter,
    this.sortOption,
    required this.timeFilterType,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedQuarter,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Top Filter Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  labelText: l10n.searchOrdersPlaceholder,
                  prefixIcon: Icons.search,
                  controller: TextEditingController(text: searchQuery)
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: searchQuery.length),
                    ),
                  onChanged: (val) {
                    context.read<OrdersBloc>().add(OrdersEvent.filterOrders(
                      query: val,
                      statusFilter: statusFilter,
                      sortOption: sortOption,
                    ));
                  },
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterBottomSheet(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Orders List
        Expanded(
          child: Container(
            color: Theme.of(context).cardColor,
            child: orders.isEmpty
                ? EmptyDataWidget(message: l10n.emptyOrdersMessage)
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(context, order, l10n);
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderEntity order, AppLocalizations l10n) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<OrdersBloc>(),
              child: OrderDetailDialog(order: order),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.orderNumber(order.id),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  _buildStatusChip(order.status, l10n),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    AppFormatters.formatDateTime(order.createdAt),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        order.customer?.name ?? l10n.retailCustomer,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.table_restaurant_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        order.table?.name ?? '-',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.itemsCount(order.items.length),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Text(
                        '${l10n.finalAmount}: ',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      Text(
                        AppFormatters.formatCurrency(order.finalAmount),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(int status, AppLocalizations l10n) {
    String text = l10n.orderStatusPending;
    Color color = AppColors.warning;
    if (status == 1) {
      text = l10n.orderStatusCompleted;
      color = AppColors.success;
    } else if (status == 2) {
      text = l10n.orderStatusCancelled;
      color = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final ordersBloc = context.read<OrdersBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (draggableContext, scrollController) {
            return BlocProvider.value(
              value: ordersBloc,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OrderFilterSidebar(
                    showCloseButton: true,
                    showSearchField: false,
                    searchQuery: searchQuery,
                    statusFilter: statusFilter,
                    sortOption: sortOption,
                    timeFilterType: timeFilterType,
                    selectedDate: selectedDate,
                    selectedMonth: selectedMonth,
                    selectedQuarter: selectedQuarter,
                    selectedYear: selectedYear,
                    onFilterChanged: ({
                      query,
                      statusFilter,
                      sortOption,
                      timeFilterType,
                      selectedDate,
                      selectedMonth,
                      selectedQuarter,
                      selectedYear,
                    }) {
                      ordersBloc.add(OrdersEvent.filterOrders(
                        query: query,
                        statusFilter: statusFilter,
                        sortOption: sortOption,
                        timeFilterType: timeFilterType,
                        selectedDate: selectedDate,
                        selectedMonth: selectedMonth,
                        selectedQuarter: selectedQuarter,
                        selectedYear: selectedYear,
                      ));
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
