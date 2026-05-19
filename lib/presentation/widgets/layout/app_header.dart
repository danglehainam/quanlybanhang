import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../buttons/app_icon_button.dart';
import '../buttons/app_text_button.dart';
import '../app_tooltip.dart';

class AppHeader extends StatelessWidget {
  final bool isMobileView;
  final String languageCode;
  final VoidCallback onToggleView;
  final VoidCallback onChangeLanguage;
  final VoidCallback? onMenuPressed;
  final String? currentTitle;

  const AppHeader({
    super.key,
    required this.isMobileView,
    required this.languageCode,
    this.currentTitle,
    required this.onToggleView,
    required this.onChangeLanguage,
    this.onMenuPressed,
  });

  void _showMobileMenu(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tuỳ chọn', // Optional: hardcoded or you can add to l10n later. Let's just use 'Tuỳ chỉnh giao diện'
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // View Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chế độ hiển thị', style: const TextStyle(fontWeight: FontWeight.w500)),
                    ToggleButtons(
                      isSelected: [isMobileView, !isMobileView],
                      onPressed: (index) {
                        Navigator.pop(context);
                        if ((index == 0 && !isMobileView) || (index == 1 && isMobileView)) {
                          onToggleView();
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: AppColors.primary,
                      color: AppColors.textSecondary,
                      constraints: const BoxConstraints(minHeight: 36, minWidth: 40),
                      children: const [
                        AppTooltip(message: 'Mobile View', child: Icon(Icons.phone_android, size: 20)),
                        AppTooltip(message: 'Desktop View', child: Icon(Icons.desktop_windows, size: 20)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                // Language Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ngôn ngữ', style: const TextStyle(fontWeight: FontWeight.w500)),
                    AppTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onChangeLanguage();
                      },
                      icon: Icons.language,
                      textColor: AppColors.primary,
                      label: languageCode.toUpperCase(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.headerBackground,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (isMobileView)
                AppIconButton(
                  icon: Icons.menu,
                  color: AppColors.primary,
                  onPressed: onMenuPressed,
                  tooltip: l10n.appName, // Fallback tooltip
                ),
              
              if (!isMobileView) ...[
                const SizedBox(width: 8),
                const Icon(Icons.store_rounded, color: AppColors.primary, size: 32),
                const SizedBox(width: 8),
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ] else ...[
                // On Mobile view, show screen title centered
                const Spacer(),
                Text(
                  currentTitle ?? l10n.appName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
              ],

              if (!isMobileView) ...[
                const Spacer(),
                // View Toggle
                Row(
                  children: [
                    ToggleButtons(
                      isSelected: [isMobileView, !isMobileView], // [Mobile, Desktop]
                      onPressed: (index) {
                        if ((index == 0 && !isMobileView) || (index == 1 && isMobileView)) {
                          onToggleView();
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: AppColors.primary,
                      color: AppColors.textSecondary,
                      constraints: const BoxConstraints(minHeight: 36, minWidth: 40),
                      children: const [
                        AppTooltip(message: 'Mobile View', child: Icon(Icons.phone_android, size: 20)),
                        AppTooltip(message: 'Desktop View', child: Icon(Icons.desktop_windows, size: 20)),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const VerticalDivider(width: 1, indent: 20, endIndent: 20),
                    const SizedBox(width: 8),
                    // Language Toggle
                    AppTextButton(
                      onPressed: onChangeLanguage,
                      icon: Icons.language,
                      textColor: AppColors.primary,
                      label: languageCode.toUpperCase(),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // User Info & Logout
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      authenticated: (user) => Row(
                        children: [
                          const Icon(Icons.account_circle, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Text(
                            user.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 16),
                          AppIconButton(
                            icon: Icons.logout,
                            color: AppColors.textSecondary,
                            tooltip: l10n.logout,
                            onPressed: () {
                              context.read<AuthBloc>().add(const AuthEvent.logout());
                            },
                          ),
                        ],
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ] else ...[
                // 3-dot menu for mobile (Bottom Sheet)
                AppIconButton(
                  icon: Icons.more_vert,
                  color: AppColors.primary,
                  tooltip: l10n.appName, // fallback
                  onPressed: () => _showMobileMenu(context, l10n),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
