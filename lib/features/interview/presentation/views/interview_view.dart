import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/interview/presentation/views/widgets/interview_view_body.dart';

class InterviewView extends StatelessWidget {
  const InterviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          "New Interview",
          style: AppStyles.semiBold18(context),
        ),
      ),
      body: const InterviewViewBody(),
    );
  }
}
