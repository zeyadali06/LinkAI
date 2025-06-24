import 'dart:io';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';

abstract class JobDetailsRepo {
  Future<File> pickCv();

  Future<RequestResault> uploadCv(String id, File cv);
  Future<RequestResault> getApplicationStatus(String id);
  Future<RequestResault> updateApplicationStatus(String id);
  Future<RequestResault<List<InterviewHistoryItem>, Failed>> getJobInterviewsHistoryForHR(String jobId);
  Future<RequestResault<InterviewHistoryItem?, Failed>> getJobInterviewsHistoryForUser(String jobId);
}
