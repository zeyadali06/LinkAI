import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';

class NameViewBody extends StatefulWidget {
  const NameViewBody({super.key});

  @override
  State<NameViewBody> createState() => _NameViewBodyState();
}

class _NameViewBodyState extends State<NameViewBody> {
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
                    "Add more information",
                    style: AppStyles.normal18(context),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    children: [
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
                      const SizedBox(height: 25),
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
                      const SizedBox(height: 25),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        GoRouter.of(context).push(AppRouter.roleView);
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
