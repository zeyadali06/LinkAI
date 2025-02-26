import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/password_view_body.dart';

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PasswordViewBody(),
    );
  }
}
