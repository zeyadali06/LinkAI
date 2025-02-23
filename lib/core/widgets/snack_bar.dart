import 'package:flutter/material.dart';

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
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 1, milliseconds: 500),
    ),
  );
}
