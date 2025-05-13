import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/role_view_body.dart';

class RoleView extends StatelessWidget {
  const RoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
        forceMaterialTransparency: true,
      ),
      body: const RoleViewBody(), //
    );
  }
}
