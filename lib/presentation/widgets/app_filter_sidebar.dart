import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';

class AppFilterSidebar extends StatelessWidget {
  final bool showCloseButton;
  final List<Widget> children;

  const AppFilterSidebar({
    super.key,
    this.showCloseButton = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showCloseButton)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.filterAndSearch,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ...children,
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
