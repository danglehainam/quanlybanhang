import 'package:flutter/material.dart';

/// Shows a form modal responsive to the screen size.
/// Uses a Bottom Sheet on Mobile and an Adaptive Dialog on Desktop.
Future<T?> showAppFormModal<T>({
  required BuildContext context,
  required bool isMobileView,
  required WidgetBuilder builder,
}) {
  if (isMobileView) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: builder,
    );
  } else {
    return showAdaptiveDialog<T>(
      context: context,
      builder: builder,
    );
  }
}

class AppBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
              child: content,
            ),
          ),
          // Actions
          if (actions != null)
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(top: BorderSide(color: Theme.of(context).dividerColor, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: action,
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
