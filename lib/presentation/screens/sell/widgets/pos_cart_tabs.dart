import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/core/constants/app_colors.dart';
import 'package:quan_ly_ban_hang/domain/entities/order_entity.dart';
import 'package:quan_ly_ban_hang/presentation/bloc/sell/sell_bloc.dart';
import 'package:quan_ly_ban_hang/presentation/bloc/sell/sell_event.dart';

class PosCartTabs extends StatelessWidget {
  final List<OrderEntity> orders;
  final int selectedIndex;
  final VoidCallback? onActiveTabTapped;

  const PosCartTabs({
    super.key,
    required this.orders,
    required this.selectedIndex,
    this.onActiveTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
        color: AppColors.background,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orders.length + 1,
        itemBuilder: (context, index) {
          if (index == orders.length) {
            // Nút Thêm đơn
            return InkWell(
              onTap: () => context.read<SellBloc>().add(const SellEvent.addOrder()),
              child: Container(
                width: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.divider)),
                ),
                child: const Icon(Icons.add, color: AppColors.textSecondary),
              ),
            );
          }

          final isActive = index == selectedIndex;
          return InkWell(
            onTap: () {
              if (isActive && onActiveTabTapped != null) {
                onActiveTabTapped!();
              } else {
                context.read<SellBloc>().add(SellEvent.selectOrder(index));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? Colors.white : AppColors.background,
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                  right: const BorderSide(color: AppColors.divider),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Đơn ${index + 1}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => context.read<SellBloc>().add(SellEvent.removeOrder(index)),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.close, size: 14, color: AppColors.textSecondary),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
