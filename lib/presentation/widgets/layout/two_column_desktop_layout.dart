import 'package:flutter/material.dart';

class TwoColumnDesktopLayout extends StatelessWidget {
  final Widget leftContent;
  final Widget rightContent;
  final int leftFlex;
  final int rightFlex;

  const TwoColumnDesktopLayout({
    super.key,
    required this.leftContent,
    required this.rightContent,
    this.leftFlex = 1,
    this.rightFlex = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          flex: leftFlex,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: leftContent,
          ),
        ),
        const VerticalDivider(width: 1),
        // Right Column
        Expanded(
          flex: rightFlex,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: rightContent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
