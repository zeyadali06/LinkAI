part of 'jobs_cubit.dart';

@immutable
sealed class JobsState {}

final class JobsInitial extends JobsState {}

final class JobsLoading extends JobsState {}

final class JobsLoaded extends JobsState {
  final List<JobModel> jobs;
  JobsLoaded(this.jobs);
}

final class JobCreated extends JobsState {
  final JobModel job;
  JobCreated(this.job);
}

final class JobsError extends JobsState {
  final String message;
  JobsError(this.message);
}
