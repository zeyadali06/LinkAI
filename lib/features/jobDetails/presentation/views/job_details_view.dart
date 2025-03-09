import 'package:flutter/material.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_details_view_body.dart';

class JobdetailsView extends StatelessWidget {
  const JobdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JobdetailsViewBody(
        jobModel: JobModel.init(),
      ),
    );
  }
}
