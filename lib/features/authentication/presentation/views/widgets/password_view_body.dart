import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/auth_model.dart';
import 'package:linkai/features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';

class PasswordViewBody extends StatefulWidget {
  const PasswordViewBody({super.key});

  @override
  State<PasswordViewBody> createState() => _PasswordViewBodyState();
}

class _PasswordViewBodyState extends State<PasswordViewBody> {
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
                    "Setup Password",
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
                        hintText: "Password",
                        validator: (value) {
                          return value!.length < 6 ? "Password must be at least 6 characters long" : null;
                        },
                        onSaved: (value) async {
                          ServiceLocator.getIt<AuthModel>().password = value;
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
                        await BlocProvider.of<LoginCubit>(context).login(ServiceLocator.getIt<AuthModel>());
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
