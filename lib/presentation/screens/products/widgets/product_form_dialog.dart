import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/utils/file_utils.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_form_modal.dart';
import '../../../bloc/settings/settings_bloc.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/buttons/app_primary_button.dart';
import '../../../bloc/products/products_bloc.dart';
import '../../../bloc/products/products_event.dart';
import '../../../bloc/categories/categories_bloc.dart';
import '../../../bloc/categories/categories_state.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';
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
  late final TextEditingController _stockController;
  late final TextEditingController _descriptionController;
  int? _selectedCategoryId;
  String? _imageUrl;
  bool _isLoading = false;

  bool get _isEditMode => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productToEdit?.name);
    _priceController = TextEditingController(
      text: widget.productToEdit != null 
        ? CurrencyUtils.formatNumber(widget.productToEdit!.price)
        : '',
    );
    _stockController = TextEditingController(
      text: widget.productToEdit?.stock != null 
        ? widget.productToEdit!.stock.toString()
        : '',
    );
    _descriptionController = TextEditingController(text: widget.productToEdit?.description);
    _selectedCategoryId = widget.productToEdit?.categoryId;
    _imageUrl = widget.productToEdit?.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
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
      final price = CurrencyUtils.parseCurrency(_priceController.text);
      final stockText = _stockController.text.trim();
      final stock = stockText.isEmpty ? null : int.tryParse(stockText);
      final authState = context.read<AuthBloc>().state;
      final storeId = authState.maybeMap(
        authenticated: (state) => state.user.storeId,
        orElse: () => 1,
      );

      final productData = ProductEntity(
        id: _isEditMode ? widget.productToEdit!.id : 0,
        storeId: _isEditMode ? widget.productToEdit!.storeId : storeId,
        categoryId: _selectedCategoryId,
        name: _nameController.text.trim(),
        price: price,
        imageUrl: _imageUrl,
        description: _descriptionController.text.trim(),
        status: widget.productToEdit?.status ?? 1,
        stock: stock,
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

  Widget _buildImagePicker(bool isMobileView) {
    final size = isMobileView ? 120.0 : 150.0;
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: size,
        height: size,
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
    );
  }

  Widget _buildFormFields(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        AppTextField(
          controller: _priceController,
          labelText: l10n.price,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.validationPriceRequired;
            }
            final parsedValue = CurrencyUtils.parseCurrency(value);
            if (parsedValue <= 0) {
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
              orElse: () => const CircularProgressIndicator.adaptive(),
            );
          },
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _stockController,
          labelText: 'Số lượng',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value != null && value.trim().isNotEmpty) {
              final parsedValue = int.tryParse(value);
              if (parsedValue == null || parsedValue < 0) {
                return 'Số lượng tồn kho không hợp lệ';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _descriptionController,
          labelText: l10n.description,
          maxLines: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobileView = context.select((SettingsBloc bloc) => bloc.state.isMobileView);

    final title = _isEditMode ? l10n.editProduct : l10n.addProduct;
    final content = Form(
      key: _formKey,
      child: isMobileView
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildImagePicker(true),
                const SizedBox(height: 16),
                _buildFormFields(l10n),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImagePicker(false),
                const SizedBox(width: 24),
                Expanded(child: _buildFormFields(l10n)),
              ],
            ),
    );
    final actions = [
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
    ];

    if (isMobileView) {
      return AppBottomSheet(
        title: title,
        content: content,
        actions: actions,
      );
    }

    return AppDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
