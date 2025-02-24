import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/custom_obsecure_text_field.dart';

class PasswordViewBody extends StatefulWidget {
  const PasswordViewBody({super.key});

  @override
  State<PasswordViewBody> createState() => _PasswordViewBodyState();
}

class _PasswordViewBodyState extends State<PasswordViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                  const Text(
                    "Setup Password",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    children: [
                      const Text(
                        "z01551153743@gmail.com",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 25),
                      CustomObsecureTextField(
                        hintText: "Password",
                        controller: passwordController,
                        cursorColor: Colors.grey,
                        hintColor: Colors.grey,
                        suffixIconColor: Colors.grey,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  CustomButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text != confirmPasswordController.text) {
                          showSnackBar(context, "Wrong confirmation password", Colors.white, Colors.red);
                        } else {}
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
