import 'package:flutter/material.dart';
import '../../../../domain/entities/category_entity.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_confirm_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_event.dart';
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
        ExpansionTile(
          title: Text(l10n.filterAndSearch, style: const TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: 'newest',
                    decoration: InputDecoration(
                      labelText: l10n.sortBy,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: [
                      DropdownMenuItem(value: 'newest', child: Text(l10n.newest)),
                      DropdownMenuItem(value: 'oldest', child: Text(l10n.oldest)),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppTextField(
            controller: searchController,
            labelText: l10n.searchByName,
            prefixIcon: Icons.search,
          ),
        ),
        Expanded(
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
                        showAdaptiveDialog(
                          context: context,
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
      ],
    );
  }
}
