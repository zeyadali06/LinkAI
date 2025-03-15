import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';
import '../../../../../../core/utils/app_colors.dart';

class ChangePasswordNewPassBody extends StatefulWidget {
  const ChangePasswordNewPassBody({super.key, required this.controller});

  final TextEditingController controller;

  @override
  _ChangePasswordNewPassBodyState createState() =>
      _ChangePasswordNewPassBodyState();
}

class _ChangePasswordNewPassBodyState extends State<ChangePasswordNewPassBody> {
  double passwordStrength = 0;
  String passwordHint = '';

  void _checkPasswordStrength(String? password) {
    if (password == null) return;

    setState(() {
      passwordStrength = _calculatePasswordStrength(password);
      passwordHint = _getPasswordHint(passwordStrength);
    });
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;

    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    return strength / 5;
  }

  String _getPasswordHint(double strength) {
    if (strength == 0) return 'Enter a password';
    if (strength <= 0.2) return 'Very Weak';
    if (strength <= 0.4) return 'Weak';
    if (strength <= 0.6) return 'Fair';
    if (strength <= 0.8) return 'Strong';
    return 'Very Strong';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomObsecureTextField(
              borderRadius: 16,
              controller: widget.controller,
              hintText: "New password",
              enableValidator: true,
              validator: _validatePassword,
              onChanged: _checkPasswordStrength,
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: passwordStrength,
              backgroundColor: Colors.grey[700],
              valueColor: AlwaysStoppedAnimation<Color>(
                passwordStrength <= 0.4
                    ? Colors.red
                    : passwordStrength <= 0.6
                        ? Colors.orange
                        : passwordStrength <= 0.8
                            ? Colors.yellow
                            : Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              passwordHint,
              style: TextStyle(
                color: passwordStrength <= 0.4 ? Colors.red : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Use 8 or more characters with a mix of letters, numbers & symbols",
              style: AppStyles.normal16(context, Colors.grey)
                  .copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
