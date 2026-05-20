import 'package:flutter/material.dart';

/// Centralized color definitions for the app.
/// All UI code MUST use these instead of hardcoded colors.
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);

  // Status
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);
  static const Color warning = Color(0xFFF9A825);

  // Role badges
  static const Color ownerBadge = Color(0xFFFFF8E1);
  static const Color employeeBadge = Color(0xFFE3F2FD);

  // Layout
  static const Color headerBackground = Colors.white;
  static const Color navBarBackground = Color(0xFF0073B7); // blue
  static const Color navBarSelected = Color(0xFF005688); // Darker blue for selected tab
  static const Color background = Color(0xFFF4F5F7); // Light gray background

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFE0E0E0);
}
