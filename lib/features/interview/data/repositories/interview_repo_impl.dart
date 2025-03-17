import 'dart:developer';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/interview_message_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/core/services/models_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';

class InterviewRepoImpl extends InterviewRepo {
  InterviewRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<RequestResault<String, Failed>> setupChat(JobModel jobModel) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post({}, ApiConstants.startChat, baseUrl: ApiConstants.modelsBaseURL);

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

      if ((res["response"] as String).contains("Score:") && (res["response"] as String).contains("Summary:")) {
        late final double score;
        late final String summary;

        final scoreMatch = RegExp(r'Score:\s*(\d+)').firstMatch(res["response"]);
        final summaryMatch = RegExp(r'Summary:\s*(.*)').firstMatch(res["response"]);

        if (scoreMatch != null) {
          score = double.parse(scoreMatch.group(1)!);
          log('Extracted score: $score');
        }
        if (summaryMatch != null) {
          summary = summaryMatch.group(1)?.trim() ?? "";
          log('Extracted summary: $summary');
        }

        return RequestResault.success(ScoreModel(score: score, summary: summary));
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
