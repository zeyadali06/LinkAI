import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    this.hintText,
    this.hintColor = Colors.black,
    this.textColor = Colors.black,
    this.cursorColor = Colors.black,
    this.borderWidth = 1,
    this.borderColor = const Color(0xffe6e6e6),
    this.controller,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.enableValidator = true,
    this.fillColor = Colors.transparent,
    this.borderRadius = 16,
  });

  final String? hintText;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final Color cursorColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final bool enableValidator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool foucsed = false;
  late IconData eyeIcon;
  late Color hintColor;
  late Color textColor;
  late Color cursorColor;
  late Color borderColor;

  @override
  void initState() {
    hintColor = widget.hintColor;
    textColor = widget.textColor;
    cursorColor = widget.cursorColor;
    borderColor = widget.borderColor;
    eyeIcon = Icons.remove_red_eye_outlined;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        foucsed = focus;
      },
      child: TextFormField(
        validator: (value) {
          if (widget.enableValidator) {
            if (value == null || value.isEmpty) {
              hintColor = Colors.red;
              textColor = Colors.red;
              cursorColor = Colors.red;
              borderColor = Colors.red;
              setState(() {});
              return "Field is required";
            } else if (foucsed) {
              hintColor = widget.hintColor;
              textColor = widget.textColor;
              cursorColor = widget.cursorColor;
              borderColor = widget.borderColor;
              setState(() {});
            }
          }
          return null;
        },
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        controller: widget.controller,
        cursorOpacityAnimates: true,
        cursorColor: cursorColor,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          alignLabelWithHint: true,
          labelText: widget.hintText,
          labelStyle: TextStyle(color: hintColor),
          errorStyle: TextStyle(color: textColor),
          border: outlineInputBorder(widget.borderWidth),
          enabledBorder: outlineInputBorder(widget.borderWidth),
          focusedBorder: outlineInputBorder(widget.borderWidth + 1),
          errorBorder: outlineInputBorder(widget.borderWidth),
          focusedErrorBorder: outlineInputBorder(widget.borderWidth + 1),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      borderSide: BorderSide(width: width, color: borderColor),
    );
  }
}
