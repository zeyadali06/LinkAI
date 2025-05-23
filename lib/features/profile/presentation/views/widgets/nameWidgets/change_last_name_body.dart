import 'package:flutter/cupertino.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';

class ChangeLastNameBody extends StatelessWidget {
  const ChangeLastNameBody({super.key, required this.controller});
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
            hintText: "Last Name",
            enableValidator: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Last name is required";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
