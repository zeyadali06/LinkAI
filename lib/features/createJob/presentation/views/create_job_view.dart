import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/features/createJob/presentation/views/widgets/create_job_view_body.dart';

class CreateJobView extends StatelessWidget {
  const CreateJobView({super.key, required this.companyModel});
  final CompanyModel companyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateJobViewBody(companyModel: companyModel),
    );
  }
}
