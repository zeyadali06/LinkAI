import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/authentication/presentation/manager/otp_cubit/otp_cubit.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/phone_number_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          GoRouter.of(context).push(AppRouter.emailVerificationView);
        } else if (state is OtpFail) {
          showSnackBar(context, state.errMessage, backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is OtpLoading,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            body: const PhoneNumberViewBody(),
          ),
        );
      },
    );
  }
}
