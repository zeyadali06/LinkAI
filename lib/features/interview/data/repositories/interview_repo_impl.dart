import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/services/models_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';

class InterviewRepoImpl extends InterviewRepo {
  InterviewRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<RequestResault<String, Failed>> setupChat(JobModel jobModel) async {
    try {
      final String jobString =
          "Job Title: ${jobModel.title}\n Job Description: ${jobModel.description}\n Experience: ${jobModel.experience}\n Technical Skills: ${jobModel.technicalSkills}\n Soft Skills: ${jobModel.softSkills}";

      final Map<String, dynamic> res = await _apiManager.post({}, ApiConstants.startChat, baseUrl: ApiConstants.modelsBaseURL);
      await sendMessage(jobString, res["chat_id"]);

      return RequestResault.success(res["chat_id"]);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error while setup chat!"));
    }
  }

  @override
  Future<RequestResault<String, Failed>> sendMessage(String message, String chatId) async {
    try {
      final Map<String, dynamic> body = {
        "message": message,
        "chat_id": chatId,
      };
      final Map<String, dynamic> res = await _apiManager.post(body, ApiConstants.sendMessage);

      if (res["response"] != null) {
        res["response"].replaceAll("\n", " ");
      }

      return RequestResault.success(res["response"]);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error try again!"));
    }
  }

  @override
  Future<RequestResault<String, Failed>> sendVoice(String voicePath) async {
    try {
      const ModelsManager manager = ModelsManager("123456789");
      final String response = await manager.voiceToText(voicePath);

      return RequestResault.success(response);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error try again!"));
    }
  }
}
