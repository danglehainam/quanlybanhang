import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/utils/file_utils.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_state.dart';
import '../../../widgets/buttons/app_text_button.dart';

class ProductFormDialog extends StatefulWidget {
  final ProductEntity? productToEdit;

  const ProductFormDialog({
    super.key,
    this.productToEdit,
  });

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  int? _selectedCategoryId;
  String? _imageUrl;
  bool _isLoading = false;

  bool get _isEditMode => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productToEdit?.name);
    _priceController = TextEditingController(text: widget.productToEdit?.price.toString());
    _descriptionController = TextEditingController(text: widget.productToEdit?.description);
    _selectedCategoryId = widget.productToEdit?.categoryId;
    _imageUrl = widget.productToEdit?.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // Ngắt focus của các ô input (bàn phím) trước khi mở File Picker của hệ điều hành
    // Điều này giúp tránh lỗi kẹt phím Command (Meta Left) của Flutter Desktop
    FocusScope.of(context).unfocus();
    
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Lưu file vĩnh viễn vào documents directory
      final savedPath = await FileUtils.saveFileToDocumentsDirectory(pickedFile.path);
      
      if (!mounted) return;
      setState(() {
        _imageUrl = savedPath;
      });
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final l10n = AppLocalizations.of(context)!;
      final price = int.tryParse(_priceController.text.trim()) ?? 0;

      final productData = ProductEntity(
        id: _isEditMode ? widget.productToEdit!.id : 0,
        storeId: _isEditMode ? widget.productToEdit!.storeId : 1, // Dummy storeId
        categoryId: _selectedCategoryId,
        name: _nameController.text.trim(),
        price: price,
        imageUrl: _imageUrl,
        description: _descriptionController.text.trim(),
        status: widget.productToEdit?.status ?? 1,
        createdAt: _isEditMode ? widget.productToEdit!.createdAt : DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );

      final bloc = context.read<ProductsBloc>();

      if (_isEditMode) {
        bloc.add(
          ProductsEvent.updateProduct(
            productData,
            onSuccess: () {
              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.productUpdatedSuccess)),
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
          ProductsEvent.createProduct(
            productData,
            onSuccess: () {
              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.productCreatedSuccess)),
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
      title: _isEditMode ? l10n.editProduct : l10n.addProduct,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: _imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _imageUrl!.startsWith('http')
                            ? Image.network(_imageUrl!, fit: BoxFit.cover)
                            : Image.file(File(_imageUrl!), fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, color: Colors.grey),
                          const SizedBox(height: 4),
                          Text('Ảnh', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _nameController,
              labelText: l10n.productName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.validationRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: l10n.price,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.validationPriceRequired;
                }
                if (int.tryParse(value) == null) {
                  return l10n.validationPriceRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Category Dropdown
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (categories) {
                    return DropdownButtonFormField<int?>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: l10n.selectCategory,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text(l10n.unassignedCategory),
                        ),
                        ...categories.map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ))
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                    );
                  },
                  orElse: () => const CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.description,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        AppTextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          label: l10n.cancel,
        ),
        const SizedBox(width: 8),
        AppPrimaryButton(
          label: l10n.save,
          isLoading: _isLoading,
          onPressed: _onSave,
        ),
      ],
    );
  }
}
