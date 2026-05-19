import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'app_dialog.dart';
import 'buttons/app_text_button.dart';
import 'buttons/app_filled_button.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      content: Text(content),
      actions: [
        AppTextButton(
          onPressed: () => Navigator.of(context).pop(),
          label: cancelLabel,
        ),
        AppFilledButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog first
            onConfirm(); // Then execute callback
          },
          backgroundColor: isDestructive ? AppColors.error : AppColors.primary,
          label: confirmLabel,
        ),
      ],
    );
  }
}
