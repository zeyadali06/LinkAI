import 'package:flutter/material.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';

class ChangeEmailPassBody extends StatelessWidget {
  const ChangeEmailPassBody({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          Text(
            "Your current email is",
            textAlign: TextAlign.center,
            style: AppStyles.normal16(context),
          ),
          const SizedBox(height: 8),
          Text(
            UserModel.instance.email!,
            style: AppStyles.semiBold18(context),
          ),
          const SizedBox(height: 28),
          CustomObsecureTextField(
            borderRadius: 16,
            controller: controller,
            hintText: "Password",
            enableValidator: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Password is required";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
