import 'package:flutter/material.dart';
import 'package:linkai/features/createJob/presentation/views/widgets/create_job_view_body.dart';

class CreateJobView extends StatelessWidget {
  const CreateJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateJobViewBody(),
    );
  }
}
