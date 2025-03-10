import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/models/job_model.dart';

abstract class JobRepo {
  const JobRepo();

  Future<RequestResault> getJobs();
  Future<RequestResault> addJob(JobModel job);
  Future<RequestResault> updateJob(JobModel job);
  Future<RequestResault> deleteJob(String jobId);
  Future<RequestResault> applyForJob(String jobId);
}
