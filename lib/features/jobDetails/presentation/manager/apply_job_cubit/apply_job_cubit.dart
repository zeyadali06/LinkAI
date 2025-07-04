import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failures/request_result.dart';
import '../../../domain/repo/job_details_repo.dart';

part 'apply_job_state.dart';

class ApplyJobCubit extends Cubit<ApplyJobState> {
  final JobDetailsRepo _jobDetailsRepo;

  ApplyJobCubit(this._jobDetailsRepo) : super(ApplyJobInitial());

  Future<void> handleUserApplication(String jobId) async {
    emit(ApplyJobLoading());
    final result = await _jobDetailsRepo.getApplicationStatus(jobId);
    if (result is Success) {
      if (result.data == "not applied") {
        emit(ApplyJobNone());
      } else if (result.data == "applied") {
        emit(ApplyJobApplied());
      } else {
        emit(ApplyJobInterviewed());
      }
    } else {
      emit(ApplyJobError());
    }
  }

  Future<void> uploadCV(String id) async {
    try {
      final File cv = await _jobDetailsRepo.pickCv();
      emit(ApplyJobLoading());
      final res = await _jobDetailsRepo.uploadCv(id, cv);
      if (res is Success) {
        emit(ApplyJobApplied());
      } else {
        emit(ApplyJobError());
      }
    } catch (_) {}
  }

  Future<void> updateApplicationStatus(String id) async {
    emit(ApplyJobLoading());
    final res = await _jobDetailsRepo.updateApplicationStatus(id);
    if (res is Success) {
      emit(ApplyJobInterviewed());
    } else {
      emit(ApplyJobError());
    }
  }
}
