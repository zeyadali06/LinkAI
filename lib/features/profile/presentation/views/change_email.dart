import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/profile/presentation/managers/change_email_cubit/change_email_cubit.dart';
import 'package:linkai/features/profile/presentation/views/widgets/emailWidgets/change_email_pass_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/emailWidgets/new_email_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/emailWidgets/new_email_pin_body.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  int _selectedIndex = 0;
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autoValidateMode;
  late TextEditingController passwordController;
  late TextEditingController pinController;
  late TextEditingController newEmailController;
  late PageController _pageController;
  late List<Widget> _screens;
  String? _token;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidateMode = AutovalidateMode.disabled;
    passwordController = TextEditingController();
    newEmailController = TextEditingController();
    pinController = TextEditingController();
    _pageController = PageController();

    _screens = [
      ChangeEmailPassBody(controller: passwordController),
      NewEmailBody(controller: newEmailController),
      NewEmailPinBody(
        controller: pinController,
        email: newEmailController,
        token: _token,
      ),
    ];
  }

  void _nextPage() {
    if (_selectedIndex < _screens.length - 1) {
      _pageController.animateToPage(
        _selectedIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _selectedIndex++;
      });
    } else {
      // Handle final submission
      _handleFinalSubmission();
    }
  }

  void _handleFinalSubmission() {
    if (_token != null) {
      ChangeEmailCubit.get(context).enterNewEmail(
        pinController.text,
        newEmailController.text,
      );
    }
  }

  void _handleNextAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedIndex == 0) {
        // Check password
        ChangeEmailCubit.get(context).checkPassword(passwordController.text);
      } else if (_selectedIndex == 1) {
        // Send OTP
        if (_token != null) {
          ChangeEmailCubit.get(context).sendOTP(_token!, newEmailController.text);
        }
      } else {
        _nextPage();
      }
    } else {
      _autoValidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    passwordController.dispose();
    newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
      listener: (context, state) {
        if (state is ChangeEmailCheckPasswordSuccess) {
          _token = state.token;
          _nextPage();
        } else if (state is ChangeEmailSendOTPSuccess) {
          _nextPage();
        } else if (state is ChangeEmailEnterNewEmailSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          GoRouter.of(context).pop();
        } else if (state is ChangeEmailCheckPasswordFailure || state is ChangeEmailSendOTPFailure || state is ChangeEmailEnterNewEmailFailure) {
          String errorMessage = '';
          if (state is ChangeEmailCheckPasswordFailure) {
            errorMessage = state.errorMessage;
          } else if (state is ChangeEmailSendOTPFailure) {
            errorMessage = state.errorMessage;
          } else if (state is ChangeEmailEnterNewEmailFailure) {
            errorMessage = state.errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).iconTheme.color,
              centerTitle: true,
              title: Text(
                "Change Email",
                style: AppStyles.semiBold18(context),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => GoRouter.of(context).pop(),
              ),
              actions: [
                TextButton(
                  onPressed: (state is ChangeEmailCheckPasswordLoading || state is ChangeEmailSendOTPLoading || state is ChangeEmailEnterNewEmailLoading) ? null : _handleNextAction,
                  child: Text(
                    _selectedIndex + 1 == _screens.length ? "Submit" : "Next",
                    style: AppStyles.defaultStyle(context),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            body: Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: _screens,
                  ),
                  if (state is ChangeEmailCheckPasswordLoading || state is ChangeEmailSendOTPLoading || state is ChangeEmailEnterNewEmailLoading)
                    Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
