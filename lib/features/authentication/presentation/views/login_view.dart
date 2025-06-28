import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/login_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).go(AppRouter.navigatorView);
        } else if (state is LoginFailed) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: const Scaffold(
            backgroundColor: Colors.black,
            body: LoginViewBody(),
          ),
        );
      },
    );
  }
}
