import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/services/audio_manager.dart';
import 'package:linkai/features/interview/domain/repositories/interview_repo.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  InterviewCubit(this._interviewRepo) : super(InterviewInitial());

  final InterviewRepo _interviewRepo;
  late AudioManager _audioManager;
  final List<String> chat = [];
  String fileName = "audio.wav";
  Codec codec = Codec.pcm16WAV;

  Future<void> setupChat(JobModel jobModel) async {
    try {
      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.setupChat(jobModel);

      if (res is Success) {
        emit(InterviewGetChatId(res.data));
      } else if (res is Failed) {
        emit(InterviewFailed(res.data.message));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<void> sendMessage(String message, String chatId) async {
    try {
      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.sendMessage(message, chatId);

      if (res is Success) {
        chat.add(res.data);
        emit(InterviewAnswer(res.data));
      } else if (res is Failed) {
        emit(InterviewFailed(res.data.message));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }

  Future<String> startRecord() async {
    try {
      emit(InterviewLoading());
      _audioManager = AudioManager(fileName, codec);
      final String filePath = await _audioManager.startRecording();
      emit(InterviewSuccess());
      return filePath;
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
      return "";
    }
  }

  Future<String> stopRecording() async {
    try {
      emit(InterviewLoading());
      _audioManager = AudioManager(fileName, codec);
      final String filePath = await _audioManager.stopRecording();
      await _audioManager.startPlayAudio();

      emit(InterviewSuccess());
      return filePath;
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
      return "";
    }
  }

  Future<void> sendVoice(String voicePath) async {
    try {
      emit(InterviewLoading());
      final RequestResault res = await _interviewRepo.sendVoice(voicePath);

      if (res is Success) {
        emit(InterviewAnswer(res.data));
      } else if (res is Failed) {
        emit(InterviewFailed(res.data.message));
      }
    } catch (e) {
      emit(InterviewFailed("Error try again!"));
    }
  }
}
