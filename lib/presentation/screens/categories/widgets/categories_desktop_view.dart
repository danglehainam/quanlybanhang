import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/category_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_primary_button.dart';
import '../../../widgets/app_confirm_dialog.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_event.dart';
import 'category_form_dialog.dart';
import 'category_desktop_item.dart';

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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Filter (1/4)
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  controller: searchController,
                  labelText: l10n.searchCategory,
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.sortBy,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: 'newest',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  items: [
                    DropdownMenuItem(value: 'newest', child: Text(l10n.newest)),
                    DropdownMenuItem(value: 'oldest', child: Text(l10n.oldest)),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 24),
                AppPrimaryButton(
                  label: l10n.addCategory,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<CategoriesBloc>(),
                        child: const CategoryFormDialog(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        // Right Column: List (3/4)
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: categories.isEmpty
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
                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: context.read<CategoriesBloc>(),
                                child: CategoryFormDialog(categoryToEdit: category),
                              ),
                            );
                          },
                          onDelete: () {
                            showDialog(
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
            ),
          ),
        ),
      ],
    );
  }
}
