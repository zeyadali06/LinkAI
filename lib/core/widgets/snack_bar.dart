import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

void showSnackBar(
  BuildContext context,
  String text, [
  Color textColor = Colors.white,
  Color backgroundColor = Colors.green,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: AppStyles.defaultStyle(context, textColor),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 1, milliseconds: 500),
    ),
  );
}
