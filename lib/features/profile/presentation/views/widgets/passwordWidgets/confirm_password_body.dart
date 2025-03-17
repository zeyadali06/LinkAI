import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';

class ConfirmPasswordBody extends StatefulWidget {
  const ConfirmPasswordBody({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  State<ConfirmPasswordBody> createState() => _ConfirmPasswordBodyState();
}

class _ConfirmPasswordBodyState extends State<ConfirmPasswordBody> {
  bool _passwordsMatch = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();
    _checkPasswordsMatch(widget.confirmPasswordController.text);
  }

  void _checkPasswordsMatch(String? confirmPassword) {
    if (confirmPassword == null) return;

    final newPassword = widget.newPasswordController.text;
    final doMatch = confirmPassword.isNotEmpty && confirmPassword == newPassword;

    setState(() {
      _passwordsMatch = doMatch;
      _confirmationMessage = confirmPassword.isEmpty
          ? 'Please confirm your password'
          : doMatch
              ? 'Passwords match!'
              : 'Passwords do not match';
    });
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password confirmation is required";
    }
    if (value != widget.newPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomObsecureTextField(
            borderRadius: 16,
            controller: widget.confirmPasswordController,
            hintText: "Confirm password",
            enableValidator: true,
            validator: _validateConfirmPassword,
            onChanged: _checkPasswordsMatch,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: _passwordsMatch ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _passwordsMatch ? Icons.check_circle : Icons.error,
                  color: _passwordsMatch ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _confirmationMessage,
                      style: AppStyles.defaultStyle(context, _passwordsMatch ? Colors.green : Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
