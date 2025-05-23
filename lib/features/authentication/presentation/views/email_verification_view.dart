import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/email_verification_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          GoRouter.of(context).go(AppRouter.navigatorView);
        } else if (state is RegisterFailed) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).iconTheme.color,
              forceMaterialTransparency: true,
            ),
            body: const EmailVerificationViewBody(),
          ),
        );
      },
    );
  }
}
