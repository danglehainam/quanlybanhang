import 'package:flutter/material.dart';
import '../../../../domain/entities/category_entity.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_confirm_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_event.dart';
import '../../../widgets/app_form_modal.dart';
import 'category_filter_sidebar.dart';
import 'category_form_dialog.dart';
import 'category_mobile_item.dart';

class CategoriesMobileView extends StatelessWidget {
  final List<CategoryEntity> categories;
  final TextEditingController searchController;

  const CategoriesMobileView({
    super.key,
    required this.categories,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Top Filter Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  labelText: l10n.searchByName,
                  prefixIcon: Icons.search,
                  controller: searchController,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterBottomSheet(context, l10n),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            color: Theme.of(context).cardColor,
            child: categories.isEmpty
              ? EmptyDataWidget(
                  message: l10n.emptyCategoryMessage,
                  icon: Icons.category_outlined,
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryMobileItem(
                      category: category,
                      onEdit: () {
                        showAppFormModal(
                          context: context,
                          isMobileView: true,
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
                                      SnackBar(content: Text(error), backgroundColor: Colors.red),
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
            ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext parentContext, AppLocalizations l10n) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: CategoryFilterSidebar(
              showCloseButton: true,
              showSearchField: false,
              searchController: searchController,
              sortOption: null,
              onFilterChanged: ({sortOption}) {
                // TODO: Implement sorting in CategoriesBloc
              },
            ),
          ),
        );
      },
    );
  }
}
