import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
  });
  final String title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        if (subTitle != null)
          Text(
            subTitle!,
            style: subTitleStyle,
          ),
      ],
    );
  }
}
