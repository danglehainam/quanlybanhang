import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/category_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_event.dart';
import 'category_form_dialog.dart';
import '../../../widgets/app_form_modal.dart';
import 'category_desktop_item.dart';
import '../../../widgets/layout/two_column_desktop_layout.dart';
import 'category_filter_sidebar.dart';

class CategoriesDesktopView extends StatelessWidget {
  final List<CategoryEntity> categories;
  final TextEditingController searchController;

  const CategoriesDesktopView({
    super.key,
    required this.categories,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TwoColumnDesktopLayout(
      leftContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CategoryFilterSidebar(
              searchController: searchController,
              sortOption: null,
              onFilterChanged: ({sortOption}) {
                // TODO: Implement sorting in CategoriesBloc
              },
            ),
          ),
          const SizedBox(height: 16),
          AppPrimaryButton(
            label: l10n.addCategory,
            icon: Icons.add,
            onPressed: () {
              showAppFormModal(
                context: context,
                isMobileView: false,
                builder: (_) => BlocProvider.value(
                  value: context.read<CategoriesBloc>(),
                  child: const CategoryFormDialog(),
                ),
              );
            },
          ),
        ],
      ),
      rightContent: categories.isEmpty
          ? EmptyDataWidget(
              message: l10n.emptyCategoryMessage,
              icon: Icons.category_outlined,
            )
          : ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryDesktopItem(
                  category: category,
                  onEdit: () {
                    showAppFormModal(
                      context: context,
                      isMobileView: false,
                      builder: (_) => BlocProvider.value(
                        value: context.read<CategoriesBloc>(),
                        child: CategoryFormDialog(categoryToEdit: category),
                      ),
                    );
                  },
                  onDelete: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (_) => AppConfirmDialog(
                        title: l10n.deleteCategoryConfirmTitle,
                        content: l10n.deleteCategoryConfirmMessage,
                        confirmLabel: l10n.delete,
                        cancelLabel: l10n.cancel,
                        isDestructive: true,
                        onConfirm: () {
                          context.read<CategoriesBloc>().add(
                            CategoriesEvent.deleteCategory(
                              category.id,
                              onSuccess: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.categoryDeletedSuccess)),
                                );
                              },
                              onError: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error), backgroundColor: AppColors.error),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
