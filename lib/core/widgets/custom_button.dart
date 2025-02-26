import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height = 55,
    this.fitWidth = true,
    this.textColor,
    this.buttonColor,
    this.splashColor,
    this.highlightColor,
  });

  final void Function()? onPressed;
  final String text;
  final double height;
  final bool fitWidth;
  final Color? textColor;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    if (fitWidth) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: height,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: buttonColor ?? Theme.of(context).filledButtonTheme.style!.backgroundColor!.resolve({}),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: MaterialButton(
                onPressed: onPressed,
                splashColor: splashColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
                highlightColor: highlightColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
                child: Text(
                  text,
                  style: AppStyles.normal18(
                    context,
                    textColor ?? Theme.of(context).filledButtonTheme.style!.foregroundColor!.resolve({}),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).filledButtonTheme.style!.backgroundColor!.resolve({}),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          splashColor: splashColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
          highlightColor: highlightColor ?? Theme.of(context).filledButtonTheme.style!.overlayColor!.resolve({}),
          child: Text(
            text,
            style: AppStyles.normal18(
              context,
              textColor ?? Theme.of(context).filledButtonTheme.style!.foregroundColor!.resolve({}),
            ),
          ),
        ),
      );
    }
  }
}
