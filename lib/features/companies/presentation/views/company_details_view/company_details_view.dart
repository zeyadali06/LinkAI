import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Theme.of(context).iconTheme.color,
          forceMaterialTransparency: true,
          title: Text(
            company.companyName,
            style: AppStyles.semiBold18(context),
          ),
          centerTitle: true,
        ),
        body: CompanyDetailsViewBody(company: company),
      ),
    );
  }
}
