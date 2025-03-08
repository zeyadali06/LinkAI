import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
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
        image: DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.contain,
          opacity: 1,
          repeat: ImageRepeat.repeatX,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0x00000000),
              const Color(0xff0f1151).withValues(alpha: .5),
              const Color(0xff232d8e).withValues(alpha: .7),
              const Color(0xff4559c6),
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
                              validator: (value) {
                                if (!RegExp(Formatters.emailRegEx).hasMatch(value!)) {
                                  return "Enter valid email!";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                ServiceLocator.getIt<LoginModel>().email = value;
                              },
                              borderColor: Colors.white.withValues(alpha: 0.3),
                              fillColor: Colors.white.withValues(alpha: .15),
                              hintColor: Colors.white,
                              cursorColor: Colors.white,
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            CustomButton(
                              text: "Sign In or Sign up",
                              buttonColor: Colors.black,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  GoRouter.of(context).go(AppRouter.passwordView);
                                } else {
                                  _autovalidateMode = AutovalidateMode.always;
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).go(AppRouter.forgetPasswordView);
                              },
                              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
                              child: Text(
                                "Forget Password",
                                style: AppStyles.defaultStyle(context, Colors.white),
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
      ),
    );
  }
}
