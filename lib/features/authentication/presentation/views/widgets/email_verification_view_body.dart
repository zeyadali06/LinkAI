import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/pin_code_field.dart';

class EmailVerificationViewBody extends StatefulWidget {
  const EmailVerificationViewBody({super.key});

  @override
  State<EmailVerificationViewBody> createState() => _EmailVerificationViewBodyState();
}

class _EmailVerificationViewBodyState extends State<EmailVerificationViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    super.initState();
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
                    Text(
                      "Verification",
                      style: AppStyles.normal18(context),
                    ),
                    const Expanded(child: SizedBox(height: 25)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 68,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Enter the verification code we sent to",
                          style: AppStyles.defaultStyle(context),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "z01551153743@gmail.com",
                          style: AppStyles.semiBold18(context),
                        ),
                        const SizedBox(height: 25),
                        PinCodeField(
                          onCompleted: (value) {},
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                            backgroundColor: Theme.of(context).textButtonTheme.style!.backgroundColor,
                            overlayColor: Theme.of(context).textButtonTheme.style!.overlayColor,
                          ),
                          child: Text(
                            "Resend",
                            style: AppStyles.defaultStyle(context, Theme.of(context).textButtonTheme.style!.foregroundColor!.resolve({})),
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
