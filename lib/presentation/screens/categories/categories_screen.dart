import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../bloc/categories/categories_bloc.dart';
import '../../bloc/categories/categories_event.dart';
import '../../bloc/categories/categories_state.dart';
import '../../bloc/settings/settings_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(const CategoriesEvent.watchCategories());
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
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message, style: const TextStyle(color: AppColors.error))),
            loaded: (categories) {
              if (categories.isEmpty) {
                return const Center(child: Text('Chưa có danh mục nào'));
              }
              
              if (isMobileView) {
                return CategoriesMobileView(categories: categories);
              }
              
              return CategoriesDesktopView(categories: categories);
            },
          );
        },
      ),
    );
  }
}
