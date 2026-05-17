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

  // Text
  static const Color textSecondary = Color(0xFF757575);
}
