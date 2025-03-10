import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color!),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor!,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: outlineInputBorder(context, 2),
        enabledBorder: outlineInputBorder(context, 2),
        focusedBorder: outlineInputBorder(context, 1),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(BuildContext context, double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        width: width,
        color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
      ),
    );
  }
}
