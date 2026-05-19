import 'package:flutter/material.dart';
import '../app_tooltip.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final Color? color;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip, // Bắt buộc phải có tooltip
    required this.onPressed,
    this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppTooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: size),
        color: color,
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }
}
