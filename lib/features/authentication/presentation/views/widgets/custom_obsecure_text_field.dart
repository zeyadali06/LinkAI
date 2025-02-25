import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomObsecureTextField extends StatefulWidget {
  const CustomObsecureTextField({
    super.key,
    this.hintText,
    this.hintColor,
    this.textColor,
    this.cursorColor,
    this.suffixIconColor,
    this.borderWidth = 1,
    this.borderColor,
    this.controller,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.enableValidator = true,
    this.fillColor,
    this.borderRadius = 16,
    this.obscureText = true,
  });

  final String? hintText;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? suffixIconColor;
  final double borderWidth;
  final double borderRadius;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final bool enableValidator;
  final bool obscureText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomObsecureTextField> createState() => _CustomObsecureTextFieldState();
}

class _CustomObsecureTextFieldState extends State<CustomObsecureTextField> {
  bool foucsed = false;
  late IconData eyeIcon;
  late Color hintColor;
  late Color textColor;
  late Color cursorColor;
  late Color borderColor;
  late Color fillColor;
  late Color suffixIconColor;
  late bool obscureText;

  @override
  void initState() {
    eyeIcon = Icons.remove_red_eye_outlined;
    obscureText = widget.obscureText;
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
              suffixIconColor = Colors.red;
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
        style: TextStyle(color: textColor),
        obscureText: obscureText,
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
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    obscureText = !obscureText;
                    if (eyeIcon == Icons.remove_red_eye_outlined) {
                      eyeIcon = Icons.remove_red_eye;
                    } else {
                      eyeIcon = Icons.remove_red_eye_outlined;
                    }
                    setState(() {});
                  },
                  icon: Icon(eyeIcon, color: suffixIconColor),
                )
              : null,
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
    suffixIconColor = widget.suffixIconColor ?? Theme.of(context).inputDecorationTheme.suffixIconColor!;
    borderColor = widget.borderColor ?? Theme.of(context).inputDecorationTheme.border!.borderSide.color;
    fillColor = widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor!;
    textColor = widget.textColor ?? Theme.of(context).textTheme.bodyLarge!.color!;
  }
}
