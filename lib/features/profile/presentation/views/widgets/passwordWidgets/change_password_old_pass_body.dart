import 'package:flutter/material.dart';
import 'package:linkai/core/widgets/custom_obsecure_text_field.dart';

class ChangePasswordOldPassBody extends StatelessWidget {
  const ChangePasswordOldPassBody({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          CustomObsecureTextField(
            borderRadius: 16,
            controller: controller,
            hintText: "Current password",
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
