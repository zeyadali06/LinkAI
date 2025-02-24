import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/google_button.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/auth_text_field.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/logo.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff000000),
            Color(0xff0f1151),
            Color(0xff232d8e),
            Color(0xff4559c6),
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Expanded(child: Logo(width: 60)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        children: [
                          GoogleButton(onPressed: () async {}),
                          Divider(
                            height: 40,
                            color: Colors.white.withValues(alpha: .4),
                          ),
                          AuthTextField(
                            hintText: 'Email',
                            onSaved: (value) {},
                            borderColor: Colors.white.withValues(alpha: 0.3),
                            fillColor: Colors.white.withValues(alpha: .15),
                            hintColor: Colors.white,
                            cursorColor: Colors.white,
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            text: "Sign In or Sign up",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              } else {
                                _autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
