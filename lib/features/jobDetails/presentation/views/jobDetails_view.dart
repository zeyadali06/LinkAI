import 'package:flutter/material.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/jobDetails_view_body.dart';

class JobdetailsView extends StatelessWidget {
  const JobdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: JobdetailsViewBody(
            title: "",
            company: '',
            companyLocation: '',
            experience: '',
            technicalSkills: '',
            description: '',
            timeAgo: '',
            workingTime: '',
            workLocation: ''));
  }
}
