import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_event.dart';
import '../../../bloc/auth/auth_state.dart';
import '../../../widgets/app_password_field.dart';
import '../../../widgets/app_text_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _storeNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthEvent.register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            userName: _nameController.text.trim(),
            storeName: _storeNameController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _nameController,
            labelText: l10n.userName,
            prefixIcon: Icons.person_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationNameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _storeNameController,
            labelText: l10n.storeName,
            prefixIcon: Icons.store_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationStoreNameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _emailController,
            labelText: l10n.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationEmailRequired;
              }
              if (!value.contains('@')) {
                return l10n.validationEmailInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: _passwordController,
            labelText: l10n.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.validationPasswordRequired;
              }
              if (value.length < 6) {
                return l10n.validationPasswordTooShort;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: _confirmPasswordController,
            labelText: l10n.confirmPassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: _onRegisterPressed,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.validationConfirmPasswordRequired;
              }
              if (value != _passwordController.text) {
                return l10n.validationPasswordMismatch;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          _RegisterButton(onPressed: _onRegisterPressed),
          const SizedBox(height: 16),
          _LoginLink(),
        ],
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RegisterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.register, style: const TextStyle(fontSize: 16)),
        );
      },
    );
  }
}

class _LoginLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.alreadyHaveAccount),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l10n.login),
        ),
      ],
    );
  }
}
