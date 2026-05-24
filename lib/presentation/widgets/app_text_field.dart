import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable text input widget for the app.
/// Use this instead of raw TextFormField to ensure consistent styling.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const AppTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted != null ? (_) => onFieldSubmitted!() : null,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF007AFF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFF3B30), width: 1.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: const Color(0xFFEFEFF4), // iOS text field background
      ),
      validator: validator,
    );
  }
}
