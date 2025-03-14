import 'package:flutter/material.dart';
import 'package:linkai/features/companies/presentation/views/add_company_view/widgets/add_company_body.dart';

class AddCompanyView extends StatelessWidget {
  const AddCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Company'),
        centerTitle: true,
      ),
      body: const AddCompanyBody(),
    );
  }
}