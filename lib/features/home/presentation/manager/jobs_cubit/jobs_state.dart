part of 'jobs_cubit.dart';

@immutable
sealed class JobsState {}

final class JobsInitial extends JobsState {}

final class JobsLoading extends JobsState {}

final class JobsLoaded extends JobsState {
  final List<JobModel> jobs;
  JobsLoaded(this.jobs);
}

final class JobCreated extends JobsState {}

final class JobsError extends JobsState {
  final String message;
  JobsError(this.message);
}

final class JobUpdated extends JobsState {
  final JobModel job;
  JobUpdated(this.job);
}

final class JobUpdatedError extends JobsState {
  final String message;
  JobUpdatedError(this.message);
}

final class JobDeleted extends JobsState {}

final class JobDeletedError extends JobsState {
  final String message;
  JobDeletedError(this.message);
}
