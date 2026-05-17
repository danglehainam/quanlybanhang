import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentRoute = GoRouterState.of(context).matchedLocation;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.navBarBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.store_rounded, color: Colors.white, size: 48),
                const SizedBox(height: 8),
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  title: l10n.menuOverview,
                  icon: Icons.dashboard_outlined,
                  route: AppRoutes.home,
                  isSelected: currentRoute == AppRoutes.home,
                ),
                _DrawerItem(
                  title: l10n.menuProducts,
                  icon: Icons.inventory_2_outlined,
                  route: AppRoutes.products,
                  isSelected: currentRoute == AppRoutes.products,
                ),
                _DrawerItem(
                  title: l10n.menuCategories,
                  icon: Icons.category_outlined,
                  route: AppRoutes.categories,
                  isSelected: currentRoute == AppRoutes.categories,
                ),
                _DrawerItem(
                  title: l10n.menuTransactions,
                  icon: Icons.swap_horiz_outlined,
                  route: AppRoutes.transactions,
                  isSelected: currentRoute == AppRoutes.transactions,
                ),
                _DrawerItem(
                  title: l10n.menuPartners,
                  icon: Icons.people_outline,
                  route: AppRoutes.partners,
                  isSelected: currentRoute == AppRoutes.partners,
                ),
                _DrawerItem(
                  title: l10n.menuCashbook,
                  icon: Icons.account_balance_wallet_outlined,
                  route: AppRoutes.cashbook,
                  isSelected: currentRoute == AppRoutes.cashbook,
                ),
                _DrawerItem(
                  title: l10n.menuReports,
                  icon: Icons.bar_chart_outlined,
                  route: AppRoutes.reports,
                  isSelected: currentRoute == AppRoutes.reports,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () {
                // TODO: Navigate to POS screen
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text(l10n.btnSell),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isSelected;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primaryLight.withAlpha(26), // ~10% opacity
      onTap: () {
        Navigator.pop(context); // Close drawer
        context.go(route);
      },
    );
  }
}
