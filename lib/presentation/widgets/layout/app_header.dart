import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class AppHeader extends StatelessWidget {
  final bool isMobileView;
  final String languageCode;
  final VoidCallback onToggleView;
  final VoidCallback onChangeLanguage;
  final VoidCallback? onMenuPressed;

  const AppHeader({
    super.key,
    required this.isMobileView,
    required this.languageCode,
    required this.onToggleView,
    required this.onChangeLanguage,
    this.onMenuPressed,
  });

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
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.primary),
              onPressed: onMenuPressed,
            ),
          const SizedBox(width: 8),
          const Icon(Icons.store_rounded, color: AppColors.primary, size: 32),
          if (!isMobileView) ...[
            const SizedBox(width: 8),
            Text(
              l10n.appName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
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
                  Tooltip(message: 'Mobile View', child: Icon(Icons.phone_android, size: 20)),
                  Tooltip(message: 'Desktop View', child: Icon(Icons.desktop_windows, size: 20)),
                ],
              ),
              if (!isMobileView) ...[
                const SizedBox(width: 8),
                const VerticalDivider(width: 1, indent: 20, endIndent: 20),
                const SizedBox(width: 8),
                // Language Toggle
                TextButton.icon(
                  onPressed: onChangeLanguage,
                  icon: const Icon(Icons.language, color: AppColors.textSecondary),
                  label: Text(
                    languageCode.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: 16),
          // User Info & Logout
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (user) => Row(
                  children: [
                    if (!isMobileView) ...[
                      const Icon(Icons.account_circle, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 16),
                    ],
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppColors.textSecondary),
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
        ],
      ),
        ),
      ),
    );
  }
}
