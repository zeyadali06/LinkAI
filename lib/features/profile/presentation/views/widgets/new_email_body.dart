import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class NewEmailBody extends StatelessWidget {
  const NewEmailBody({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(

          children: [
            Text(
              "Please enter a new email and we will send you",
              style: AppStyles.normal16(context, Colors.white).copyWith(fontSize: 14),
            ),
            Text(
              "a verification code",
              style: AppStyles.normal16(context, Colors.white).copyWith(fontSize: 14),
            ),
            SizedBox(height: 28,),
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
      ),
    );
  }
}
