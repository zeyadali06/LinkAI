import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle Function(BuildContext context, [Color? color]) normal18 = (context, [color]) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) normal16 = (context, [color]) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) normal20 = (context, [color]) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) defaultStyle = (context, [color]) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) bold14 = (context, [color]) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) semiBold18 = (context, [color]) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) bold18 = (context, [color]) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );

  static TextStyle Function(BuildContext context, [Color? color]) bold22 = (context, [color]) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      );
}
