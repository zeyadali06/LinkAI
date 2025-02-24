import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/custom_obsecure_text_field.dart';

class PasswordConfirmationViewBody extends StatefulWidget {
  const PasswordConfirmationViewBody({super.key});

  @override
  State<PasswordConfirmationViewBody> createState() => _PasswordConfirmationViewBodyState();
}

class _PasswordConfirmationViewBodyState extends State<PasswordConfirmationViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
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
                        hintText: "Repeat Password",
                        controller: confirmPasswordController,
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
