import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppCompactTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const AppCompactTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 12),
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
