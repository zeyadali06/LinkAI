import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
   PinCodeField({
    super.key,
    this.controller,
    this.height = 50,
    this.width = 50,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController? controller;
  final double height;
  final double width;
  final int length;
  final void Function(String value)? onChanged;
  final void Function(String value)? onCompleted;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: validator,
      inputFormatters: inputFormatters ?? [],
      appContext: context,
      length: length,
      obscureText: obscureText,
      animationType: AnimationType.fade,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      enableActiveFill: true,
      controller: controller,
      keyboardType: TextInputType.number,
      textStyle: AppStyles.semiBold18(context),
      onCompleted: onCompleted,
      onChanged: onChanged,
      beforeTextPaste: (text) => false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16),
        fieldHeight: height,
        fieldWidth: width,
        activeColor: Theme.of(context).inputDecorationTheme.activeIndicatorBorder!.color,
        activeFillColor: Theme.of(context).inputDecorationTheme.fillColor,
        activeBorderWidth: 1,
        inactiveColor: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
        inactiveFillColor: Theme.of(context).inputDecorationTheme.fillColor,
        inactiveBorderWidth: 1,
        selectedColor: Theme.of(context).inputDecorationTheme.activeIndicatorBorder!.color,
        selectedFillColor: Theme.of(context).inputDecorationTheme.fillColor,
        selectedBorderWidth: 1,
      ),
    );
  }
}
