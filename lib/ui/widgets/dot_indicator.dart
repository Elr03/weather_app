import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.pageIndex,
    required this.index,
  });
  final int pageIndex;
  final int index;

  bool get isActive => index == pageIndex;
  double get dotSize => 8;
  Color get colorDot =>
      isActive ? Colors.purple : Colors.purple.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      height: dotSize,
      width: dotSize,
      decoration: BoxDecoration(
        color: colorDot,
        shape: BoxShape.circle,
      ),
    );
  }
}
