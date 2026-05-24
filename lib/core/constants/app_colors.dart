import 'package:flutter/material.dart';

/// Centralized color definitions for the app.
/// All UI code MUST use these instead of hardcoded colors.
class AppColors {
  AppColors._();

  // Primary (Apple Blue)
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryLight = Color(0xFF5AC8FA);

  // Status
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFF9500);

  // Role badges
  static const Color ownerBadge = Color(0xFFFFF8E1);
  static const Color employeeBadge = Color(0xFFE3F2FD);

  // Layout
  static const Color headerBackground = Colors.white;
  static const Color navBarBackground = Color(0xFF007AFF); // Apple blue
  static const Color navBarSelected = Color(0xFF0056B3); // Darker blue for selected tab
  static const Color background = Color(0xFFF2F2F7); // iOS grouped background

  static const Color textPrimary = Color(0xFF000000); // Pure black on iOS
  static const Color textSecondary = Color(0xFF8E8E93); // iOS secondary text
  static const Color divider = Color(0xFFC6C6C8); // iOS separator color
}
