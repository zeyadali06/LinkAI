import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/data/models/country_model.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/pin_code_field.dart';

class EmailVerificationViewBody extends StatefulWidget {
  const EmailVerificationViewBody({super.key});

  @override
  State<EmailVerificationViewBody> createState() => _EmailVerificationViewBodyState();
}

class _EmailVerificationViewBodyState extends State<EmailVerificationViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late final TextEditingController phoneController;
  late Country countryCode;
  late String phone;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScrollView(
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
                      "Verification",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const Expanded(child: SizedBox(height: 25)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 68,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Enter the verification code we sent to",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "z01551153743@gmail.com",
                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 25),
                        const PinCodeField(),
                        TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                          child: const Text(
                            "Resend",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox(height: 25)),
                    CustomButton(
                      text: "Continue",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.validate();
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
      ),
    );
  }
}
