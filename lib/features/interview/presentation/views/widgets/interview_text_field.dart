import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';

class InterviewTextField extends StatelessWidget {
  const InterviewTextField({super.key, this.onChanged, this.onSaved});

  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      style: AppStyles.normal18(context, Theme.of(context).textTheme.bodyLarge!.color),
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        filled: true,
        hintText: 'Send a message...',
        hintStyle: AppStyles.normal18(context, Theme.of(context).hintColor),
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
