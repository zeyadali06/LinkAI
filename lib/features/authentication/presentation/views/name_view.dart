import 'package:flutter/material.dart';
import 'package:linkai/features/authentication/presentation/views/widgets/name_view_body.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NameViewBody(),
    );
  }
}
