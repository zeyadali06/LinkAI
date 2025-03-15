import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/profile/presentation/views/widgets/passwordWidgets/change_password_new_pass_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/passwordWidgets/change_password_old_pass_body.dart';
import 'package:linkai/features/profile/presentation/views/widgets/passwordWidgets/confirm_password_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/widgets/snack_bar.dart';
import '../managers/change_password_cubit/change_password_cubit.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  int _selectedIndex = 0;
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autoValidateMode;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late PageController _pageController;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidateMode = AutovalidateMode.disabled;
    oldPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _pageController = PageController();

    _screens = [
      ChangePasswordOldPassBody(controller: oldPasswordController),
      ChangePasswordNewPassBody(controller: newPasswordController),
      ConfirmPasswordBody(
        newPasswordController: newPasswordController,
        confirmPasswordController: confirmPasswordController,
      )
    ];
  }

  void _nextPage(BuildContext context, String oldPassword, String newPassword) async {
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
      ChangePasswordCubit cubit = ChangePasswordCubit.get(context);
      await cubit.changePassword(oldPassword, newPassword);


    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showSnackBar(context, "Password changed successfully",
                backgroundColor: Colors.green);
            Navigator.pop(context);
          }
          if (state is ChangePasswordFailure) {
            showSnackBar(context, state.errorMessage);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {

          return ModalProgressHUD(
            inAsyncCall: state is ChangePasswordLoading,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text("Change Password"),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _nextPage(context, oldPasswordController.text, newPasswordController.text);
                      } else {
                        _autoValidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    child: Text(
                      _selectedIndex + 1 == _screens.length ? "Save" : "Next",
                      style: AppStyles.normal18(context, Colors.white),
                    ),
                  )
                ],
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: _screens,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
