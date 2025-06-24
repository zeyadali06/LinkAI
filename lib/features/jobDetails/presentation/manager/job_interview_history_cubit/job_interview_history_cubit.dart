import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/domain/repo/job_details_repo.dart';

part 'job_interview_history_state.dart';

class JobInterviewHistoryCubit extends Cubit<JobInterviewHistoryState> {
  JobInterviewHistoryCubit(this._jobRepo) : super(JobInterviewHistoryInitial());

  final JobDetailsRepo _jobRepo;

  Future<void> getJobInterviewHistoryForUser(String jobId) async {
    try {
      emit(JobInterviewHistoryLoading());

      final RequestResault result = await _jobRepo.getJobInterviewsHistoryForUser(jobId);

      if (result is Success) {
        emit(JobInterviewHistorySuccess(result.data));
      } else if (result is Failed) {
        emit(JobInterviewHistoryFailed(result.data.message));
      }
    } catch (_) {}
  }

  Future<void> getJobInterviewHistoryForHR(String jobId) async {
    try {
      emit(JobInterviewHistoryLoading());

      final RequestResault result = await _jobRepo.getJobInterviewsHistoryForHR(jobId);

      if (result is Success) {
        emit(JobInterviewHistoryListSuccess(result.data));
      } else if (result is Failed) {
        emit(JobInterviewHistoryFailed(result.data.message));
      }
    } catch (_) {}
  }
}
