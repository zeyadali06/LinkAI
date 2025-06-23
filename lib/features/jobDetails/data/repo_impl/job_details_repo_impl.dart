import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:linkai/core/failures/request_result.dart';
import 'package:linkai/core/services/api_manager.dart';
import 'package:linkai/core/utils/api_constants.dart';

import '../../../../core/failures/custom_failure.dart';
import '../../../../core/models/user_model.dart';
import '../../domain/repo/job_details_repo.dart';

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
  Future<RequestResault> getApplicationStatus(String id) async{
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
  Future<RequestResault>updateApplicationStatus(String id  )async{
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
}
