import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/enums/role_enum.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/presentation/manager/otp_cubit/otp_cubit.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidatemodel;
  bool _passwordsMatch = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidatemodel = AutovalidateMode.disabled;
    ServiceLocator.getIt<AuthModel>().role = Role.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidatemodel,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: SizedBox(height: 25)),
                  Text(
                    "Signup",
                    style: AppStyles.bold22(context),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomTextField(
                    hintText: "First name",
                    inputFormatters: [Formatters.namesFormatter],
                    validator: (value) {
                      if (value!.length < 3) {
                        return "First name must be at least 3 characters long.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ServiceLocator.getIt<AuthModel>().firstName = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Last name",
                    inputFormatters: [Formatters.namesFormatter],
                    validator: (value) {
                      if (value!.length < 3) {
                        return "First name must be at least 3 characters long.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ServiceLocator.getIt<AuthModel>().lastName = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    validator: (value) {
                      if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value!)) {
                        return "Enter valid phone number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // ServiceLocator.getIt<RegisterModel>().phoneNumber = "${countryCode.code}$value";
                      ServiceLocator.getIt<AuthModel>().phoneNumber = value;
                    },
                    inputFormatters: [Formatters.numbersOnlyFormatter],
                    hintText: "Phone Number",
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Email',
                    validator: (value) {
                      if (!RegExp(Formatters.emailRegEx).hasMatch(value!)) {
                        return "Enter valid email!";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ServiceLocator.getIt<AuthModel>().email = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomObsecureTextField(
                    hintText: "Password",
                    validator: _validateConfirmPassword,
                    onChanged: (value) async {
                      _checkPasswordsMatch(value);
                      ServiceLocator.getIt<AuthModel>().password = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomObsecureTextField(
                    hintText: "Repeat Password",
                    validator: _validateConfirmPassword,
                    onChanged: _checkPasswordsMatch,
                    onSaved: (value) => ServiceLocator.getIt<AuthModel>().confirmPassword = value,
                  ),
                  const SizedBox(height: 5),
                  // _buildPasswordMatchMessage(),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12), //
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, left: 16),
                          child: Text(
                            "Role",
                            style: AppStyles.normal16(context), //
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildThemeOption(
                              context,
                              title: "User",
                              icon: Icons.person,
                              isSelected: ServiceLocator.getIt<AuthModel>().role == Role.user,
                              onTap: () {
                                ServiceLocator.getIt<AuthModel>().role = Role.user;
                                setState(() {});
                              },
                            ),
                            _buildThemeOption(
                              context,
                              title: "HR",
                              icon: Icons.business,
                              isSelected: ServiceLocator.getIt<AuthModel>().role == Role.hr,
                              onTap: () {
                                ServiceLocator.getIt<AuthModel>().role = Role.hr;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await BlocProvider.of<OtpCubit>(context).sendOTP(ServiceLocator.getIt<AuthModel>().email!);
                      } else {
                        _autovalidatemodel = AutovalidateMode.always;
                        setState(() {});
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

  void _checkPasswordsMatch(String? confirmPassword) {
    if (confirmPassword == null) return;

    final doMatch = confirmPassword.isNotEmpty && confirmPassword == ServiceLocator.getIt<AuthModel>().password;

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
    if (value.length < 6) {
      return "At least 6 characters";
    }
    if (value != ServiceLocator.getIt<AuthModel>().password) {
      return "Passwords do not match";
    }
    return null;
  }

  // Widget _buildPasswordMatchMessage() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     decoration: BoxDecoration(
  //       color: _passwordsMatch ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(
  //           _passwordsMatch ? Icons.check_circle : Icons.error,
  //           color: _passwordsMatch ? Colors.green : Colors.red,
  //           size: 20,
  //         ),
  //         const SizedBox(width: 8),
  //         Text(
  //           _confirmationMessage,
  //           style: TextStyle(
  //             color: _passwordsMatch ? Colors.green : Colors.red,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildThemeOption(
    BuildContext context, {
    required final String title,
    required final IconData icon,
    required final bool isSelected,
    required final void Function() onTap, //
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? Colors.purple : Colors.transparent, width: 2),
            ),
            child: Icon(icon, size: 30, color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(height: 8),
          Text(title, style: AppStyles.defaultStyle(context)),
        ],
      ),
    );
  }
}
