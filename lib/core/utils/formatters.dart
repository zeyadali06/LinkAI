import 'package:flutter/services.dart';

abstract class Formatters {
  static final FilteringTextInputFormatter preventSpacesFormatter = FilteringTextInputFormatter.deny(RegExp(' '));

  static final FilteringTextInputFormatter emailOrUsernameFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9_@.]"));

  static final FilteringTextInputFormatter emailFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@.]"));

  static final FilteringTextInputFormatter usernamesFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9_]"));

  static final FilteringTextInputFormatter namesFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"));

  static final FilteringTextInputFormatter pricesFormatter = FilteringTextInputFormatter.allow(RegExp(r"[0-9]*\.?[0-9]*"));

  static final FilteringTextInputFormatter phoneNumbersFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'));

  static final TextInputFormatter numbersOnlyFormatter = FilteringTextInputFormatter.digitsOnly;

  static const String emailRegEx = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$';

  static const String usernameRegEx = r'[a-zA-Z0-9_]';

  static const String nameRegEx = r'[a-zA-Z]';

  // to prevent user to input price 0.0
  static final TextInputFormatter correctPrice0 = TextInputFormatter.withFunction((oldValue, newValue) {
    if (oldValue.text == '' && newValue.text == '.') {
      return const TextEditingValue(text: '0.');
    } else {
      return newValue;
    }
  });

  static final toUpperCase = _UpperCaseTextFormatter();

  static LengthLimitingTextInputFormatter limitInput(int number) {
    return LengthLimitingTextInputFormatter(number);
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
