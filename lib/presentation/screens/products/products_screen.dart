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
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/buttons/app_floating_action_button.dart';
import '../../widgets/app_form_modal.dart';
import 'views/products_desktop_view.dart';
import 'views/products_mobile_view.dart';
import 'widgets/product_form_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 0,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductsBloc>()..add(ProductsEvent.watchProducts(storeId: storeId)),
        ),
        BlocProvider(
          create: (_) => getIt<CategoriesBloc>()..add(CategoriesEvent.watchCategories(storeId: storeId)),
        ),
      ],
      child: _ProductsScreenContent(storeId: storeId),
    );
  }
}

class _ProductsScreenContent extends StatelessWidget {
  final int storeId;
  const _ProductsScreenContent({required this.storeId});

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
              onRetry: () => context.read<ProductsBloc>().add(ProductsEvent.watchProducts(storeId: storeId)),
            ),
            loaded: (allProducts, filteredProducts, searchQuery, selectedCategoryId, sortOption, minPrice, maxPrice, productStatus) {
              // Now we also need to wait for categories to load
              return BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, categoriesState) {
                  return categoriesState.maybeWhen(
                    loaded: (categories) {
                      if (isMobileView) {
                        return ProductsMobileView(
                          storeId: storeId,
                          products: filteredProducts,
                          categories: categories,
                          searchQuery: searchQuery,
                          selectedCategoryId: selectedCategoryId,
                          sortOption: sortOption,
                          minPrice: minPrice,
                          maxPrice: maxPrice,
                          productStatus: productStatus,
                        );
                      }
                      
                      return ProductsDesktopView(
                        storeId: storeId,
                        products: filteredProducts,
                        categories: categories,
                        searchQuery: searchQuery,
                        selectedCategoryId: selectedCategoryId,
                        sortOption: sortOption,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        productStatus: productStatus,
                      );
                    },
                    error: (message) => AppErrorWidget(
                      message: message,
                      onRetry: () => context.read<CategoriesBloc>().add(CategoriesEvent.watchCategories(storeId: storeId)),
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
                showAppFormModal(
                  context: context,
                  isMobileView: isMobileView,
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
