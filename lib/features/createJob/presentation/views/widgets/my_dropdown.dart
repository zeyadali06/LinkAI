import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.enableValidator = true,
  });

  final String label;
  final List<String> items;
  final String? value;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final bool enableValidator;

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  bool foucsed = false;
  late Color hintColor;
  late Color textColor;
  late Color borderColor;

  @override
  void didChangeDependencies() {
    setColors();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        foucsed = value;
      },
      child: DropdownButtonFormField<String>(
        value: widget.value,
        validator: (value) {
          if (widget.enableValidator) {
            if (value == null || value.isEmpty) {
              hintColor = Colors.red;
              textColor = Colors.red;
              borderColor = Colors.red;
              setState(() {});
              return "Field is required";
            } else if (foucsed) {
              setColors();
              setState(() {});
            }

            if (widget.validator != null) {
              String? res = widget.validator!(value);
              if (res != null) {
                hintColor = Colors.red;
                textColor = Colors.red;
                borderColor = Colors.red;
                setState(() {});
                return res;
              } else {
                setColors();
                setState(() {});
              }
            }
          }
          return null;
        },
        onChanged: widget.onChanged,
        iconEnabledColor: textColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          labelText: widget.label,
          labelStyle: AppStyles.defaultStyle(context, hintColor),
          errorStyle: AppStyles.defaultStyle(context, textColor),
          border: outlineInputBorder(context, 1),
          enabledBorder: outlineInputBorder(context, 1),
          focusedBorder: outlineInputBorder(context, 2),
          errorBorder: outlineInputBorder(context, 1),
          focusedErrorBorder: outlineInputBorder(context, 2),
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(BuildContext context, double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        width: width,
        color: borderColor,
      ),
    );
  }

  setColors() {
    hintColor = Theme.of(context).hintColor;
    borderColor = Theme.of(context).inputDecorationTheme.border!.borderSide.color;
    textColor = Theme.of(context).textTheme.bodyLarge!.color!;
  }
}
