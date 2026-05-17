import 'package:flutter/material.dart';

class TwoColumnLayout extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;
  final bool isMobileView;

  const TwoColumnLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
    required this.isMobileView,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobileView) {
      return Column(
        children: [
          leftChild,
          Expanded(child: rightChild),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: leftChild,
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: rightChild,
        ),
      ],
    );
  }
}
