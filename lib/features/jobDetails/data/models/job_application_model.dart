import 'package:linkai/features/jobDetails/data/models/interview_history_user.dart';

class JobApplicationModel {
  final String id;
  final String jobId;
  final User user;
  final String cvUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobApplicationModel({
    required this.id,
    required this.jobId,
    required this.user,
    required this.cvUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['_id'],
      jobId: json['jobId'],
      user: User.fromJson(json['userId']),
      cvUrl: json['userCV']['secure_url'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'jobId': jobId,
      'userId': user.toMap(),
      'userCV': {
        'secure_url': cvUrl,
      },
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
