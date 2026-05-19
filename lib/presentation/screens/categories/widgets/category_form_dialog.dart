import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_event.dart';
import '../../../widgets/buttons/app_text_button.dart';

class CategoryFormDialog extends StatefulWidget {
  final CategoryEntity? categoryToEdit;

  const CategoryFormDialog({
    super.key,
    this.categoryToEdit,
  });

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  bool _isLoading = false;

  bool get _isEditMode => widget.categoryToEdit != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.categoryToEdit?.name);
    _descriptionController = TextEditingController(text: widget.categoryToEdit?.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final l10n = AppLocalizations.of(context)!;

      final categoryData = CategoryEntity(
        id: _isEditMode ? widget.categoryToEdit!.id : 0,
        storeId: _isEditMode ? widget.categoryToEdit!.storeId : 1, // Dummy storeId for now
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        createdAt: _isEditMode ? widget.categoryToEdit!.createdAt : DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );

      final bloc = context.read<CategoriesBloc>();

      if (_isEditMode) {
        bloc.add(
          CategoriesEvent.updateCategory(
            categoryData,
            onSuccess: () {
              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.categoryUpdatedSuccess)),
                );
              }
            },
            onError: (error) {
              if (mounted) {
                setState(() => _isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              }
            },
          ),
        );
      } else {
        bloc.add(
          CategoriesEvent.createCategory(
            categoryData,
            onSuccess: () {
              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.categoryCreatedSuccess)),
                );
              }
            },
            onError: (error) {
              if (mounted) {
                setState(() => _isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              }
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppDialog(
      title: _isEditMode ? l10n.editCategory : l10n.addCategory,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: _nameController,
              labelText: l10n.categoryName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.validationCategoryNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _descriptionController,
              labelText: l10n.categoryDescription,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: _onSave,
            ),
          ],
        ),
      ),
      actions: [
        AppTextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          label: l10n.cancel,
        ),
        AppPrimaryButton(
          label: l10n.save,
          onPressed: _onSave,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
