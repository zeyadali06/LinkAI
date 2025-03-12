import 'package:flutter/material.dart';
import 'package:linkai/core/models/user_model.dart';

class AllCompaniesView extends StatelessWidget {
  const AllCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserModel.instance.token);
    return const Scaffold();
  }
}