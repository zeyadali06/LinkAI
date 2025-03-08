import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/login_model.dart';
import 'package:linkai/features/authentication/data/models/register_model.dart';
import 'package:linkai/features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/password_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          GoRouter.of(context).go(AppRouter.homeView);
        } else if (state is CompleteRegister) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  "It seems that you don't have an account or the credentials are invalid. Do you want to register?",
                  style: AppStyles.normal18(context),
                ),
                actions: [
                  CustomButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    padding: const EdgeInsets.all(20),
                    fitWidth: true,
                    textAlign: TextAlign.center,
                    text: "Re-enter credentials",
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    onPressed: () {
                      ServiceLocator.getIt<RegisterModel>().email = ServiceLocator.getIt<LoginModel>().email;
                      ServiceLocator.getIt<RegisterModel>().password = ServiceLocator.getIt<LoginModel>().password;
                      ServiceLocator.getIt<LoginModel>().email = null;
                      ServiceLocator.getIt<LoginModel>().password = null;

                      GoRouter.of(context).go(AppRouter.passwordConfimationView);
                    },
                    padding: const EdgeInsets.all(20),
                    fitWidth: true,
                    textAlign: TextAlign.center,
                    text: "Continue to signup",
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: const Scaffold(
            body: PasswordViewBody(),
          ),
        );
      },
    );
  }
}
