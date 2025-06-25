import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/job_interview_history_user_view_body.dart';
import 'package:url_launcher/url_launcher.dart';

class JobInterviewHistoryItemView extends StatelessWidget {
  const JobInterviewHistoryItemView({super.key, required this.item});

  final InterviewHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Interview History",
          style: AppStyles.semiBold18(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.user.firstName} ${item.user.lastName}",
                    style: AppStyles.bold18(context),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.user.username,
                        style: AppStyles.defaultStyle(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.user.email,
                        style: AppStyles.defaultStyle(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (item.user.mobileNumber != null)
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.user.mobileNumber!,
                          style: AppStyles.defaultStyle(context),
                        ),
                      ],
                    ),
                  const SizedBox(height: 6),
                  if (item.cvLink != null && item.cvLink!.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        try {
                          final uri = Uri.parse(item.cvLink!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        } catch (_) {}
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 16,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "View CV",
                            style: AppStyles.defaultStyle(context, Colors.blue.shade700).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            JobInterviewHistoryUserViewBody(item: item),
          ],
        ),
      ),
    );
  }
}
