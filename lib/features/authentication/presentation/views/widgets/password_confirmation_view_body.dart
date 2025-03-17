import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';

class PasswordConfirmationViewBody extends StatefulWidget {
  const PasswordConfirmationViewBody({super.key});

  @override
  State<PasswordConfirmationViewBody> createState() =>
      _PasswordConfirmationViewBodyState();
}

class _PasswordConfirmationViewBodyState
    extends State<PasswordConfirmationViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  bool _passwordsMatch = false;
  String _confirmationMessage = '';
  late final AuthModel authModel;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    authModel = ServiceLocator.getIt<AuthModel>();
  }

  void _checkPasswordsMatch(String? confirmPassword) {
    if (confirmPassword == null) return;

    final doMatch =
        confirmPassword.isNotEmpty && confirmPassword == authModel.password;

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
    if (value != authModel.password) {
      return "Passwords do not match";
    }
    return null;
  }

  Widget _buildPasswordMatchMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: _passwordsMatch ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
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
          Text(
            _confirmationMessage,
            style: TextStyle(
              color: _passwordsMatch ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidatemodel,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  Text("Confirm Your Password", style: AppStyles.normal18(context)),
                  const SizedBox(height: 25),
                  Text(authModel.email ?? '', style: AppStyles.semiBold18(context)),
                  const SizedBox(height: 25),
                  CustomObsecureTextField(
                    hintText: "Repeat Password",
                    validator: _validateConfirmPassword,
                    onChanged: _checkPasswordsMatch,
                    onSaved: (value) => authModel.confirmPassword = value,
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordMatchMessage(),
                  const SizedBox(height: 25),
                  CustomButton(
                    text: "Continue",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        GoRouter.of(context).push(AppRouter.nameView);
                      } else {
                        setState(() {
                          autovalidatemodel = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
