import 'package:linkai/features/jobDetails/data/models/interview_history_message.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_user.dart';

class InterviewHistoryItem {
  final String id;
  final String jobId;
  final User user;
  final List<Message> chat;
  final String summary;
  final int score;
  final int duration;

  InterviewHistoryItem({
    required this.id,
    required this.jobId,
    required this.user,
    required this.chat,
    required this.summary,
    required this.score,
    required this.duration,
  });

  factory InterviewHistoryItem.fromJson(Map<String, dynamic> json) {
    return InterviewHistoryItem(
      id: json['id'] ?? json['_id'],
      jobId: json['jobId'],
      user: User.fromJson(json['userId']),
      chat: (json['chat'] as List<dynamic>).map((e) => Message.fromJson(e)).toList(),
      summary: json['summary'],
      score: json['score'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobId': jobId,
      'userId': user.toMap(),
      'chat': chat.map((e) => e.toMap()).toList(),
      'summary': summary,
      'score': score,
      'duration': duration,
    };
  }
}
