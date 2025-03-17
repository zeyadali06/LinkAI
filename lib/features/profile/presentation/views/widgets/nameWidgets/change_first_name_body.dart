import 'package:flutter/cupertino.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';

class ChangeFirstNameBody extends StatelessWidget {
  const ChangeFirstNameBody({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          CustomTextField(
            borderRadius: 16,
            controller: controller,
            hintText: "First Name",
            enableValidator: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "First name is required";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
