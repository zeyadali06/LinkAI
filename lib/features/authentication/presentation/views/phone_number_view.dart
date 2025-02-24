import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/phone_number_view_body.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PhoneNumberViewBody(),
    );
  }
}
