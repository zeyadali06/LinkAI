import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/utils/formatters.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';

class NewEmailBody extends StatelessWidget {
  const NewEmailBody({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          Text(
            "Please enter a new email and we will send you a verification code",
            textAlign: TextAlign.center,
            style: AppStyles.defaultStyle(context),
          ),
          const SizedBox(height: 28),
          CustomTextField(
            borderRadius: 16,
            controller: controller,
            hintText: "Enter new email",
            enableValidator: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return " Email is required";
              }
              if (!RegExp(Formatters.emailRegEx).hasMatch(value)) {
                return "Enter valid email!";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
