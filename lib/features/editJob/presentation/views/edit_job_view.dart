import 'package:flutter/material.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/editJob/presentation/views/widgets/edit_job_view_body.dart';

class EditJobView extends StatelessWidget {
  final JobModel jobModel;
  const EditJobView({super.key, required this.jobModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Job",
          style: AppStyles.semiBold18(context),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: EditJobViewBody(jobModel: jobModel),
    );
  }
}
