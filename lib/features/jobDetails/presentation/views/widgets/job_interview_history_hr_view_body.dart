import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';

class JobInterviewHistoryHRViewBody extends StatelessWidget {
  const JobInterviewHistoryHRViewBody({super.key, required this.items});

  final List<InterviewHistoryItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          "no interviews made yet",
          style: AppStyles.semiBold16(context),
        ),
      );
    } else {
      return const Placeholder();
    }
  }
}
