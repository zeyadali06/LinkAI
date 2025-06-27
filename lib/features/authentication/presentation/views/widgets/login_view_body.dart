import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/core/widgets/logo.dart';

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
                      const Expanded(flex: 2, child: Logo(width: 60)),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Divider(
                              height: 40,
                              color: Colors.white.withValues(alpha: .4),
                            ),
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
                              borderColor: Colors.white.withValues(alpha: 0.3),
                              fillColor: Colors.white.withValues(alpha: .15),
                              hintColor: Colors.white,
                              cursorColor: Colors.white,
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            CustomObsecureTextField(
                              hintText: "Password",
                              borderColor: Colors.white.withValues(alpha: 0.3),
                              fillColor: Colors.white.withValues(alpha: .15),
                              hintColor: Colors.white,
                              cursorColor: Colors.white,
                              textColor: Colors.white,
                              validator: (value) {
                                return value!.length < 6 ? "at least 6 characters long" : null;
                              },
                              onSaved: (value) async {
                                ServiceLocator.getIt<AuthModel>().password = value;
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomButton(
                              text: "Sign In",
                              buttonColor: Colors.black,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // GoRouter.of(context).push(AppRouter.passwordView);
                                  await BlocProvider.of<LoginCubit>(context).login(ServiceLocator.getIt<AuthModel>());
                                } else {
                                  _autovalidateMode = AutovalidateMode.always;
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      GoRouter.of(context).push(AppRouter.registerView);
                                    },
                                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
                                    child: Text(
                                      "Signup",
                                      style: AppStyles.defaultStyle(context, Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      GoRouter.of(context).push(AppRouter.forgetPasswordView);
                                    },
                                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
                                    child: Text(
                                      "Forget Password",
                                      style: AppStyles.defaultStyle(context, Colors.white),
                                    ),
                                  ),
                                ),
                              ],
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
