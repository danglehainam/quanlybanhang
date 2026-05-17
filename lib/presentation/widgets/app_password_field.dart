import 'package:flutter/material.dart';

/// Reusable password input with toggle visibility.
/// Use this for all password fields across the app.
class AppPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final VoidCallback? onFieldSubmitted;

  const AppPasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted != null
          ? (_) => widget.onFieldSubmitted!()
          : null,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: const Icon(Icons.lock_outlined),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
