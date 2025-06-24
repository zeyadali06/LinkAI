import 'package:flutter/material.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_message.dart';

class JobInterviewHistoryUserViewBody extends StatelessWidget {
  const JobInterviewHistoryUserViewBody({super.key, this.item});

  final InterviewHistoryItem? item;

  String formatDuration(int totalSeconds) {
    Duration d = Duration(seconds: totalSeconds);
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "${minutes}m ${seconds}s";
  }

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Center(
        child: Text(
          "no interview made yet",
          style: AppStyles.semiBold16(context),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade100,
                    child: Text("${item!.score * 10}%", style: AppStyles.bold22(context, Colors.blue)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Duration",
                        style: AppStyles.bold18(context),
                      ),
                      Text(
                        formatDuration(item!.duration),
                        style: AppStyles.normal16(context),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Summary",
                style: AppStyles.bold18(context),
              ),
              const SizedBox(height: 8),
              Text(
                item!.summary,
                style: AppStyles.normal16(context),
              ),
              const SizedBox(height: 24),
              Text(
                "Chat",
                style: AppStyles.bold18(context),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item!.chat.length,
                itemBuilder: (context, index) {
                  final Message message = item!.chat[index];
                  final bool isUser = message.role.toLowerCase() == "user";
                  final bool isDark = Theme.of(context).brightness == Brightness.dark;
                  final Color backgroundColor = isUser ? (isDark ? Colors.grey.shade800 : Colors.grey.shade200) : (isDark ? Colors.blueGrey.shade700 : Colors.blue.shade50);
                  final Color nameColor = isUser ? (isDark ? Colors.grey : Colors.black) : (isDark ? Colors.lightBlueAccent : Colors.blue);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUser ? "You" : "AI",
                          style: AppStyles.bold14(context, nameColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.content,
                          style: AppStyles.defaultStyle(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
}
