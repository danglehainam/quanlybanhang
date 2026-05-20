import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentRoute = GoRouterState.of(context).matchedLocation;

    return Container(
      height: 50,
      color: AppColors.navBarBackground,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _NavItem(
                  title: l10n.menuOverview,
                  icon: Icons.dashboard_outlined,
                  route: AppRoutes.home,
                  isSelected: currentRoute == AppRoutes.home,
                ),
                _NavItem(
                  title: l10n.btnSell,
                  icon: Icons.point_of_sale,
                  route: AppRoutes.sell,
                  isSelected: currentRoute == AppRoutes.sell,
                ),
                _NavItem(
                  title: l10n.menuProducts,
                  icon: Icons.inventory_2_outlined,
                  route: AppRoutes.products,
                  isSelected: currentRoute == AppRoutes.products,
                ),
                _NavItem(
                  title: l10n.menuCategories,
                  icon: Icons.category_outlined,
                  route: AppRoutes.categories,
                  isSelected: currentRoute == AppRoutes.categories,
                ),
                _NavItem(
                  title: l10n.menuTransactions,
                  icon: Icons.swap_horiz_outlined,
                  route: AppRoutes.transactions,
                  isSelected: currentRoute == AppRoutes.transactions,
                ),
                _NavItem(
                  title: 'Quản lý Bàn', // TODO: translate
                  icon: Icons.table_restaurant_outlined,
                  route: AppRoutes.tables,
                  isSelected: currentRoute == AppRoutes.tables,
                ),
                _NavItem(
                  title: l10n.menuPartners,
                  icon: Icons.people_outline,
                  route: AppRoutes.partners,
                  isSelected: currentRoute == AppRoutes.partners,
                ),
                _NavItem(
                  title: l10n.menuCashbook,
                  icon: Icons.account_balance_wallet_outlined,
                  route: AppRoutes.cashbook,
                  isSelected: currentRoute == AppRoutes.cashbook,
                ),
                _NavItem(
                  title: l10n.menuReports,
                  icon: Icons.bar_chart_outlined,
                  route: AppRoutes.reports,
                  isSelected: currentRoute == AppRoutes.reports,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isSelected;

  const _NavItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: isSelected ? AppColors.navBarSelected : Colors.transparent,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
