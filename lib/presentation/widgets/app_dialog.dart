import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 500, // Đảm bảo chiều rộng cố định trên Desktop, tự động thu nhỏ trên Mobile
          child: SingleChildScrollView(
            child: content,
          ),
        ),
      ),
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
    );
  }
}
