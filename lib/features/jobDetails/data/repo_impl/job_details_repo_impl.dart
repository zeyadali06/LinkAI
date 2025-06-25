import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/jobDetails/data/models/interview_history_item.dart';
import 'package:linkai/features/jobDetails/data/models/job_application_model.dart';
import 'package:linkai/features/jobDetails/domain/repo/job_details_repo.dart';

class JobDetailsRepoImpl implements JobDetailsRepo {
  final ApiManager _apiManager;

  const JobDetailsRepoImpl(this._apiManager);

  @override
  Future<File> pickCv() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      return File(result!.files.single.path!);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RequestResault> uploadCv(String id, File cv) async {
    try {
      final Map<String, dynamic> res = await _apiManager.uploadCv(
        "${ApiConstants.uploadCv}/$id",
        cv.path,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          CustomFailure("Failed to upload CV ${res["message"]}"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong"),
      );
    }
  }

  @override
  Future<RequestResault> getApplicationStatus(String id) async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        "${ApiConstants.getApplicationStatus}/$id",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(res["data"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to fetch job details"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        CustomFailure("Something went wrong! ${e.toString()}"),
      );
    }
  }

  @override
  Future<RequestResault> updateApplicationStatus(String id) async {
    try {
      final Map<String, dynamic> res = await _apiManager.patch(
        {},
        "${ApiConstants.updateApplicationStatus}/$id",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure(""),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong"),
      );
    }
  }

  @override
  Future<RequestResault<List<InterviewHistoryItem>, Failed>> getJobInterviewsHistoryForHR(String jobId) async {
    try {
      final Map<String, dynamic> interviews = await _apiManager.get(
        "${ApiConstants.interviews}/interview/$jobId",
        token: UserModel.instance.token,
      );

      if (interviews["success"]) {
        return RequestResault.success(List<InterviewHistoryItem>.generate(
          interviews["data"].length,
          (index) {
            return InterviewHistoryItem.fromJson(interviews["data"][index]);
          },
        )..sort((a, b) => b.score.compareTo(a.score)));
      } else {
        return RequestResault.failure(const CustomFailure("Error, try again!"));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Something went wrong"));
    }
  }

  @override
  Future<RequestResault<InterviewHistoryItem?, Failed>> getJobInterviewsHistoryForUser(String jobId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        "${ApiConstants.interviews}/$jobId",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(InterviewHistoryItem.fromJson(res["data"]));
      } else if (res["message"] == "Cannot read properties of null (reading 'userId')") {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(const CustomFailure("Error, try again!"));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Something went wrong"));
    }
  }

  @override
  Future<RequestResault<List<JobApplicationModel>, Failed>> getJobApplications(String jobId) async {
    try {
      final Map<String, dynamic> applications = await _apiManager.get(
        "${ApiConstants.getJobApplications}/$jobId",
        token: UserModel.instance.token,
      );

      if (applications["success"]) {
        return RequestResault.success(List<JobApplicationModel>.generate(
          applications["applications"].length,
          (index) {
            return JobApplicationModel.fromJson(applications["applications"][index]);
          },
        ));
      } else {
        return RequestResault.failure(const CustomFailure("Error, try again!"));
      }
    } catch (e) {
      return RequestResault.failure(const CustomFailure("Something went wrong"));
    }
  }
}
