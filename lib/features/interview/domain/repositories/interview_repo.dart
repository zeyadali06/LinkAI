import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';

abstract class InterviewRepo {
  Future<RequestResault<String, Failed>> setupInterview(JobModel jobModel);
  Future<RequestResault<dynamic, Failed>> sendMessage(String message, String chatId);
  Future<RequestResault<ScoreModel, Failed>> finishInterview(dynamic res);
  Future<RequestResault<String, Failed>> sendVoice(String voicePath);
  Future<RequestResault<dynamic, Failed>> runVoice(String voicePath);
}
