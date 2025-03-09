import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/password_confirmation_view_body.dart';

class PasswordConfimationView extends StatelessWidget {
  const PasswordConfimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
        forceMaterialTransparency: true,
      ),
      body: const PasswordConfirmationViewBody(),
    );
  }
}
