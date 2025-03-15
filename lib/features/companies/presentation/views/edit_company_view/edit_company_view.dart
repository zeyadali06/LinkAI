import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/features/companies/presentation/views/edit_company_view/widgets/edit_company_view_body.dart';

class EditCompanyView extends StatelessWidget {
  const EditCompanyView({super.key, required this.companyModel});
  final CompanyModel companyModel;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(companyModel.companyName),
      ),
      body: EditCompanyViewBody(companyModel: companyModel),
    );
  }
}