import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkai/core/utils/app_styles.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    this.hintText,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.borderColor,
    this.fillColor,
    this.borderWidth = 1,
    this.controller,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.enableValidator = true,
    this.borderRadius = 16,
  });

  final String? hintText;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onSaved;
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
  late Color fillColor;

  @override
  void initState() {
    eyeIcon = Icons.remove_red_eye_outlined;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setColors();
    super.didChangeDependencies();
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
              setColors();

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
        style: AppStyles.defaultStyle(context, textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          alignLabelWithHint: true,
          labelText: widget.hintText,
          labelStyle: AppStyles.defaultStyle(context, hintColor),
          errorStyle: AppStyles.defaultStyle(context, textColor),
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

  setColors() {
    cursorColor = widget.cursorColor ?? Theme.of(context).textSelectionTheme.cursorColor!;
    hintColor = widget.hintColor ?? Theme.of(context).hintColor;
    borderColor = widget.borderColor ?? Theme.of(context).inputDecorationTheme.border!.borderSide.color;
    fillColor = widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor!;
    textColor = widget.textColor ?? Theme.of(context).textTheme.bodyLarge!.color!;
  }
}
