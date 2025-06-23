import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/core/utils/service_locator.dart';
import 'package:linkai/features/interview/data/models/message_item_model.dart';
import 'package:linkai/features/interview/data/models/message_type_enum.dart';
import 'package:linkai/features/interview/data/models/score_model.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  InterviewCubit(this._interviewRepo, this._audioManager) : super(InterviewInitial());

  final InterviewRepo _interviewRepo;
  final AudioManager _audioManager;
  final List<MessageItemModel> chat = [];

  Future<void> setupChat(JobModel jobModel) async {
    try {
      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.setupInterview(jobModel);

      if (res is Success) {
        emit(InterviewGetChatId(res.data));

        await sendMessage(jobModel.getFullJobApplication(), res.data, addToChatList: false);
      } else if (res is Failed) {
        emit(InterviewFailed(res.data.message));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<void> startRecord() async {
    try {
      emit(InterviewLoading());
      _audioManager.setData();
      await _audioManager.record();
      emit(InterviewSuccess());
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<void> stopRecording() async {
    try {
      emit(InterviewLoading());
      ServiceLocator.getIt<AudioManager>().fileName = await _audioManager.stopRecorder();
      emit(InterviewSuccess());
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<void> sendMessage(String message, String chatId, {bool addToChatList = true}) async {
    try {
      if (addToChatList) {
        chat.add(MessageItemModel(message: message, type: MessageType.sended));
      }

      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.sendMessage(message, chatId);

      if (res is Success) {
        if (res.data is String) {
          chat.add(MessageItemModel(message: res.data, type: MessageType.recieved));
          await _interviewRepo.runVoice(res.data);
          emit(InterviewAnswer(res.data));
        } else if (res.data is ScoreModel) {
          emit(InterviewFinishInterview(res.data));
        }
      } else if (res is Failed) {
        emit(InterviewFailed(res.data));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<void> sendVoice(String voicePath, String chatId) async {
    try {
      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.sendVoice(voicePath);

      if (res is Success) {
        await sendMessage(res.data, chatId);

        emit(InterviewAnswer(res.data));
      } else if (res is Failed) {
        emit(InterviewFailed(res.data.message));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }
}
