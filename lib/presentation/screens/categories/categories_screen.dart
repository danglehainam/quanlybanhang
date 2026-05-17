import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../bloc/categories/categories_bloc.dart';
import '../../bloc/categories/categories_event.dart';
import '../../bloc/categories/categories_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_floating_action_button.dart';
import 'widgets/categories_desktop_view.dart';
import 'widgets/categories_mobile_view.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesBloc>(),
      child: const CategoriesView(),
    );
  }
}

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<CategoriesBloc>().add(const CategoriesEvent.watchCategories());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isMobileView
          ? AppBar(
              title: Text(l10n.menuCategories),
              backgroundColor: AppColors.headerBackground,
              foregroundColor: AppColors.primary,
              elevation: 1,
            )
          : null, // Desktop view uses AppHeader handled by MainLayout
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const AppLoadingWidget(),
            loading: () => const AppLoadingWidget(),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () => context.read<CategoriesBloc>().add(const CategoriesEvent.watchCategories()),
            ),
            loaded: (categories) {
              if (isMobileView) {
                return CategoriesMobileView(
                  categories: categories,
                  searchController: _searchController,
                );
              }
              
              return CategoriesDesktopView(
                categories: categories,
                searchController: _searchController,
              );
            },
          );
        },
      ),
      floatingActionButton: isMobileView
          ? AppFloatingActionButton(
              icon: Icons.add,
              onPressed: () {},
            )
          : null,
    );
  }
}
