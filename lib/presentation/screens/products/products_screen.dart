import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../core/di/dependency_injection.dart';
import '../../bloc/products/products_bloc.dart';
import '../../bloc/products/products_event.dart';
import '../../bloc/products/products_state.dart';
import '../../bloc/categories/categories_bloc.dart';
import '../../bloc/categories/categories_event.dart';
import '../../bloc/categories/categories_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/app_floating_action_button.dart';
import 'views/products_desktop_view.dart';
import 'views/products_mobile_view.dart';
import 'widgets/product_form_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductsBloc>()..add(const ProductsEvent.watchProducts()),
        ),
        BlocProvider(
          create: (_) => getIt<CategoriesBloc>()..add(const CategoriesEvent.watchCategories()),
        ),
      ],
      child: const _ProductsScreenContent(),
    );
  }
}

class _ProductsScreenContent extends StatelessWidget {
  const _ProductsScreenContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, productsState) {
          return productsState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const AppLoadingWidget(),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () => context.read<ProductsBloc>().add(const ProductsEvent.watchProducts()),
            ),
            loaded: (products) {
              // Now we also need to wait for categories to load
              return BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, categoriesState) {
                  return categoriesState.maybeWhen(
                    loaded: (categories) {
                      if (isMobileView) {
                        return ProductsMobileView(
                          products: products,
                          categories: categories,
                        );
                      }
                      
                      return ProductsDesktopView(
                        products: products,
                        categories: categories,
                      );
                    },
                    error: (message) => AppErrorWidget(
                      message: message,
                      onRetry: () => context.read<CategoriesBloc>().add(const CategoriesEvent.watchCategories()),
                    ),
                    orElse: () => const AppLoadingWidget(),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: isMobileView
          ? AppFloatingActionButton(
              icon: Icons.add,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductsBloc>.value(value: context.read<ProductsBloc>()),
                      BlocProvider<CategoriesBloc>.value(value: context.read<CategoriesBloc>()),
                    ],
                    child: const ProductFormDialog(),
                  ),
                );
              },
              tooltip: l10n.addProduct,
            )
          : null,
    );
  }
}
