import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/password_confirmation_view_body.dart';

class PasswordConfimationView extends StatelessWidget {
  const PasswordConfimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PasswordConfirmationViewBody(),
    );
  }
}
