import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/createJob/presentation/views/widgets/create_job_view_body.dart';

class CreateJobView extends StatelessWidget {
  const CreateJobView({super.key, required this.companyModel});
  final CompanyModel companyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Create Job",
          style: AppStyles.semiBold18(context),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: CreateJobViewBody(companyModel: companyModel),
    );
  }
}
