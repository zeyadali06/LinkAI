import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height,
    this.fitWidth = true,
    this.textColor,
    this.buttonColor,
    this.splashColor,
    this.highlightColor,
    this.gradient,
    this.textAlign,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  });

  final void Function()? onPressed;
  final String text;
  final double? height;
  final bool fitWidth;
  final Color? textColor;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? highlightColor;
  final Gradient? gradient;
  final TextAlign? textAlign;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (fitWidth) {
      return Row(
        children: [
          Expanded(
            child: getButton(context),
          ),
        ],
      );
    } else {
      return getButton(context);
    }
  }

  Widget getButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: MaterialButton(
        height: height,
        onPressed: onPressed,
        color: gradient == null ? (buttonColor ?? Theme.of(context).filledButtonTheme.style!.backgroundColor!.resolve({})) : null,
        splashColor: splashColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
        highlightColor: highlightColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
        padding: padding,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Text(
          text,
          textAlign: textAlign,
          style: AppStyles.normal18(
            context,
            textColor ?? Theme.of(context).filledButtonTheme.style!.foregroundColor!.resolve({}),
          ),
        ),
      ),
    );
  }
}
