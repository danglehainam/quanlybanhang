import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../bloc/categories/categories_bloc.dart';
import '../../bloc/categories/categories_event.dart';
import '../../bloc/categories/categories_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/buttons/app_floating_action_button.dart';
import '../../widgets/app_form_modal.dart';
import 'widgets/categories_desktop_view.dart';
import 'widgets/categories_mobile_view.dart';
import 'widgets/category_form_dialog.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 0,
    );

    return BlocProvider(
      create: (context) => getIt<CategoriesBloc>(),
      child: CategoriesView(storeId: storeId),
    );
  }
}

class CategoriesView extends StatefulWidget {
  final int storeId;
  const CategoriesView({super.key, required this.storeId});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    final authState = context.read<AuthBloc>().state;
    authState.mapOrNull(
      authenticated: (state) {
        context.read<CategoriesBloc>().add(CategoriesEvent.watchCategories(storeId: widget.storeId));
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const AppLoadingWidget(),
            loading: () => const AppLoadingWidget(),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () => context.read<CategoriesBloc>().add(CategoriesEvent.watchCategories(storeId: widget.storeId)),
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
              onPressed: () {
                showAppFormModal(
                  context: context,
                  isMobileView: isMobileView,
                  builder: (_) => BlocProvider.value(
                    value: context.read<CategoriesBloc>(),
                    child: const CategoryFormDialog(),
                  ),
                );
              },
            )
          : null,
    );
  }
}
