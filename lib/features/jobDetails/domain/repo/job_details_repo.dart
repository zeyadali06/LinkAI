import 'dart:io';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/data/models/job_application_model.dart';

abstract class JobDetailsRepo {
  Future<File> pickCv();
  Future<RequestResault> uploadCv(String id, File cv);
  Future<RequestResault> getApplicationStatus(String id);
  Future<RequestResault> updateApplicationStatus(String id);
  Future<RequestResault<List<InterviewHistoryItem>, Failed>> getJobInterviewsHistoryForHR(String jobId);
  Future<RequestResault<InterviewHistoryItem?, Failed>> getJobInterviewsHistoryForUser(String jobId);
  Future<RequestResault<List<JobApplicationModel>, Failed>> getJobApplications(String jobId);
}
