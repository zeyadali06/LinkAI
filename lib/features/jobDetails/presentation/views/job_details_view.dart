import 'package:flutter/material.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_details_view_body.dart';

class JobdetailsView extends StatelessWidget {
  const JobdetailsView({super.key, required this.jobModel});
  final JobModel jobModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Job Details",
          style: AppStyles.semiBold18(context),
        ),
      ),
      body: JobdetailsViewBody(jobModel: jobModel),
    );
  }
}
