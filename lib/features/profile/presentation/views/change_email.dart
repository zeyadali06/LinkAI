import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
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
      // TODO: Handle Save Logic
      GoRouter.of(context).pop();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Theme.of(context).iconTheme.color,
          centerTitle: true,
          title: Text(
            "Change Email",
            style: AppStyles.normal18(context),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _nextPage();
                } else {
                  _autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
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
  }
}
