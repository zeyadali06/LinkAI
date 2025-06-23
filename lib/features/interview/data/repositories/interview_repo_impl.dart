import 'package:flutter_sound/flutter_sound.dart';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/interview_message_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/core/services/models_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';

class InterviewRepoImpl extends InterviewRepo {
  InterviewRepoImpl(this._apiManager);

  final ApiManager _apiManager;
  late DateTime _interviewDuration;
  late JobModel _jobModel;

  @override
  Future<RequestResault<String, Failed>> setupInterview(JobModel jobModel) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post({}, ApiConstants.startChat, baseUrl: ApiConstants.modelsBaseURL);

      _interviewDuration = DateTime.now();
      _jobModel = jobModel;

      return RequestResault.success(res["chat_id"]);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error while setup chat!"));
    }
  }

  @override
  Future<RequestResault<dynamic, Failed>> sendMessage(String message, String chatId) async {
    try {
      final Map<String, dynamic> body = {
        "message": message,
        "chat_id": chatId,
      };

      final Map<String, dynamic> res = await _apiManager.post(body, ApiConstants.sendMessage, baseUrl: ApiConstants.modelsBaseURL);

      if (res["response"] != null) {
        res["response"] = (res["response"] as String).trim().replaceAll("\n", " ").replaceAll(RegExp(r'\s+'), ' ');
      }

      if (res["summary"] != null) {
        return await finishInterview(res);
      }

      if (res.containsKey("error")) {
        return RequestResault.failure(InterviewMessageFailure(res["error"]));
      }

      return RequestResault.success(res["response"]);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error try again!"));
    }
  }

  @override
  Future<RequestResault<ScoreModel, Failed>> finishInterview(dynamic res) async {
    final ScoreModel scoreModel = ScoreModel.fromJson(
      res,
      DateTime.now().difference(_interviewDuration).inSeconds,
    );

    final Map<String, dynamic> response = await _apiManager.post(
      scoreModel.toMap(),
      "${ApiConstants.interviews}/${_jobModel.id}",
      baseUrl: ApiConstants.baseURL,
      token: UserModel.instance.token,
    );

    if (response["success"]) {
      return RequestResault.success(scoreModel);
    } else {
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

  @override
  Future<RequestResault<dynamic, Failed>> runVoice(String voicePath) async {
    try {
      const ModelsManager manager = ModelsManager("123456789");
      final String filePath = await manager.textToVoice(voicePath);
      final AudioManager audio = AudioManager();
      await audio.init();
      audio.setData(codec: Codec.mp3, fileName: filePath);
      await audio.play();
      return RequestResault.success(null);
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Error try again!"));
    }
  }
}
