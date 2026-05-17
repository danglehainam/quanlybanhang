import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class AppHeader extends StatelessWidget {
  final bool isMobileView;
  final VoidCallback onToggleView;
  final VoidCallback? onMenuPressed;

  const AppHeader({
    super.key,
    required this.isMobileView,
    required this.onToggleView,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 60,
      color: AppColors.headerBackground,
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
          const SizedBox(width: 8),
          Text(
            l10n.appName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          // View Toggle
          Row(
            children: [
              Text(isMobileView ? l10n.switchDesktop : l10n.switchMobile),
              Switch(
                value: isMobileView,
                onChanged: (_) => onToggleView(),
                activeColor: AppColors.primary,
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
    );
  }
}
