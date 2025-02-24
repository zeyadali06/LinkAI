import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
  const PinCodeField({
    super.key,
    this.controller,
    this.height = 50,
    this.width = 50,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final double height;
  final double width;
  final int length;
  final void Function(String value)? onChanged;
  final void Function(String value)? onCompleted;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      obscureText: obscureText,
      animationType: AnimationType.fade,
      cursorColor: Colors.grey,
      enableActiveFill: true,
      controller: controller,
      keyboardType: TextInputType.number,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      onCompleted: onCompleted,
      onChanged: onChanged,
      beforeTextPaste: (text) => false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16),
        fieldHeight: height,
        fieldWidth: width,
        activeColor: Colors.grey,
        activeFillColor: Colors.transparent,
        activeBorderWidth: 1,
        inactiveColor: Colors.grey.withValues(alpha: .2),
        inactiveFillColor: Colors.transparent,
        inactiveBorderWidth: 1,
        selectedColor: Colors.grey,
        selectedFillColor: Colors.transparent,
        selectedBorderWidth: 1,
      ),
    );
  }
}
