import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/utils/app_router.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_user.dart';

class JobInterviewHistoryHR extends StatelessWidget {
  const JobInterviewHistoryHR({super.key, required this.items});

  final List<InterviewHistoryItem> items;

  String formatDuration(int duration) {
    Duration d = Duration(seconds: duration);
    return "${d.inMinutes}m ${d.inSeconds % 60}s";
  }

  String formatDate(DateTime date) {
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
          final InterviewHistoryItem item = items[index];
          final User user = item.user;

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  "${item.score * 10}%",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.email,
                    style: AppStyles.defaultStyle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Duration: ${formatDuration(item.duration)}",
                    style: AppStyles.defaultStyle(context),
                  ),
                  Text(
                    "Date: ${formatDate(item.createdAt)}",
                    style: AppStyles.defaultStyle(context),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.jobInterviewHistoryItemView, extra: item);
                },
              ),
            ),
          );
        },
      );
    }
  }
}
