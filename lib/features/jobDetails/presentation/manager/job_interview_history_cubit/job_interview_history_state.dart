part of 'job_interview_history_cubit.dart';

@immutable
sealed class JobInterviewHistoryState {}

final class JobInterviewHistoryInitial extends JobInterviewHistoryState {}

final class JobInterviewHistoryLoading extends JobInterviewHistoryState {}

final class JobInterviewHistoryListSuccess extends JobInterviewHistoryState {
  final List<InterviewHistoryItem> models;

  JobInterviewHistoryListSuccess(this.models);
}

final class JobInterviewHistorySuccess extends JobInterviewHistoryState {
  final InterviewHistoryItem? model;

  JobInterviewHistorySuccess(this.model);
}

final class JobInterviewHistoryFailed extends JobInterviewHistoryState {
  final String errMessage;

  JobInterviewHistoryFailed(this.errMessage);
}
