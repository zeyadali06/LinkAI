part of 'interview_cubit.dart';

@immutable
sealed class InterviewState {}

final class InterviewInitial extends InterviewState {}

final class InterviewLoading extends InterviewState {}

final class InterviewSuccess extends InterviewState {}

final class InterviewFinishInterview extends InterviewState {
  final ScoreModel score;

  InterviewFinishInterview(this.score);
}

final class InterviewAnswer extends InterviewState {
  final String response;

  InterviewAnswer(this.response);
}

final class InterviewGetChatId extends InterviewState {
  final String chatId;

  InterviewGetChatId(this.chatId);
}

final class InterviewFailed extends InterviewState {
  final String errorMessage;

  InterviewFailed(this.errorMessage);
}
