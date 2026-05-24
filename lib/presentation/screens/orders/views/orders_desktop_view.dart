import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../widgets/app_formatters.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/layout/two_column_desktop_layout.dart';
import '../../../widgets/buttons/app_icon_button.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../widgets/order_filter_sidebar.dart';
import '../widgets/order_detail_dialog.dart';

class OrdersDesktopView extends StatelessWidget {
  final int storeId;
  final List<OrderEntity> orders;
  final String searchQuery;
  final int? statusFilter;
  final int? sortOption;

  const OrdersDesktopView({
    super.key,
    required this.storeId,
    required this.orders,
    required this.searchQuery,
    this.statusFilter,
    this.sortOption,
  });

  @override
  Widget build(BuildContext context) {
    return TwoColumnDesktopLayout(
      leftContent: OrderFilterSidebar(
        searchQuery: searchQuery,
        statusFilter: statusFilter,
        sortOption: sortOption,
        onFilterChanged: ({query, statusFilter, sortOption}) {
          context.read<OrdersBloc>().add(OrdersEvent.filterOrders(
            query: query,
            statusFilter: statusFilter,
            sortOption: sortOption,
          ));
        },
      ),
      rightContent: orders.isEmpty
          ? EmptyDataWidget(message: l10n.emptyOrdersMessage)
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        showCheckboxColumn: false,
                        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        columns: [
                          DataColumn(label: Text(l10n.orderCode)),
                          DataColumn(label: Text(l10n.orderTime)),
                          DataColumn(label: Text(l10n.customerLabel.replaceAll(':', ''))),
                          DataColumn(label: Text(l10n.table)),
                          DataColumn(label: Text(l10n.totalAmount)),
                          DataColumn(label: Text(l10n.discount)),
                          DataColumn(label: Text(l10n.finalAmount)),
                          DataColumn(label: Text(l10n.status)),
                          DataColumn(label: Text(l10n.actions)),
                        ],
                        rows: orders.map((order) {
                          return DataRow(
                            onSelectChanged: (_) {
                              showDialog(
                                context: context,
                                builder: (_) => OrderDetailDialog(order: order),
                              );
                            },
                            cells: [
                              DataCell(Text('#${order.id}')),
                              DataCell(Text(AppFormatters.formatDateTime(order.createdAt))),
                              DataCell(Text(order.customer?.name ?? l10n.retailCustomer)),
                              DataCell(Text(order.table?.name ?? '-')),
                              DataCell(Text(AppFormatters.formatCurrency(order.totalAmount))),
                              DataCell(Text(
                                order.discount > 0 ? '-${AppFormatters.formatCurrency(order.discount)}' : '0 đ',
                                style: TextStyle(color: order.discount > 0 ? AppColors.success : AppColors.textPrimary),
                              )),
                              DataCell(Text(
                                AppFormatters.formatCurrency(order.finalAmount),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                              )),
                              DataCell(_buildStatusChip(order.status, l10n)),
                              DataCell(
                                AppIconButton(
                                  icon: Icons.visibility_outlined,
                                  color: AppColors.primary,
                                  tooltip: l10n.actions,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => OrderDetailDialog(order: order),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(26), // 10% opacity
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
