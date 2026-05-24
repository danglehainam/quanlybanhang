import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import 'package:go_router/go_router.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_routes.dart';
import 'app_drawer.dart';
import 'app_header.dart';
import 'app_nav_bar.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isInitialized = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final screenWidth = MediaQuery.of(context).size.width;
      context.read<SettingsBloc>().add(SettingsEvent.loadSettings(screenWidth));
      _isInitialized = true;
    }
  }

  void _openMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final isMobileView = state.isMobileView;
        final currentRoute = GoRouterState.of(context).matchedLocation;
        final l10n = AppLocalizations.of(context)!;
        
        String currentTitle = l10n.appName;
        if (currentRoute.startsWith(AppRoutes.sell)) {
          currentTitle = l10n.btnSell;
        } else if (currentRoute.startsWith(AppRoutes.products)) {
          currentTitle = l10n.menuProducts;
        } else if (currentRoute.startsWith(AppRoutes.categories)) {
          currentTitle = l10n.menuCategories;
        } else if (currentRoute.startsWith(AppRoutes.transactions)) {
          currentTitle = l10n.menuTransactions;
        } else if (currentRoute.startsWith(AppRoutes.orders)) {
          currentTitle = l10n.menuOrders;
        } else if (currentRoute.startsWith(AppRoutes.home)) {
          currentTitle = l10n.menuOverview;
        }
        
        return Scaffold(
          key: _scaffoldKey,
          drawer: isMobileView ? const AppDrawer() : null,
          body: Column(
            children: [
              // Header is always visible
              AppHeader(
                isMobileView: isMobileView,
                languageCode: state.languageCode,
                currentTitle: currentTitle,
                onToggleView: () {
                  context.read<SettingsBloc>().add(const SettingsEvent.toggleLayoutView());
                },
                onChangeLanguage: () {
                  final newLang = state.languageCode == 'vi' ? 'en' : 'vi';
                  context.read<SettingsBloc>().add(SettingsEvent.changeLanguage(newLang));
                },
                onMenuPressed: isMobileView ? _openMenu : null,
              ),
              // Desktop NavBar only visible in Desktop View
              if (!isMobileView) const AppNavBar(),
              // Main content area
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}
