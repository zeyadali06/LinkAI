import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/auth_text_field.dart';

class NameViewBody extends StatefulWidget {
  const NameViewBody({super.key});

  @override
  State<NameViewBody> createState() => _NameViewBodyState();
}

class _NameViewBodyState extends State<NameViewBody> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidatemodel;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    autovalidatemodel = AutovalidateMode.disabled;
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
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
                  Text(
                    "Add more information",
                    style: AppStyles.normal18(context),
                  ),
                  const Expanded(child: SizedBox(height: 25)),
                  Column(
                    children: [
                      AuthTextField(
                        hintText: "First name",
                        controller: firstNameController,
                      ),
                      const SizedBox(height: 25),
                      AuthTextField(
                        hintText: "Last name",
                        controller: lastNameController,
                      ),
                      const SizedBox(height: 25),
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
