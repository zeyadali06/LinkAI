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
  State<PasswordConfirmationViewBody> createState() => _PasswordConfirmationViewBodyState();
}

class _PasswordConfirmationViewBodyState extends State<PasswordConfirmationViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
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
            autovalidateMode: autovalidatemodel,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Confirm Your Password",
                    style: AppStyles.normal18(context),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    children: [
                      Text(
                        ServiceLocator.getIt<AuthModel>().email!,
                        style: AppStyles.semiBold18(context),
                      ),
                      const SizedBox(height: 25),
                      CustomObsecureTextField(
                        hintText: "Repeat Password",
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be at least 6 characters long";
                          }

                          if (value != ServiceLocator.getIt<AuthModel>().password) {
                            return "Wrong confirmation";
                          }
                          return null;
                        },
                        onSaved: (value) async {
                          ServiceLocator.getIt<AuthModel>().confirmPassword = value;
                        },
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        GoRouter.of(context).push(AppRouter.nameView);
                      } else {
                        autovalidatemodel = AutovalidateMode.always;
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
}
