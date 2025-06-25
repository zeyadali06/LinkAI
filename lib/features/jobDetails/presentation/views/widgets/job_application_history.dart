import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_user.dart';
import 'package:linkai/features/jobDetails/data/models/job_application_model.dart';
import 'package:url_launcher/url_launcher.dart';

class JobApplicationHistory extends StatelessWidget {
  const JobApplicationHistory({super.key, required this.items});

  final List<JobApplicationModel> items;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'interviewed':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'applied':
        return Colors.orange;
      default:
        return Colors.transparent;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

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
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final JobApplicationModel item = items[index];
          final User user = item.user;

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Theme.of(context).cardColor,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Chip(
                        backgroundColor: _getStatusColor(item.status),
                        label: Text(
                          item.status.toUpperCase(),
                          style: AppStyles.defaultStyle(context, Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: AppStyles.defaultStyle(context, Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () async {
                          try {
                            final uri = Uri.parse(item.cvUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          } catch (_) {}
                        },
                        child: Text(
                          "View CV",
                          style: AppStyles.defaultStyle(context, Colors.blue).copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Applied on: ${_formatDate(item.createdAt)}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
