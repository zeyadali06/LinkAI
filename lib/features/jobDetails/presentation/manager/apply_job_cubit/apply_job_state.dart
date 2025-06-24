part of 'apply_job_cubit.dart';

@immutable
sealed class ApplyJobState {}

final class ApplyJobInitial extends ApplyJobState {}

final class ApplyJobLoading extends ApplyJobState {}

final class ApplyJobError extends ApplyJobState {}

final class ApplyJobApplied extends ApplyJobState {}

final class ApplyJobNone extends ApplyJobState {}

final class ApplyJobInterviewed extends ApplyJobState {}
