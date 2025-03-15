import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/features/companies/presentation/views/company_details_view/widgets/company_details_view_body.dart';

class CompanyDetailsView extends StatelessWidget {
  const CompanyDetailsView({super.key, required this.company});

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(company.companyName),
          centerTitle: true,
        ),
        body: CompanyDetailsViewBody(company: company),
      ),
    );
  }


}
