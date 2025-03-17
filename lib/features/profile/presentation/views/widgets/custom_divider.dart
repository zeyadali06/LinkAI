import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.indent = 16,
    this.endIndent = 0,
    this.height = 1,
  });

  final double indent;
  final double endIndent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
      indent: indent,
      endIndent: endIndent,
      height: height,
    );
  }
}
