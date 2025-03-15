import 'package:linkai/core/failures/custom_failure.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/models/user_model.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';
import 'package:linkai/features/home/domain/repo/job_repo.dart';

class JobRepoImpl extends JobRepo {
  const JobRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<RequestResault> getJobs() async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        ApiConstants.getJobs,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(res["jobs"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to fetch jobs"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> addJob(JobModel job) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post(
        job.toJson(),
        ApiConstants.addJob,
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to add job"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> updateJob(JobModel job) async {
    try {
      final Map<String, dynamic> res = await _apiManager.patch(
        job.toJson(),
        "${ApiConstants.addJob}/${job.id}",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to update job"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> deleteJob(String jobId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.delete(
        "${ApiConstants.deleteJob}/$jobId",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to delete job"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
  @override
  Future<RequestResault> getJobsByCompanyId(String companyId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.get(
        "${ApiConstants.companies}/$companyId${ApiConstants.jobs}",
        token: UserModel.instance.token,
      );
      if (res["success"]) {
        return RequestResault.success(res["jobs"]);
      } else {

        return RequestResault.failure( CustomFailure("${res["message"]}"));
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
  @override
  Future<RequestResault> applyForJob(String jobId) async {
    try {
      final Map<String, dynamic> res = await _apiManager.post(
        {},
        "${ApiConstants.applyForJob}/$jobId/apply",
        token: UserModel.instance.token,
      );

      if (res["success"]) {
        return RequestResault.success(null);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to apply for job"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }
}
