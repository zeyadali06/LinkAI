import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/companies/presentation/views/edit_company_view/widgets/edit_company_view_body.dart';

class EditCompanyView extends StatelessWidget {
  const EditCompanyView({super.key, required this.companyModel});
  final CompanyModel companyModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          companyModel.companyName,
          style: AppStyles.semiBold18(context),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: EditCompanyViewBody(companyModel: companyModel),
    );
  }
}
