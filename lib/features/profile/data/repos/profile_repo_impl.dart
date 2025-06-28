import 'package:image_picker/image_picker.dart';
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
        return RequestResault.failure(CustomFailure(response["msg"] ??
            response["message"] ??
            "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> addProfileImage(XFile? profileImage) async {
    try {
      final Map<String, dynamic> res = await _apiManager.uploadFile(
        ApiConstants.uploadProfileImage,
        profileImage!.path,
        token: UserModel.instance.token,
      );
      if (res["success"]) {
        UserModel.instance.setFromJson(res["data"]);
        return RequestResault.success(res["data"]);
      } else {
        return RequestResault.failure(
          const CustomFailure("Failed to add company images"),
        );
      }
    } catch (e) {
      return RequestResault.failure(
        const CustomFailure("Something went wrong!"),
      );
    }
  }

  @override
  Future<RequestResault> changeEmailCheckPassword(String pass) async {
    try {
      final response = await _apiManager.post({
        "password": pass,
      }, ApiConstants.changeEmailCheckPass, token: UserModel.instance.token);
      if (response["success"]) {
        return RequestResault.success(response["token"]);
      } else {
        return RequestResault.failure(CustomFailure(response["msg"] ??
            response["message"] ??
            "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> changeEmailSendOTP(
      String token, String newEmail) async {
    try {
      final response = await _apiManager.post({
        "token": token,
        "email": newEmail,
      }, ApiConstants.changeEmailSendOTP, token: UserModel.instance.token);
      if (response["success"]) {
        return RequestResault.success(response["message"]);
      } else {
        return RequestResault.failure(
            CustomFailure(response["message"] ?? "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> changeEmailEnterNewEmail(
      String otp, String newEmail) async {
    try {
      final response = await _apiManager.post({
        "otp": otp,
        "email": newEmail,
      }, ApiConstants.changeEmailEnterNewEmail, token: UserModel.instance.token);
      if (response["success"]) {
        UserModel.instance.email = newEmail;
        return RequestResault.success(response["message"]);
      } else {
        return RequestResault.failure(
            CustomFailure(response["message"] ?? "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }

  @override
  Future<RequestResault> deleteProfileImage() async {
    try {
      final response = await _apiManager.delete(ApiConstants.deleteProfilePic,
          token: UserModel.instance.token);
      if (response["success"]) {
        return RequestResault.success(response["message"]);
      } else {
        return RequestResault.failure(
            CustomFailure(response["message"] ?? "Some thing went wrong!"));
      }
    } catch (e) {
      return RequestResault.failure(
          const CustomFailure("Some thing went wrong!"));
    }
  }
}
