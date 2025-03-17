import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';

abstract class InterviewRepo {
  Future<RequestResault<String, Failed>> setupChat(JobModel jobModel);
  Future<RequestResault<dynamic, Failed>> sendMessage(String message, String chatId);
  Future<RequestResault<String, Failed>> sendVoice(String voicePath);
  Future<RequestResault<dynamic, Failed>> runVoice(String voicePath);
}
