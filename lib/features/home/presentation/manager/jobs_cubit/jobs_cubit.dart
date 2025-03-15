import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import '../../../data/repo/job_repo_impl.dart';
import '../../../domain/repo/job_repo.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsInitial());
  final JobRepo _jobRepo = const JobRepoImpl(ApiManager());

  Future<void> getJobs() async {
    emit(JobsLoading());
    final result = await _jobRepo.getJobs();
    if (result is Success) {
      try {
        final List<JobModel> jobs = [];
        for (var job in result.data) {
          jobs.add(JobModel.fromJson(job));
        }
        emit(JobsLoaded(jobs));
      } catch (e) {
        emit(JobsError(e.toString()));
      }
    } else if (result is Failed) {
      emit(JobsError(result.data.message));
    }
  }

  Future<void> getJobsByCompanyId(String companyId) async {
    emit(JobsLoading());
    final result = await _jobRepo.getJobsByCompanyId(companyId);
    if (result is Success) {
      try {
        final List<JobModel> jobs = [];
        debugPrint(result.data);
        for (var job in result.data) {
          jobs.add(JobModel.fromJson(job));
        }
        emit(JobsLoaded(jobs));
      } catch (e) {
        emit(JobsError(e.toString()));
      }
    } else if (result is Failed) {
      emit(JobsError(result.data.message));
    }
  }
}
