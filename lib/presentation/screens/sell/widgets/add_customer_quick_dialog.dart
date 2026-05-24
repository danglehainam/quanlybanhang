import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../../core/di/dependency_injection.dart';

import '../../../../../domain/usecases/create_customer_usecase.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/buttons/app_primary_button.dart';

class AddCustomerQuickDialog extends StatefulWidget {
  final String initialPhone;

  const AddCustomerQuickDialog({super.key, required this.initialPhone});

  @override
  State<AddCustomerQuickDialog> createState() => _AddCustomerQuickDialogState();
}

class _AddCustomerQuickDialogState extends State<AddCustomerQuickDialog> {
  late TextEditingController _phoneController;
  final _nameController = TextEditingController();
  final _createUseCase = getIt<CreateCustomerUseCase>();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      setState(() => _error = 'Vui lòng nhập tên và SĐT');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 1,
    );

    final result = await _createUseCase(
      storeId: storeId,
      name: name,
      phone: phone,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    result.fold(
      (failure) => setState(() => _error = failure.message),
      (customer) => Navigator.of(context).pop(customer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppDialog(
      title: 'Thêm Khách Hàng Nhanh',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_error != null) ...[
            Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
            const SizedBox(height: 8),
          ],
          AppTextField(
            controller: _phoneController,
            labelText: 'Số điện thoại',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _nameController,
            labelText: 'Tên khách hàng',
            textInputAction: TextInputAction.done,
            onFieldSubmitted: () => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        AppPrimaryButton(
          label: l10n.save,
          onPressed: _isLoading ? null : _submit,
        ),
      ],
    );
  }
}
