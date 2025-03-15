import 'package:injectable/injectable.dart';
import 'package:linkai/core/failures/request_result.dart';

import '../../../../core/failures/custom_failure.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/api_manager.dart';
import '../../../../core/utils/api_constants.dart';
import '../../domain/abstractRepos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiManager _apiManager;

  ProfileRepoImpl(this._apiManager);

  @override
  Future<RequestResault> changeName(String firstName, String lastName) async {
    try {
      final response = await _apiManager.patch({
        "firstName": firstName,
        "lastName": lastName,
      }, ApiConstants.changeName, token: UserModel.instance.token);
      if (response["success"]) {
        // UserModel.instance.setFromJson(response["user"]);
        UserModel.instance.firstName = firstName;
        UserModel.instance.lastName = lastName;
        return RequestResault.success(UserModel.instance.firstName);
      } else {
        return RequestResault.failure(
            const CustomFailure("Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final response = await _apiManager.patch({
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      }, ApiConstants.changePassword, token: UserModel.instance.token);
      if (response["success"]) {
        return RequestResault.success(response["msg"]);
      } else {
        return RequestResault.failure(
            CustomFailure(response["msg"] ?? response["message"] ?? "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }
}
